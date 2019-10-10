# GNU #
# 1. make  #
## 1.1 [writing rules](http://kirste.userpage.fu-berlin.de/chemnet/use/info/make/make_4.html)
- Wildcard expansion happens automatically in targets, in dependencies, and in commands (where the shell does the expansion). In other contexts, wildcard expansion happens only if you request it explicitly with the wildcard function.
```make
objs := $(patsubst %.c,%.o,$(wildcard *.c))

for : $(objs)
    cc -o foo $(objs)
```

- VPATH, specify a search list that _make_ applies for all files
```make
VPATH = src:../headers
```

- vpath directive
```make
vpath pattern directories
# Specify the search path directories for file names that match pattern. The search path, directories, is a list of directories to be searched, separated by colons or blanks, just like the search path used in the VPATH variable.

vpath %.h ../include
```

- empty target file to record events
```make
print: a.c b.c
    lpr -p $?
    touch print
```

- multiple rules for one target
> One file can be the target of several rules. All the dependencies mentioned in all the rules are merged into one list of dependencies for the target. If the target is older than any dependency from any rule, the commands are executed.
```make
objects = foo.o bar.o
foo.o : defs.h
bar.o : defs.h test.h
$(objects) : config.h
extradeps=
$(objects) : $(extradeps)
```

- static pattern rules
```make

```

---


