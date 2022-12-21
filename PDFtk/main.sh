#!/bin/bash

while : ; do
    options=$(yad     --list --fixed --center --borders=10 --window-icon="./images/panda.ico" --title="Pandinha PDFTools" --columns=2 --no-buttons --image-on-top \
    --image=./images/panda.png                             \
                        --text "O que deseja fazer?"\
                        --column "Opção" --column "Descrição"\
                        --width="500" --height="450" \
                        1 "Sobre" \
                        2 "Exibir Preview" \
                        3 "Dividir documento" \
                        4 "Juntar documentos" \
                        5 "Excluir Páginas" \
                        0 "Sair" )

        options=$(echo $options | egrep -o '^[0-9]')

        # De acordo com a opção escolhida, dispara programas
        case "$options" in
            "0") exit;;
            "1") SOBRE=$(yad --fixed --center --borders=10 --window-icon="./images/panda.png" --title="Pandinha PDFTools" --image-on-top \
    --image=./images/panda.png     \
                        --text "PDFtk é uma interface da biblioteca do iText, PDFtk é uma ferramenta de código aberto e plataforma 
                        cruzada que está voltado para lidar com documentos PDF. Este aplicativo nos permite manipular documentos 
                        PDF e o que podemos fazer é dividir, combinar, criptografar, descriptografar, descompactar, recomprimir e 
                        reparar." \))
                        ;;
            "2")     PREVIEW=$(
                yad --center --title="Selecione o arquivo a ser Visualizado "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF : " ""    \
                    )
                PDF=$(echo "$PREVIEW" | cut -d "|" -f 1 )
                evince --preview $PDF;;
            "3")    BURST=$(
                yad --center --title="Selecione o arquivo a ser dividido "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF : " ""    \
                    )
                PDF=$(echo "$BURST" | cut -d "|" -f 1 )
                pdftk $PDF burst;;

            "4") MERGE=$(
                yad --center --title="Selecione o arquivo a ser dividido "            \
                    --width=400 --heigth=400                                    \
                    --form                                                      \
                    --field="PDF-1: " ""    \
                    --field="PDF-2: " ""    \
                     )
                    PDF1=$(echo "$MERGE" | cut -d "|" -f 1 )
                    PDF2=$(echo "$MERGE" | cut -d "|" -f 2 )
                pdftk $PDF1 $PDF2 output merged.pdf
                yad --text="Documentos $PDF1 e $PDF2 Mesclados!" --text-align=center;;

            "5")
                DELETE=$(
                    yad --center --title="Selecione o arquivo e a página." \
                        --width=400 --heigth=400 \
                        --form \
                        --field="Qual o arquivo? : " "" \
                        --field="Qual página a ser deletada? : " ""
                )
                PDF=$(echo "$DELETE" | cut -d "|" -f 1)
                NUMBER_PAGE=$(echo "$DELETE" | cut -d "|" -f 2)
                ant=$(( $NUMBER_PAGE - 1 ))
                suc=$(( $NUMBER_PAGE + 1 ))
                if test $NUMBER_PAGE -eq 1;then
                    pdftk $PDF cat $suc-end output pdfresultante.pdf
                else
                    pdftk $PDF cat 1-$ant $suc-end output pdfresultante.pdf || pdftk $PDF cat 1-r2 output pdfresultante.pdf
                fi
                evince -w pdfresultante.pdf
                ;;
    esac
done
