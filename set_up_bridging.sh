modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
