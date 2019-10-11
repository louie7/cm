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
## The target-pattern and dep-patterns say how to compute the dependencies of each target. Each target is matched against the target-pattern to extract a part of the target name, called the stem. This stem is substituted into each of the dep-patterns to make the dependency names (one from each dep-pattern).
targets ...: target-pattern: dep-patterns ...
        commands
        ...
objects = foo.o bar.o

$(objects): %.o: %.c
        $(CC) -c $(CFLAGS) $< -o $@

bigoutput littleoutput : %output : text.g
        generate text.g -$* > $@
## When the generate command is run, $* will expand to the stem, either `big' or `little'.
```

- double colon rule
> If they are double-colon, each of them is independent of the others. Each double-colon rule's commands are executed if the target is older than any dependencies of that rule. This can result in executing none, any, or all of the double-colon rules.
> Double-colon rules with the same target are in fact `completely separate` from one another. Each double-colon rule is processed individually, just as rules with different targets are processed.
```make
```

---

## 1.10 [implict rules ](http://kirste.userpage.fu-berlin.de/chemnet/use/info/make/make_10.html)
- automatic variables
> $@ The file name of the target of the rule. If the target is an archive member, then `$@' is the name of the archive file. In a pattern rule that has multiple targets (see section Introduction to Pattern Rules), `$@' is the name of whichever target caused the rule's commands to be run.
> $% The target member name, when the target is an archive member. See section Using make to Update Archive Files. For example, if the target is `foo.a(bar.o)' then `$%' is `bar.o' and `$@' is `foo.a'. `$%' is empty when the target is not an archive member.
> $< The name of the first dependency. If the target got its commands from an implicit rule, this will be the first dependency added by the implicit rule (see section Using Implicit Rules).
> $?  The names of all the dependencies that are newer than the target, with spaces between them. For dependencies which are archive members, only the member named is used (see section Using make to Update Archive Files).
> $^ The names of all the dependencies, with spaces between them. For dependencies which are archive members, only the member named is used (see section Using make to Update Archive Files). A target has only one dependency on each other file it depends on, no matter how many times each file is listed as a dependency. So if you list a dependency more than once for a target, the value of $^ contains just one copy of the name.
> $+ This is like `$^', but dependencies listed more than once are duplicated in the order they were listed in the makefile. This is primarily useful for use in linking commands where it is meaningful to repeat library file names in a particular order.
> $* The stem with which an implicit rule matches (see section How Patterns Match). If the target is `dir/a.foo.b' and the target pattern is `a.%.b' then the stem is `dir/foo'. The stem is useful for constructing names of related files. In a static pattern rule, the stem is part of the file name that matched the `%' in the target pattern. In an explicit rule, there is no stem; so `$*' cannot be determined in that way. Instead, if the target name ends with a recognized suffix (see section Old-Fashioned Suffix Rules), `$*' is set to the target name minus the suffix. For example, if the target name is `foo.c', then `$*' is set to `foo', since `.c' is a suffix. GNU make does this bizarre thing only for compatibility with other implementations of make. You should generally avoid using `$*' except in implicit rules or static pattern rules. If the target name in an explicit rule does not end with a recognized suffix, `$*' is set to the empty string for that rule.



