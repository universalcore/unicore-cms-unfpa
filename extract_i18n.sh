#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsunfpa/locale

pot-create -o unicorecmsunfpa/locale/unicorecmsunfpa.pot unicorecmsunfpa/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsunfpa/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsunfpa/locale/""$lang""/LC_MESSAGES/unicorecmsunfpa.po" ]; then
        msginit -l $lang -i unicorecmsunfpa/locale/unicorecmsunfpa.pot -o unicorecmsunfpa/locale/$lang/LC_MESSAGES/unicorecmsunfpa.po
    fi

    msgmerge --update unicorecmsunfpa/locale/$lang/LC_MESSAGES/unicorecmsunfpa.po unicorecmsunfpa/locale/unicorecmsunfpa.pot
    msgfmt unicorecmsunfpa/locale/$lang/LC_MESSAGES/*.po -o unicorecmsunfpa/locale/$lang/LC_MESSAGES/unicorecmsunfpa.mo
done
