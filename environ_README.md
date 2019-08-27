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
## 2.1 HHBK settings for mac OS:
        switch: 011001
        shortcut: 	fn + O: light down
        			fn + P: light up
                    fn + A: sound up
                    fn + S: sound down
