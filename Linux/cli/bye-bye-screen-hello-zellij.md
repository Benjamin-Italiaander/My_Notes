# [zellij](https://zellij.dev/) is a great alternative for screen!

### I just came across a really nice tool zellij as a replacement of the tmux or screen terminal multiplexing applications. I instantly became a fan!

[zellij can be found here](https://zellij.dev/) it's not in all repository's yet, but easy to build from source or download the binary and copy it into your /sbin folder

If you have copy-paste problems with zellij try to add the line "mouse_mode false"  to the config.kdl file. after adding this line you really hae to kill all running zellij otherwise it wont help.


```bash
echo "mouse_mode false" >> ~/.config/zellij/config.kdl
```
