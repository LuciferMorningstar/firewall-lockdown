if [ `whoami` != 'root' ]
        then
        echo "This must be run as root."
        exit 1
fi

if [ $# -lt 1 ]
then
	MINUTES=3
else
	MINUTES=$1
fi

echo "Stopping firewall and allowing everyone for $MINUTES minutes"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

at now + $MINUTES minutes -f /usr/local/bin/lockdown.sh 
