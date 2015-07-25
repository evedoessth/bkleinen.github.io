#!/bin/bash
git push origin master
if [ $? -ne 0 ]; then
    echo "push failed; exiting"
    exit $?
fi
jekyll build --config _config.yml,_htwconfig.yml
if [ $? -eq 0 ]; then
    for f in $(find _site_htw -name "*.html"); do iconv -f utf-8 -t ISO-8859-1 $f > temp.html && mv -f temp.html $f; done
    scp -r _site_htw/* kleinenweb@uranus.f4.htw-berlin.de:/home/kleinen/public_html
else
    echo SITE BUILD FAILED, NOT COPYING TO HTW
fi

# note: for the scp to work, there need to be ssh keys in place for kleinenweb
# and /home/kleinen/public_html and all files in it must belong to group kleinenweb
# and be writable for this group.
