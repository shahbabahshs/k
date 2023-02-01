iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMPQUERY
iptables -I INPUT -p udp -m udp -m string --hex-string "|7374640000000000|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p tcp -m tcp -m string --hex-string "|000000005010|" --algo kmp --from 28 --to 29 -m length --length 40 -j DROP
iptables -A INPUT -p udp -m u32 --u32 "28 & 0x00FF00FF = 0x00200020 && 32 & 0x00FF00FF = 0x00200020 && 36 & 0x00FF00FF = 0x00200020 && 40 & 0x00FF00FF = 0x00200020"-j DROP
iptables -A INPUT -m string --algo bm --dari 28 --ke 29 --string "Apan Kontal" -j DROP
iptables -A INPUT -m u32 --u32 "28&0x00000FF0=0xFEDFFFFF" -j DROP
iptables -A INPUT -m u32 --u32 "12&0xFFFF=0xFFFF" -j DROP
iptables -A INPUT -p udp -m u32 --u32 "22&0xFFFF=0x0008" -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50 |" --algo kmp --dari 28 --ke 29 -j DROP iptables -I INPUT -p udp -m udp -m string --hex-string "|000000000000000000000000000000|" --algo kmp --dari 32 --ke 33 -j DROP
iptables -I INPUT -p udp \! -f -m udp --dport 7777 -m conntrack --ctstate NEW,ESTABLISHED -m u32 --u32 "0x0>>0x16&0x3c@0x8=0x53414d50" -j SAMPQUERY
iptables -A SAMPQUERY -p udp --sport 49152:65535 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A SAMPQUERY -j REJECT --reject-with icmp-port-unreachable
iptables -I INPUT  -s 66.55.155.101 -j ACCEPT
iptables -I INPUT  -s 66.55.155.0/24 -j ACCEPT
iptables -I INPUT  -s  82.192.84.116 -j ACCEPT
iptables -I INPUT  -s  82.192.84.0/24 -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type echo-reply -j DROP
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type port-unreachable -j DROP
iptables -I INPUT  -s 104.28.17.92 -j ACCEPT
iptables -I INPUT  -s 104.28.17.0/24 -j ACCEPT
iptables -I INPUT  -s 172.104.178.39 -j ACCEPT
iptables -I INPUT  -s 162.144.7.0/24 -j ACCEPT
iptables -I INPUT  -s 172.104.178.39 -j ACCEPT
iptables -I INPUT  -s 172.104.178.0/24 -j ACCEPT
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|' -m recent --name test ! --rcheck  -m recent --name test --set   -j  DROP
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|'  -m recent --name test --rcheck --seconds 2  --hitcount 1     -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|'  -m recent --name limitC7777 ! --rcheck  -m recent --name limitC7777 --set -j DROP
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|' -m recent --name limitC7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|'  -m recent --name limitI7777 ! --rcheck  -m recent --name limitI7777 --set
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|' -m recent --name limitI7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e72|'  -m recent --name limitR7777 ! --rcheck  -m recent --name limitR7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -t mangle -A PREROUTING -p icmp -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -t mangle -A PREROUTING -f -j DROP
iptables -t mangle -A PREROUTING -p ICMP -f -j DROP
iptables -t mangle -A PREROUTING -m state --state INVALID -j REJECT
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j REJECT
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j REJECT
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j REJECT
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j REJECT
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j REJECT
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j REJECT
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j REJECT
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j REJECT
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j REJECT
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j REJECT
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j REJECT
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j REJECT
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
iptables -t mangle -A PREROUTING -p icmp -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -t raw -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMPQUERY
iptables -I INPUT -p udp -m udp -m string --hex-string "|7374640000000000|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p tcp -m tcp -m string --hex-string "|000000005010|" --algo kmp --from 28 --to 29 -m length --length 40 -j DROP
iptables -A INPUT -p udp -m u32 --u32 "28 & 0x00FF00FF = 0x00200020 && 32 & 0x00FF00FF = 0x00200020 && 36 & 0x00FF00FF = 0x00200020 && 40 & 0x00FF00FF = 0x00200020"-j DROP
iptables -A INPUT -m string --algo bm --dari 28 --ke 29 --string "Apan Kontal" -j DROP
iptables -A INPUT -m u32 --u32 "28&0x00000FF0=0xFEDFFFFF" -j DROP
iptables -A INPUT -m u32 --u32 "12&0xFFFF=0xFFFF" -j DROP
iptables -A INPUT -p udp -m u32 --u32 "22&0xFFFF=0x0008" -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50 |" --algo kmp --dari 28 --ke 29 -j DROP iptables -I INPUT -p udp -m udp -m string --hex-string "|000000000000000000000000000000|" --algo kmp --dari 32 --ke 33 -j DROP
iptables -I INPUT -p udp \! -f -m udp --dport 7777 -m conntrack --ctstate NEW,ESTABLISHED -m u32 --u32 "0x0>>0x16&0x3c@0x8=0x53414d50" -j SAMPQUERY
iptables -A SAMPQUERY -p udp --sport 49152:65535 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A SAMPQUERY -j REJECT --reject-with icmp-port-unreachable
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -t mangle -A PREROUTING -f -j DROP
iptables -t mangle -A PREROUTING -p ICMP -f -j DROP
iptables -t mangle -A PREROUTING -m state --state INVALID -j RETURN
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j RETURN
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j RETURN
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j RETURN
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j RETURN
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j RETURN
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j RETURN
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j RETURN
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMPQUERY
iptables -I INPUT -p udp -m udp -m string --hex-string "|7374640000000000|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p tcp -m tcp -m string --hex-string "|000000005010|" --algo kmp --from 28 --to 29 -m length --length 40 -j DROP
iptables -A INPUT -p udp -m u32 --u32 "28 & 0x00FF00FF = 0x00200020 && 32 & 0x00FF00FF = 0x00200020 && 36 & 0x00FF00FF = 0x00200020 && 40 & 0x00FF00FF = 0x00200020"-j DROP
iptables -A INPUT -m string --algo bm --dari 28 --ke 29 --string "Apan Kontal" -j DROP
iptables -A INPUT -m u32 --u32 "28&0x00000FF0=0xFEDFFFFF" -j DROP
iptables -A INPUT -m u32 --u32 "12&0xFFFF=0xFFFF" -j DROP
iptables -A INPUT -p udp -m u32 --u32 "22&0xFFFF=0x0008" -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50 |" --algo kmp --dari 28 --ke 29 -j DROP iptables -I INPUT -p udp -m udp -m string --hex-string "|000000000000000000000000000000|" --algo kmp --dari 32 --ke 33 -j DROP
iptables -I INPUT -p udp \! -f -m udp --dport 7777 -m conntrack --ctstate NEW,ESTABLISHED -m u32 --u32 "0x0>>0x16&0x3c@0x8=0x53414d50" -j SAMPQUERY
iptables -A SAMPQUERY -p udp --sport 49152:65535 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A SAMPQUERY -j REJECT --reject-with icmp-port-unreachable
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p tcp --dport 1:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -t mangle -A PREROUTING -f -j DROP
iptables -t mangle -A PREROUTING -p ICMP -f -j DROP
iptables -t mangle -A PREROUTING -m state --state INVALID -j RETURN
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j RETURN
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j RETURN
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j RETURN
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j RETURN
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j RETURN
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j RETURN
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j RETURN
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMPQUERY
iptables -I INPUT -p udp -m udp -m string --hex-string "|7374640000000000|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50|" --algo kmp --from 28 --to 29 -j DROP
iptables -I INPUT -p tcp -m tcp -m string --hex-string "|000000005010|" --algo kmp --from 28 --to 29 -m length --length 40 -j DROP
iptables -A INPUT -p udp -m u32 --u32 "28 & 0x00FF00FF = 0x00200020 && 32 & 0x00FF00FF = 0x00200020 && 36 & 0x00FF00FF = 0x00200020 && 40 & 0x00FF00FF = 0x00200020"-j DROP
iptables -A INPUT -m string --algo bm --dari 28 --ke 29 --string "Apan Kontal" -j DROP
iptables -A INPUT -m u32 --u32 "28&0x00000FF0=0xFEDFFFFF" -j DROP
iptables -A INPUT -m u32 --u32 "12&0xFFFF=0xFFFF" -j DROP
iptables -A INPUT -p udp -m u32 --u32 "22&0xFFFF=0x0008" -j DROP
iptables -I INPUT -p udp -m udp -m string --hex-string "|53414d50 |" --algo kmp --dari 28 --ke 29 -j DROP iptables -I INPUT -p udp -m udp -m string --hex-string "|000000000000000000000000000000|" --algo kmp --dari 32 --ke 33 -j DROP
iptables -I INPUT -p udp \! -f -m udp --dport 7777 -m conntrack --ctstate NEW,ESTABLISHED -m u32 --u32 "0x0>>0x16&0x3c@0x8=0x53414d50" -j SAMPQUERY
iptables -A SAMPQUERY -p udp --sport 49152:65535 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A SAMPQUERY -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p icmp -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -A INPUT -f -j DROP
iptables -A INPUT -p ICMP -f -j DROP
iptables -A INPUT -m state --state INVALID -j REJECT
iptables -A INPUT -m conntrack --ctstate INVALID -j REJECT
iptables -A INPUT -p tcp ! --syn -m conntrack --ctstate NEW -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j REJECT
iptables -A INPUT -s 224.0.0.0/3 -j REJECT
iptables -A INPUT -s 169.254.0.0/16 -j REJECT
iptables -A INPUT -s 172.16.0.0/12 -j REJECT
iptables -A INPUT -s 192.0.2.0/24 -j REJECT
iptables -A INPUT -s 192.168.0.0/16 -j REJECT
iptables -A INPUT -s 10.0.0.0/8 -j REJECT
iptables -A INPUT -s 0.0.0.0/8 -j REJECT
iptables -A INPUT -s 240.0.0.0/5 -j REJECT
iptables -A INPUT -s 127.0.0.0/8 ! -i lo -j REJECT
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -A INPUT -p icmp -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -A INPUT -f -j DROP
iptables -A INPUT -p ICMP -f -j DROP
iptables -A INPUT -m state --state INVALID -j REJECT
iptables -A INPUT -m conntrack --ctstate INVALID -j REJECT
iptables -A INPUT -p tcp ! --syn -m conntrack --ctstate NEW -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j REJECT
iptables -A INPUT -s 224.0.0.0/3 -j REJECT
iptables -A INPUT -s 169.254.0.0/16 -j REJECT
iptables -A INPUT -s 172.16.0.0/12 -j REJECT
iptables -A INPUT -s 192.0.2.0/24 -j REJECT
iptables -A INPUT -s 192.168.0.0/16 -j REJECT
iptables -A INPUT -s 10.0.0.0/8 -j REJECT
iptables -A INPUT -s 0.0.0.0/8 -j REJECT
iptables -A INPUT -s 240.0.0.0/5 -j REJECT
iptables -A INPUT -s 127.0.0.0/8 ! -i lo -j REJECT
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p tcp --dport 1:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -t mangle -A PREROUTING -f -j DROP
iptables -t mangle -A PREROUTING -p ICMP -f -j DROP
iptables -t mangle -A PREROUTING -m state --state INVALID -j RETURN
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j RETURN
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j RETURN
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j RETURN
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j RETURN
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j RETURN
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j RETURN
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j RETURN
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
apt install ufw
iptables -L
echo "Antomic & Jxdn AntiDDoS"