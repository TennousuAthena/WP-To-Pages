#!/bin/bash


urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

work_dir="/www/wp_pages"
wp_dir="/www/wp"
cache_dir=${wp_dir}"/wp-content/cache/supercache/www.wp.xxx"


cd ${work_dir}
sudo mkdir wp-content
sudo mkdir tmp
sudo cp -rf ${cache_dir}* ${work_dir}/tmp/
cd ${work_dir}/tmp/

for i in `find $path -iname "*$filename*" | tac`
do
    newpath=`echo $i | urldecode $i`
    sudo mv "$i" "$newpath"
done


find . -type f -name '*.html' | xargs perl -pi -e 's|www.wp.xxx|www2.wp.xxx|g'


sudo cp -rf * ../
cd ..
sudo rm -rf tmp/
sudo cp -rf ${wp_dir}/wp-content/uploads/ ${work_dir}/wp-content/
sudo ./rename.sh . -https
sudo git add *
sudo git commit -m "$(date "+%Y-%m-%d Update")"
sudo git push
