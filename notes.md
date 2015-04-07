Notes
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

### rsync
A cool copy tool  
Will update later
