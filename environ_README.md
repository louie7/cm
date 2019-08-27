# CM settings #
# I. TMUX
---
## 1.1 [Manual](http://man.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/tmux.1?query=tmux%26amp;sec=1)

---
## 1.2 Config

---
## 1.3 Tips
### 1.3.1 get back the session with SIGUSR1 (10)
```bash
ps -ef | grep tmux
yilu     23942     1  0 Jun12 ?        00:05:14 tmux new -s cc_rel
kill -10 21942
tmux a -t cc_rel
[detached (from session cc_rel)]
```

### 1.3.2 lock or unlock screen
> Ctrl-S lock screen, Ctrl-Q unlock screen

# II. PC config
## 2.1 keyboard
### 2.2.1 HHBK settings for mac OS:
        switch: 011001
        shortcut: 	fn + O: light down
         			fn + P: light up
                     fn + A: sound up
                     fn + S: sound down
        For Wins: 1,3,5 ON (101010)
            Use the web to test key output
            https://zhouer.org/KeyboardTest/

### 2.2.2 change key mapping
Run 'regedit' (as Administrator), and add the following key in your registry:
HKEY_LOCAL_MACHINE
  \System
    \CurrentControlSet
      \Control
        \Keyboard Layout
https://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html
http://www.xiaozhou.net/exchange_ctrl_and_capslock_key-2012-07-20.html

### 2.2.3 change key mapping
http://unix.stackexchange.com/questions/94331/how-can-i-delete-a-word-backward-at-the-command-line-bash-and-zsh
-bash-4.2$ stty werase ^p
-bash-4.2$ stty kill ^a
-bash-4.2$
Note that one does not have to put the actual control character on the line, stty understands putting^ and then the character you would hit with control.
After doing this, if I hit ctrlp it will erase a word from the line. And if I hit ctrla, it will erase the whole line.
stty -a

### 2.2.4 Python context setting, auto tab completion in python start up file
export PYTHONSTARTUP="/remote/us01home27/yilu/.pythonstartup.py"
http://stackoverflow.com/questions/5837259/installing-pythonstartup-file
http://codingpy.com/article/vim-and-python-match-in-heaven/

### 2.2.5 win+p choose to close no used Display Projectro
http://child.rksec.com/baike/system/4129.html


