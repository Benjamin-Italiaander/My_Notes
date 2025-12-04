For the more advanced users there is a mutch better way of installing the latest version of ykman

clone the pyhton repository from the [Yubico soure here](https://github.com/Yubico/yubikey-manager)

go into the cloned folder and run 
```bash
 pip install ./  --break-system-packages
```
test if it works with

``bash
ykman -v
```
