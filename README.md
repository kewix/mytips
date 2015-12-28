# mytips
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
