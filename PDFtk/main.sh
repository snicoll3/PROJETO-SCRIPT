#!/bin/bash

while : ; do
    options=$(yad     --list --fixed --center --borders=10 --window-icon="./images/panda.png" --title="Pandinha PDFTools" --columns=2 --no-buttons --image-on-top \
    --image=./images/panda.png                             \
                        --text "O que deseja fazer?"\
                        --column "Opção" --column "Descrição"\
                        --width="750" --height="750" \
                        1 "Escolher documentos para Editar" \
                        2 "Exibir Preview" \
                        3 "Dividir documento" \
                        4 "Juntar documentos" \
                        5 "Excluir Páginas" \
                        0 "Sair" )

        options=$(echo $options | egrep -o '^[0-9]')

        # De acordo com a opção escolhida, dispara programas
        case "$options" in
            "0") exit;;
            "1")    FORM=$(
                yad --center --title="Selecione o local do Arquivo "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF-1  : " ""                                       \
                    --field="PDF-2  : " ""                                       \
                    --button="Adicionar"                 \
                    )
                PDF1=$(echo "$FORM" | cut -d "|" -f 1 )
                PDF2=$(echo "$FORM" | cut -d "|" -f 2 )
                echo $FORM;;
            "2") echo "404 Not Found";;
            "3")    BURST=$(
                yad --center --title="Selecione o arquivo a ser dividido "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF : " ""    \
                    )
                PDF=$(echo "$BURST" | cut -d "|" -f 1 )
                pdftk $PDF burst;;
            "4") pdftk $PDF1 $PDF2 output merged.pdf
                yad --text="Documentos $PDF1 e $PDF2 Mesclados!" --text-align=center;;
        esac
done