
# Windows上安装Telegraf: 

1. 下载安装包，https://dl.influxdata.com/telegraf/releases/telegraf-1.0.1_windows_amd64.zip    
2. 解压到c:\telegraf
3. 将样本配置文件telegraf.conf.windows.sample拷贝到c:\telegraf\telegraf.conf, 找到下列配置行，改成您的influxdb服务器的IP地址
```
   # XMeter: please replace the IP with your sutm (i.e. influxdb target)
   urls = ["http://a.b.c.d:8086"] # required
```
4. 启动telegraf
```
   C:\telegraf\telegraf.exe -config C:\telegraf\telegraf.conf
```


# Linux上安装collectd:

