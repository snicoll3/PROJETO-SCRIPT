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
                        4 "Dividir um documento por página" \
                        5 "Juntar documentos" \
                        6 "Excluir Páginas" \
                        0 "Sair" )

        options=$(echo $options | egrep -o '^[0-9]')

        # De acordo com a opção escolhida, dispara programas
        case "$options" in
            "0") exit;;
            "1") FORM=$(
                yad --center --title="Selecione o local do Arquivo "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF-1  : " ""                                       \
                    --field="PDF-2  : " ""                                       \
                    --button="Adicionar"                 \
                    )
                PDF-1=$(echo "$FORM" | cut -d "|" -f 1)
                PDF-2=$(echo "$FORM" | cut -d "|" -f 1)
                echo $FORM;;
        esac
done