# XMeter被测系统监控(SUTM)数据收集器的参考安装方法
## Windows上安装telegraf

1. 下载安装包，https://dl.influxdata.com/telegraf/releases/telegraf-1.0.1_windows_amd64.zip
2. 解压到c:\telegraf
3. 将样本配置文件telegraf.conf.windows.sample拷贝到c:\telegraf\telegraf.conf, 找到下列配置行，改成您的influxdb服务器的IP地址

	```bash
	# XMeter: please replace the IP with your sutm (i.e. influxdb target)
	urls = ["http://a.b.c.d:8086"] # required
	```

4. 启动telegraf

	```bash
	C:\telegraf\telegraf.exe -config C:\telegraf\telegraf.conf
	```

# 
## Linux上安装collectd
### CentOS 7.x / RHEL 7.x
1. 安装collectd

	```bash
	yum install -y epel-release
	yum install -y collectd
	```

2. 拷贝collectd.conf.centos7.sample到/etc/collectd.conf，找到下列配置行，改成您的influxdb服务器的IP地址

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

再根据您的被监控机实际情况，修改Hostname, Plugin disk及interface配置段的磁盘设备名(比如sda, vda)和网卡接口名称(比如eth0)

3. 启动collectd

	```
	systemctl enable collectd
	systemctl start collectd
	```

### CentOS 6.x / RHEL 6.x
1. 安装collectd

为方便使用，我们把安装包放在了项目的rpms目录。您也可以从https://pkg.ci.collectd.org/rpm 下载最新的collectd和collectd-disk安装包。

	```bash
	yum -y localinstall collectd*.rpm
	chkconfig collectd on  # 开机自动起服务
	```

2. 拷贝collectd.conf.centos6.sample到/etc/collectd.conf，找到下列配置行，改成您的influxdb服务器的IP地址

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

再根据您的被监控机实际情况，修改Hostname, Plugin disk及interface配置段的磁盘设备名(比如sda, vda)和网卡接口名称(比如eth0)

3. 启动collectd

	```
	/etc/init.d/collectd start
	```


### Ubuntu 16
1. 安装collectd

	```
	apt-get update
	apt-get install collectd
	```

2. 拷贝collectd.conf.ubuntu16.sample到/etc/collectd/collectd.conf, 找到下列配置行，改成您的influxdb服务器的IP地址。

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

再根据您的被监控机实际情况，修改Hostname, Plugin disk及interface配置段的磁盘设备名(比如sda, vda)和网卡接口名称(比如eth0)

	```
	<Plugin disk>
          Disk "vda"
	```

3. 启动collectd

	```
	systemctl enable collectd
	systemctl start collectd
	```

### Ubuntu 14
1. 卸载collectd

如果之前通过apt-get安装过collectd，缺省的安装版本为5.4.x，这个版本CPU插件功能还不是很完善，需要安装5.5以上版本的collectd。
首先查看您的Ubuntu上是否安装了collectd，使用下列命令：

	```
	dpkg -l collectd
	```

如果显示了以下的文字，说明没有安装过collectd，可以直接跳到下一步安装collectd 5.5

	```
	dpkg-query: no packages found matching collectd
	```

如果显示已经安装了collectd，则需要将其卸载，请使用以下的命令。

	```
	service collectd stop
	sudo apt-get remove collectd
	sudo apt-get remove --auto-remove collectd
	sudo apt-get purge collectd
	sudo apt-get purge collectd-core
	```

最后再次使用命令dpkg -l collectd来确认collectd已经被卸载。

2. 安装collectd

下载、编译和安装collectd-5.5.0

	```
	sudo apt-get install libcurl4-gnutls-dev
	cd /tmp/
	wget https://collectd.org/files/collectd-5.5.0.tar.bz2
	tar -jxf collectd-5.5.0.tar.bz2
	cd collectd-5.5.0

	sudo ./configure
	sudo make all install
	sudo wget -O /etc/init.d/collectd https://raw.githubusercontent.com/martin-magakian/collectd-script/master/collectd.init
	sudo chmod 744 /etc/init.d/collectd
	```

安装完成后，在/opt/下生成了collectd目录。

3. 配置

拷贝collectd.conf.ubuntu14.sample到/etc/collectd/collectd.conf，编辑/opt/collectd/etc/collectd.conf文件，找到下列配置行，改成您的influxdb服务器的IP地址。

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

另外，根据您的被监控机实际情况，修改Hostname, Plugin disk及interface配置段的磁盘设备名(比如sda, vda)和网卡接口名称(比如eth0)

	```
	<Plugin disk>
	  Disk "vda"
	```

4. 启动collectd服务

	```
	service collectd stop
	service collectd start
	```
### SuSE Linux

1. 安装collectd
拷贝collectd-572-bin.tar.gz到被测服务器/opt/目录下

	```
	tar -xvf collectd-572-bin.tar.gz
	```

2. 拷贝collectd.conf.suse.sample到/opt/collectd/etc/collectd.conf, 找到下列配置行，改成您的influxdb服务器的IP地址。

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

再根据您的被监控机实际情况，修改Hostname, Plugin disk及interface配置段的磁盘设备名(比如sda, vda)和网卡接口名称(比如eth0)

	```
	<Plugin disk>
          Disk "vda"
	```

3. 启动collectd

	```
	/opt/collectd/sbin/collectd
	```
