# dotfiles
My dotfiles


## IDA
```
$ ln -s /home/$USER/Documents/dotfiles/idaq /usr/bin/idaq
$ ln -s /home/$USER/Documents/dotfiles/idaq64 /usr/bin/idaq64
$ chmod +x /usr/bin/idaq*
```

## French keyboard layout
```
# curl https://raw.githubusercontent.com/cboin/dotfiles/master/10-keyboard-layout.conf > /etc/X1/xorg/conf.d/10-keyboard-layout.conf
```
## Xrandr DualScreen
```
$ xrandr --output DVI-D-0 --auto --output DVI-I-1 --auto --right-of DVI-D-0 
```
