apt-get install git
curl -O https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz
sed -i '$a export PATH=$PATH:/usr/local/go/bin' $HOME/.profile
source $HOME/.profile

cd ~
git clone https://github.com/shadowsocks/v2ray-plugin.git
cd v2ray-plugin
go build
cp v2ray-plugin ~/go/bin/

touch /etc/rc.local
echo "#!/bin/sh -e" >> /etc/rc.local
echo "/home/jason_wu/go/bin/go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:123456@:80' -plugin v2ray-plugin -plugin-opts 'server' &" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
echo "EOF" >> /etc/rc.local
chmod +x /etc/rc.local

echo "[Install]" >> /lib/systemd/system/rc.local.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/rc.local.service
systemctl start rc-local