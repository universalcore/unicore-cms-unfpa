#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsgem/locale

pot-create -o unicorecmsgem/locale/unicorecmsgem.pot unicorecmsgem/

declare -a arr=("eng_GB" "tha_TH" "ind_ID" "swa_TZ" "hin_IN" "fre_FR" "spa_CO" "spa_MX" "mar_IN" "tel_IN" "por_PT")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsgem/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsgem/locale/""$lang""/LC_MESSAGES/unicorecmsgem.po" ]; then
        msginit -l $lang -i unicorecmsgem/locale/unicorecmsgem.pot -o unicorecmsgem/locale/$lang/LC_MESSAGES/unicorecmsgem.po
    fi

    msgmerge --update unicorecmsgem/locale/$lang/LC_MESSAGES/unicorecmsgem.po unicorecmsgem/locale/unicorecmsgem.pot
    msgfmt unicorecmsgem/locale/$lang/LC_MESSAGES/*.po -o unicorecmsgem/locale/$lang/LC_MESSAGES/unicorecmsgem.mo
done
