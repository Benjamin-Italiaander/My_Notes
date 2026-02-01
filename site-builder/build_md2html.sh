# Builded from here

mkdir -p ./Linux/OpenPGP_GnuPG_cheat_sheet
md2html   ./../Linux/OpenPGP_GnuPG_cheat_sheet.md \
        ./Linux/OpenPGP_GnuPG_cheat_sheet/index.html \
        "My Open pgp cheat cheet"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./Linux/GnuPG
md2html   ./../Linux/GnuPG/README.md \
        ./Linux/GnuPG/index.html \
        ""Some GnuPG reminders""  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./Linux/yubikey/EN_yubikey_install_ykman
md2html   ./../Linux/yubikey/EN_yubikey_install_ykman.md \
        ./Linux/yubikey/EN_yubikey_install_ykman/index.html \
        "EN Yubikey install ykman"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./Linux/yubikey/EN_yubikey_ssh
md2html   ./../Linux/yubikey/EN_yubikey_ssh.md \
        ./Linux/yubikey/EN_yubikey_ssh/index.html \
        "EN Yubikey use ssh with yubikey"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./Linux/yubikey/NL_yubikey_ingebruikname
md2html   ./../Linux/yubikey/NL_yubikey_ingebruikname.md \
        ./Linux/yubikey/NL_yubikey_ingebruikname/index.html \
        "NL yubikey stappen via de cli een Minimale ingebruikname"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./Linux/yubikey/EN_yubikey_otp
md2html   ./../Linux/yubikey/EN_yubikey_otp.md \
        ./Linux/yubikey/EN_yubikey_otp/index.html \
        "EN Yubikey setup OTP from linux cli with yubikey"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life
md2html   ./../slices_of_life/README.md \
        ./slices_of_life/index.html \
        "000 - HOME"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life/my_curated_booklist
md2html   ./../slices_of_life/my_curated_booklist/README.md \
        ./slices_of_life/my_curated_booklist/index.html \
        "020 BOOKS My curated writers and books"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life/my_curated_booklist/the_power_of_now_Eckhart_Tolle
md2html   ./../slices_of_life/my_curated_booklist/the_power_of_now_Eckhart_Tolle.md \
        ./slices_of_life/my_curated_booklist/the_power_of_now_Eckhart_Tolle/index.html \
        "021 BOOKS Eckhart Tolle"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life/art_i_enjoy
md2html   ./../slices_of_life/art_i_enjoy/README.md \
        ./slices_of_life/art_i_enjoy/index.html \
        "010 - Some art i enjoy"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life/art_i_enjoy/Wood_Block_Printing_Uchinda
md2html   ./../slices_of_life/art_i_enjoy/Wood_Block_Printing_Uchinda/README.md \
        ./slices_of_life/art_i_enjoy/Wood_Block_Printing_Uchinda/index.html \
        "012 ART Wood Block Printing Uchinda"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p ./slices_of_life/art_i_enjoy/takamizawa_mokuhansha
md2html   ./../slices_of_life/art_i_enjoy/takamizawa_mokuhansha/README.md \
        ./slices_of_life/art_i_enjoy/takamizawa_mokuhansha/index.html \
        "011 ART Stakamizawa Mokuhansha"  \
        ./template.html \
        ./style.css \
        . 
          
cp ./../slices_of_life/README.md ./index.md
./site-index.sh
md2html  ./index.md ./index.html  "Benjamin Italiaander" ./template.html ./style.css . 
