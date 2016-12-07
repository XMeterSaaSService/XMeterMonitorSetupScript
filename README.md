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

2. 拷贝collectd.conf.centos7.sample到/etc/collectd.conf
找到下列配置行，改成您的influxdb服务器的IP地址

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

3. 启动collectd

	```
	systemctl enable collectd
	systemctl start collectd
	```


### Ubuntu
1. 安装collectd

	```
	apt-get update
	apt-get install collectd
	```

2. 拷贝collectd.conf.ubuntu16.sample到/etc/collectd/collectd.conf
找到下列配置行，改成您的influxdb服务器的IP地址

	```
	<Plugin network>
	  # XMeter: please replace the IP with your sutm (i.e. influxdb target)
	  Server "a.b.c.d" "25826"
	```

3. 启动collectd

	```
	systemctl enable collectd
	systemctl start collectd
	```


