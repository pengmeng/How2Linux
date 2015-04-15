General Command
--------------------

### Generate SSH key
``` shell
> ssh-keygen -t rsa -C "your_email@example.com"
```

### tar
Create tar archive file
``` shell
> tar -cvf archivename.tar /archive/directory
```
Create tar.gz archive file
``` shell
> tar -zcvf archivename.tar /archive/directory
```
Create tar.bz2 archive file
``` shell
> tar -jcvf archivename.tar /archive/directory
```
Unarchive
``` shell
> tar -xvf archivename.tar
```

### find
Find file with name
``` shell
> find . -name name.ext
```
Find file with name ingoring case
``` shell
> find . -iname name.ext
```
Find file with name and type
``` shell
> find . -type d -name path
> find . -type f -name name.ext
```
Find files with permission and chmod to another permission
``` shell
> find . -type f -perm 0777 -print -exec chmod 644 {} \;
> find . -type d -perm 777 -print -exec chmod 644 {} \;
```
Find and remove file(s)
``` shell
> find . -type f -name "name.ext" -exec rm -f {} \;
> find . -type f -name "*.ext" -exec rm -f {} \;
```

### df
Show disk space usage in human readable format
``` shell
> df -h
```
Show information about a specific directory
``` shell
> df -hT /home
```

### netstat
List all ports (both TCP and UDP)
``` shell
> netstat -a | more
```
List only TCP or UDP port connections
``` shell
> netstat -at
> netstat -au
```
List all active listening ports (TCP or UDP) connections
``` shell
> netstat -l
> netstat -lt
> netstat -lu
```
Show statistics by protocol
``` shell
> netstat -s
> netstat -st
> netstat -su
```
Display kernel IP routing
``` shell
> netstat -r
```

### nslookup
Look for DNS server
``` shell
> nslookup google.com
> nslookup -port 56 google.com
```
Look for mail exchanger
``` shell
> nslookup -query=mx google.com
```
Look for domain server
``` shell
> nslookup -query=ns google.com
```
Look for DNS record
``` shell
> nslookup -type=any google.com
```

### dig
Query domain "A" record
``` shell
> dig google.com
> dig google.com +short
```
Query specific record for domain
``` shell
> dig google.com MX
> dig google.com SOA
> dig google.com TTL
```
DNS reverse look-up
``` shell
> dig -x 72.30.38.140 +short
```

### uptime
Show how long the system has been running

### w
Combination of 'uptime' and 'who'

Awk
--------------------
Use the output of netstat as example
``` shell
> cat netstat.txt
Proto Recv-Q Send-Q  Local Address          Foreign Address        (state)    
tcp4      37      0  dhcp-10-101-55-2.57321 client-14a.v.dro.https CLOSE_WAIT 
tcp4       0      0  dhcp-10-101-55-2.57317 ord08s11-in-f2.1.https ESTABLISHED
tcp4       0      0  dhcp-10-101-55-2.57316 ec2-46-137-116-1.https ESTABLISHED
tcp4       0      0  dhcp-10-101-55-2.57304 17.110.227.101.5223    ESTABLISHED
tcp4       0      0  dhcp-10-101-55-2.57302 17.110.224.20.5223     ESTABLISHED
tcp4       0      0  dhcp-10-101-55-2.57303 snt-re3-9a.sjc.d.https ESTABLISHED
tcp4      37      0  10.0.0.2.56038         server-54-230-89.https CLOSE_WAIT 
tcp4      37      0  10.0.0.2.55989         client-15b.v.dro.https CLOSE_WAIT 
tcp4      37      0  10.0.0.2.53596         client-12b.v.dro.https CLOSE_WAIT 
tcp4      37      0  dhcp-10-101-54-1.61837 server-54-230-33.https CLOSE_WAIT 
tcp4      37      0  dhcp-10-101-54-1.61760 client-15b.v.dro.https CLOSE_WAIT
```
awk sentence is in '{sentence}'
### Print
Print selected row in a file
``` shell
> awk '{print $1, $4}' netstat.txt
```
Format print just as C language
``` shell
> awk '{printf "%-8s %-8s %-8s %-22s %-22s %-22s\n", $1, $2, $3, $4, $5, $6}' netstat.txt
```
### Filter
Using compare operator same as C language
``` shell
> awk '$3==0 && $6=="ESTABLISHED"' netstat.txt
> awk '$2>0 {print $0}' netstat.txt
```
Preserve first line with inner variable NR
``` shell
> awk '$3==0 && $6=="ESTABLISHED" || NR==1' netstat.txt
```
### Inner Variable
|Name     |Description                        |
|---------|-----------------------------------|
|$0       |whole record                       |
|$1~$n    |Nth row                            |
|FS       |separator default is space or TAB  |
|NF       |number of rows in the whole record |
|NR       |column No. start from 1            |
|FNR      |column No. belongs to each file    |
|FILENAME |input file name                    |

Example: print column No.
``` shell
> awk '$3==0 && $6=="ESTABLISHED" || NR==1 {printf "%02s %s %-22s %-22s %s\n",NR, FNR, $4, $5, $6}' netstat.txt
```
Set separator
``` shell
> awk 'BEGIN{FS=":"} {print $1,$3,$6}' /etc/passwd
> awk -F: '{print $1, $3, $6}' /etc/passwd
> awk -F '[;:]'
> awk -F: '{print $1, $3, $6}' OFS="\t" /etc/passwd
```
