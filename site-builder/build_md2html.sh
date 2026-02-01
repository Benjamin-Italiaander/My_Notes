# Builded from here

mkdir -p .//Linux/OpenPGP_GnuPG_cheat_sheet
md2html   ./../Linux/OpenPGP_GnuPG_cheat_sheet.md \
        .//Linux/OpenPGP_GnuPG_cheat_sheet/index.html \
        "My Open pgp cheat cheet"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//Linux/GnuPG/README
md2html   ./../Linux/GnuPG/README.md \
        .//Linux/GnuPG/README/index.html \
        ""Some GnuPG reminders""  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//Linux/yubikey/EN_yubikey_install_ykman
md2html   ./../Linux/yubikey/EN_yubikey_install_ykman.md \
        .//Linux/yubikey/EN_yubikey_install_ykman/index.html \
        "EN Yubikey install ykman"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//Linux/yubikey/EN_yubikey_ssh
md2html   ./../Linux/yubikey/EN_yubikey_ssh.md \
        .//Linux/yubikey/EN_yubikey_ssh/index.html \
        "EN Yubikey use ssh with yubikey"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//Linux/yubikey/NL_yubikey_ingebruikname
md2html   ./../Linux/yubikey/NL_yubikey_ingebruikname.md \
        .//Linux/yubikey/NL_yubikey_ingebruikname/index.html \
        "NL yubikey stappen via de cli een Minimale ingebruikname"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//Linux/yubikey/EN_yubikey_otp
md2html   ./../Linux/yubikey/EN_yubikey_otp.md \
        .//Linux/yubikey/EN_yubikey_otp/index.html \
        "EN Yubikey setup OTP from linux cli with yubikey"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//slices_of_life/reminders/EN_deal_with_situations
md2html   ./../slices_of_life/reminders/EN_deal_with_situations.md \
        .//slices_of_life/reminders/EN_deal_with_situations/index.html \
        "EN Reminders 002"  \
        ./template.html \
        ./style.css \
        . 
          
mkdir -p .//slices_of_life/reminders/EN_compassion_determination
md2html   ./../slices_of_life/reminders/EN_compassion_determination.md \
        .//slices_of_life/reminders/EN_compassion_determination/index.html \
        "EN Reminders 001 compassion determination"  \
        ./template.html \
        ./style.css \
        . 
          
cp ./../slices_of_life/README.md ./index.md
./site-index.sh
md2html  ./index.md ./index.html  "Benjamin Italiaander" ./template.html ./style.css . 
