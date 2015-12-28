Tricks & tips
=================

Linux tips
----------

### Recursively chmod directories only
find . -type d -exec chmod 755 {} \;

### Recursively chmod files only
find . -type f -exec chmod 644 {} \;

### Recursively rm *.tar.gz
find . -name "*.tar.gz" -exec rm {} \;

### Delete broken symlinks
find -L . -type l -delete

### Find big files 
find / -type f -size +20000k -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'

### Insert first line on a big file
sed -i '1iSET foreign_key_checks = 0;' big_file.sql

### Discover a disk UUID on ubuntu
blkid /dev/sdb1

### DD progress
watch -n5 'sudo kill -USR1 $(pgrep ^dd)'
[source](http://askubuntu.com/questions/215505/how-do-you-monitor-the-progress-of-dd)

### List ethernet interfaces
ip link show

### List fonts on linux
fc-list

### Extract a directory from a tarball archive
tar -xvzf mytar.ball.tar.gz -C /tmp/destination home/directory/to/get

### Merge multiple PDF into one
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf file1.pdf file2.pdf *.pdf

Images tips
-----------

### Rename photos by date
for i in $(ls *.JPG); do exiv2 -r '%Y%m%d.%H%M%S.:basename:' rename $i; done

### Batch resize photos to 50%
for i in $( ls *.jpg); do convert -resize 50% $i re_$i; done

### Optimize png & jpg size
find . -name "*.png" -exec advpng -4 -z {} \;
find . -name \*.jpg -exec jpegoptim -p {} \; -or -name \*.jpeg  -exec jpegoptim -p {} \;

Ubuntu & debian tips
--------------------

### apt-get speed limitation
apt-get -o Acquire::http::Dl-Limit=100 update && apt-get -o Acquire::http::Dl-Limit=100 dist-upgrade -y

### Make space and remove old kernels
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

### Reconfigure timezone
dpkg-reconfigure tzdata

### Check package version
apt-cache policy vlc

### Install specific version
apt-cache install vlc=2.0.6-1

GIT tips
--------

### Git reset bare repository to a specific commit
git update-ref refs/heads/mybranch 5c555555

### GIT diff last modified files
git diff --name-only 257f2068b4ca2ef38654381c47e329ed0f87ac32 HEAD

### Git local
git pull . master

### Git diff 2 branches
git diff master...branch2

### GIT Color 
git config color.ui true

### GIT Log in color
alias gitlog='git log --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'


PHP tips
--------

### Remove short open tags from old PHP files
find . -iname '*.php' -type f -print0 |xargs -0 sed -i -e 's/<? /<?php /g' -e 's/<?\/\//<?php \/\//g' -e 's/<?\/\*/<?php \/\*/g'
find . -iname '*.php' -type f -print0 |xargs -0 sed -i -e ':a;N;$!ba;s/<?\n/<?php\n/g'

### Transform array to XML with PHP
$xml = new SimpleXMLElement('<item/>');
array_walk_recursive($myarray, array ($xml, 'addChild'));
echo $xml->asXML();

Apache tips
-----------

### List apache2 loaded modules
apache2ctl -t -D DUMP_MODULES

### Set UTF-8 HTTP header by default in apache
nano /etc/apache2/conf.d/charset
AddDefaultCharset UTF-8

### Redir to .html when no suffix provided
RewriteCond %{REQUEST_URI} !\.html$
RewriteRule /(.*)$ /$1.html [R=permanent,L]

### Disable appspot.com web proxy
RewriteCond %{HTTP_USER_AGENT} AppEngine-Google [NC]
RewriteRule .* - [F]

MySQL tips
----------

### SELECT Week number with DATE_FORMAT (ISO8601)
SELECT DATE_FORMAT(%v, date) FROM ... WHERE ...

### MATCH AGAINST Mysql
SELECT MATCH (objet.titre) AGAINST ("$search") as revelance
WHERE MATCH (objet.titre) AGAINST ("$search" IN BOOLEAN MODE)
ORDER BY revelance DESC

### Mysql COALESCE for empty string
SELECT coalesce(NULLIF(email, ''), 'user@domain.com') FROM users
