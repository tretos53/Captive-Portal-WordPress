## Captive Portal on Rapsberry Pi with WordPress. After reboot and connecting to the wifi you will be presented with Wordpress installation screen.

## Replace ALL Passwords with your own.

Image: 2019-04-08-raspbian-stretch-lite.zip

Below script will create an open wifi network and when you connect to it, it will automatically open the browser with wordpress. Make sure you don't have the internet on your device you are connecting it from. This is originally desinged to only provide local website from the RPI.

Tested on, without updating the system first, 2019-04-08-raspbian-stretch-lite.zip

Flash microsd card with etcher

Put an empty file called ssh with no extension onto the boot partition, this will enable ssh at first boot. No need for screen and keyboard.

Connect Pi to the ethernet network and boot.

Connect to the SSH and run below command. You can get the IP address from IP scanner.

```
sudo -i
```

```
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/captiveportal_wp.sh | sudo bash $0
```

If you want to specify SSID during installation run below command. If SSID is not specified CaptivePortal01 will be used.

```
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/tretos53/Captive-Portal-WordPress/master/captiveportal_wp.sh | sudo bash $0 SSID_OF_YOUR_CHOICE
```

#### Issues

If you get `nginx 502 bad gateway` error, check /var/log/nginx/error.log.
If the message is `to unix:/run/php/php7.0-fpm.sock failed (2: No such file or directory)` go to /run/php/, check if php7.0-fpm.sock exists, if the filename is different, update line 42 in /etc/nginx/sites-enabled/default and reboot.

#### To Do

Install https://wp-cli.org/

```
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
```


Automatically set the location as new RPI hardware requires that before enabling wifi

Add a time limit for each client. Disconnect client after 10minutes.

Disable ssh access on wifi interface

Test popup on other devices. Already works on Samsung S4, S7, S9, IPhone X and Blackberry

Add wifi name, passwords and WP database to be configured from the command line

Nginx security

#### Tested

Tested on most modern devices.

Iphone X

Samsung S4, S7, S9

Windows 7, 10

Nexus 5X (Lineage OS)

#### Popup Logic

Below sites needs to be resolvable to public IPs
connectivitycheck.gstatic.com
www.gstatic.com
www.apple.com
captive.apple.com
clients3.google.com

Those IPs needs to be NATed to the pi so basically NAT everything from WiFi to the RPI

Each device got it's own checks (to be updated)

#### Troubleshooting

Install and capture traffic using `tcpdump -i wlan0 -w filename.pcap`

Check nginx logs


#### Other

Find out which MAC addresses connected to the portal by finding all MAC addresses from the logs. Meantime solution untill I specify proper logs.

```


# Go to /var/logs/
cd /var/logs/

# Find all gz files and extract them
find . -name '*.gz' -execdir gunzip '{}' \;

# Find MAC addresses in all files and dont show duplicates and other stuff
grep -hoiIs '[0-9A-F]\{2\}\(:[0-9A-F]\{2\}\)\{5\}' * | sort -u


NGINX logs
# Go to /var/logs/
cd /var/logs/nginx/

# Find all unique IP addresses that connected to the website. This will show 192...
grep -hoiIs -E '([0-9]{1,3}[\.]){3}[0-9]{1,3}' * | sort -u

# Find all unique IP addresses that connected to the website. This will show more details, like what (kind of) device connected.
grep -E '([0-9]{1,3}[\.]){3}[0-9]{1,3}' * | sort -u```









