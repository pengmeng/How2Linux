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
