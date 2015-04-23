General Command
--------------------
### ls
``` shell
> ls -F
> Applications/    Documents/       Library/         Music/
> ls -r #list reversed
```
ls in order of most recently modified
``` shell
> ls -ltr
```
ls in order of file size (descending)
``` shell
> ls -lS
```

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

### mdfind (MAC OSX)
Like find but using spotlight therefore much faster than find
``` shell
> mdfind -name homebrew
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
Reference: [Link](http://coolshell.cn/articles/9070.html)
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
### Match
Basic example and use like grep
``` shell
> awk '$6 ~ /EST/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" netstat.txt
> awk '/WAIT/' netstat.txt
```
Use pattern to match 'EST' or 'WAIT'
``` shell
> awk '$6 ~ /EST|WAIT/ || NR==1 {print NR, $4, $5, $6}' OFS="\t" netstat.txt
```
Use opposite of a pattern
``` shell
> awk '$6 !~ /EST/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" netstat.txt
> awk '!/EST/' netstat.txt
```
### Split
Split the file based on $6 and ignore first line
``` shell
> awk 'NR!=1 {print > $6}' netstat.txt
> ls
CLOSE_WAIT ESTABLISHED netstat.txt
```
Output selected rows to file
``` shell
> awk 'NR!=1 {print $4, $5 > $6}' netstat.txt
```
Using if-else-if control to split file
``` shell
> awk 'NR!=1 {if ($6 ~ /EST/) print > "1.txt";
else if ($6 ~ /WAIT/) print > "2.txt";
else print > "3.txt"}' netstat.txt
> ls ?.txt
1.txt       2.txt       CLOSE_WAIT  ESTABLISHED netstat.txt
```
### Special Usage
Find columns whose length in greater than 80 in file
``` shell
> awk 'length>80' file
```
Pring 9x9 table
``` shell
> seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}'
```

grep
--------------------
Reference: [Link](http://blog.jobbole.com/75410/)
### Basic
Based on grep 2.5.1-FreeBSD
``` shell
> grep --version | grep grep
grep (BSD grep) 2.5.1-FreeBSD
```
Using grep
``` shell
> cat WSJHandler.log | grep index
> grep index WSJHandler.log
```
Count number of lines that contains a specific keyword
``` shell
> grep index WSJHandler.log | wc -l
  547
> grep index WSJHandler.log -c
547
```

### With Regex Expression
Create a test file
``` shell
> cat test.txt
one two three
seven eight one eight three
thirteen fourteen fifteen
 sixteen seventeen eighteen seven
 sixteen seventeen eighteen
         twenty seven
         one 504 one
         one 503 one
         one     504     one
         one     504 one
#comment UP
         twentyseven
                 #comment down
                 twenty1
                 twenty3
                 twenty5
                 twenty7
```
Search lines that contains a word
``` shell
> grep -w 'seven' test.txt
seven eight one eight three
 sixteen seventeen eighteen seven
         twenty seven
```
Search lines that contains a word starting (ending) with a prefix (suffix)
``` shell
> grep '\<seven' test.txt
seven eight one eight three
 sixteen seventeen eighteen seven
 sixteen seventeen eighteen
         twenty seven
> grep 'seven\>' test.txt
seven eight one eight three
 sixteen seventeen eighteen seven
         twenty seven
         twentyseven
```
Search lines starting (ending) with a prefix (suffix)
``` shell
> grep '^seven' test.txt
seven eight one eight three
> grep 'seven$' test.txt
 sixteen seventeen eighteen seven
         twenty seven
         twentyseven
```
Show context of the result lines
``` shell
> grep -C 1 twentyseven test.txt
#comment UP
         twentyseven
                 #comment down
> grep -A 1 twentyseven test.txt
         twentyseven
                 #comment down
> grep -B 1 twentyseven test.txt
#comment UP
         twentyseven
```
Also
``` shell
> grep 'twenty[1-4]' test.txt
                 twenty1
                 twenty3
> grep 'twenty[^1-4]' test.txt
         twenty seven
         twentyseven
                 twenty5
                 twenty7
```
Use re to match IP address
``` shell
> grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /etc/resolv.conf
nameserver 129.105.49.1
nameserver 165.124.49.21
> grep -E '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b' /etc/resolv.conf
nameserver 129.105.49.1
nameserver 165.124.49.21
> grep -oE '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b' /etc/resolv.conf
129.105.49.1
165.124.49.21
```
### Reversely Search
``` shell
> ps -afx | grep bash
  501 14561 14560   0  3:43PM ttys000    0:00.07 -bash
  501 14966 14561   0  4:33PM ttys000    0:00.00 grep bash
  501   876   875   0 13Apr15 ttys001    0:00.06 -bash
  501   879   875   0 13Apr15 ttys002    0:00.01 -bash
  501   887   875   0 13Apr15 ttys003    0:00.07 -bash
  501  1395   875   0 13Apr15 ttys004    0:00.01 -bash
  501  1107   875   0 13Apr15 ttys005    0:00.01 -bash
  501  2039   875   0 13Apr15 ttys006    0:00.01 -bash
  501  2042   875   0 13Apr15 ttys007    0:00.01 -bash
  501  3962   875   0 14Apr15 ttys008    0:00.16 -bash
  501  4035   875   0 14Apr15 ttys009    0:00.12 -bash
  501  6177   875   0 Tue04PM ttys010    0:00.05 -bash
> ps -afx | grep bash | grep -v grep
  501 14561 14560   0  3:43PM ttys000    0:00.08 -bash
  501   876   875   0 13Apr15 ttys001    0:00.06 -bash
  501   879   875   0 13Apr15 ttys002    0:00.01 -bash
  501   887   875   0 13Apr15 ttys003    0:00.07 -bash
  501  1395   875   0 13Apr15 ttys004    0:00.01 -bash
  501  1107   875   0 13Apr15 ttys005    0:00.01 -bash
  501  2039   875   0 13Apr15 ttys006    0:00.01 -bash
  501  2042   875   0 13Apr15 ttys007    0:00.01 -bash
  501  3962   875   0 14Apr15 ttys008    0:00.16 -bash
  501  4035   875   0 14Apr15 ttys009    0:00.12 -bash
  501  6177   875   0 Tue04PM ttys010    0:00.05 -bash
```

### POSIX charset
```
[:alpha:] Any alphabetical character, regardless of case
[:digit:] Any numerical character
[:alnum:] Any alphabetical or numerical character
[:blank:] Space or tab characters
[:xdigit:] Hexadecimal characters; any number or A–F or a–f
[:punct:] Any punctuation symbol
[:print:] Any printable character (not control characters)
[:space:] Any whitespace character
[:graph:] Exclude whitespace characters
[:upper:] Any uppercase letter
[:lower:] Any lowercase letter
[:cntrl:] Control characters
```
``` shell
> grep "[[:upper:]]" test.txt
#comment UP
> grep --color "[[:upper:]]" test.txt
```
