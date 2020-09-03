# GNU #

# TORD
https://stackoverflow.com/questions/373142/what-techniques-can-be-used-to-speed-up-c-compilation-times
---

# 1. make  #
## 1.1 make rule
Rain - Ultimate Rain Sounds Collection
    • TRD: https://github.com/google/styleguide https://www.cnblogs.com/fnng/archive/2012/01/07/2315685.html https://www.analyticsvidhya.com/blog/2016/01/complete-tutorial-learn-data-science-python-scratch-2/


## 1.2 check process elapsed time
etime In the POSIX locale, the elapsed time since the process was started, in the form: [[dd-]hh:]mm:ss
```bash
ps -eo pid,cmd,etime
```

## 1.3 OOM Kill

## 1.4 difference-between-eval-and-exec
```bash
Compare:
    1. $ bash -c 'echo $$ ; ls -l /proc/self ; echo foo'
    2. 7218
    3. lrwxrwxrwx 1 root root 0 Jun 30 16:49 /proc/self -> 7219
    4. foo
with
    1. $ bash -c 'echo $$ ; exec ls -l /proc/self ; echo foo'
    2. 7217
    3. lrwxrwxrwx 1 root root 0 Jun 30 16:49 /proc/self -> 7217
echo $$ prints the PID of the shell I started, and listing /proc/self gives us the PID of the ls that was ran from the shell. Usually, the process IDs are different, but with exec the shell and ls have the same process ID. Also, the command following exec didn't run, since the shell was replaced.
    1. $ help eval
    2. eval: eval [arg ...]
    3.    Execute arguments as a shell command.
eval will run the arguments as a command in the current shell. In other words eval foo bar is the same as just foo bar. But variables will be expanded before executing, so we can execute commands saved in shell variables:
    1. $ unset bar
    2. $ cmd="bar=foo"
    3. $ eval "$cmd"
    4. $ echo "$bar"
    5. foo
It will not create a child process, so the variable is set in the current shell. (Of course eval /bin/ls will create a child process, the same way a plain old /bin/ls would.)
```

## 1.5 test disk IO stauts with dd
```bash
    dd if=/dev/zero of=test bs=1000M count=1
```

## 1.6 timeout to a shell command call
```bash
    ## timeout would send signal to shell script and subshell at the same time
    ## there is no way to trap the signal and send to subshell in the script
    timeout -S TERM 5m <shell_script>.sh

    ## up a subshell and send the signal to subshell at interval time like:
    (
        t = monitor_time
        while [[ t > 0 ]]; do
            [[ <cond> ]] && kill -s SIGINT $$
            (( t-- ))
        done
    )

```

---

# 2. COMMANDS #
## 2.1 find ##
### 2.1.1 use find -new to construct gmake rule to trigger target build with new file update
``` bash
NEW_FILES = $(if $(DIRS_CHECK), $(shell [[ -f 'target_file' ]] && /bin/find $(DIRS_CHECK) -name '*' -type f -newer 'target_file' -print -quit))
> $(INSTALL_MISC_TARGETS) : $(INSTALL_SCRIPTS) $(NEW_FILES)
```

### 2.1.2 monitor dir regularly to find new file which should not been updated
```bash
i=0; while ([[ $i -lt 23 ]]); do suf=$(date +%H%M%S); find <monitor_dir> -name '*' -type f -newer <baseline_file> -print0 |  xargs -0 -P4 ls -l > suspect_files_${suf}.log; sleep 3600;  (( i += 1 )); done
```

### 2.1.3 use find and awk to get the same md5 files list
```bash
## file_list.txt contain md5 and file name

## get the files with the same md5 into d ([md5value file1 file2 [file3...]])
awk '{ if ( $1 in a ){ a[$1]=a[$1]"\t"$2; d[$1]=a[$1] } else { a[$1]=$2; } }END{for (m in d){print m,d[m]}}' file_list.txt > dup_list.txt

## get the wasted size caused by duplicated files into 1st column
awk '{ if ( $1 in a ){ fh="/bin/stat -c %s " $2; fh | getline size; close(fh); printf  "%d\t%s\t%s\t%s\n", size * (NF - 2), $0}'  dup_list.txt

# getline sets $0 to the next input record from the current input file; 
# getline <file sets $0 to the next record from file.  
# getline x sets variable x instead.  
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
> $@ <br>
:   The file name of the target of the rule. If the target is an archive member, then '$@' is the name of the archive file. In a pattern rule that has multiple targets (see section Introduction to Pattern Rules), '$@' is the name of whichever target caused the rule's commands to be run.
$% <br> 
    The target member name, when the target is an archive member. See section Using make to Update Archive Files. For example, if the target is 'foo.a(bar.o)' then '$%' is 'bar.o' and '$@' is 'foo.a'. '$%' is empty when the target is not an archive member. <br>
$< <br> 
:   The name of the first dependency. If the target got its commands from an implicit rule, this will be the first dependency added by the implicit rule (see section Using Implicit Rules).
$? <br>
The names of all the dependencies that are newer than the target, with spaces between them. For dependencies which are archive members, only the member named is used (see section Using make to Update Archive Files).
$^ <br>
The names of all the dependencies, with spaces between them. For dependencies which are archive members, only the member named is used (see section Using make to Update Archive Files). A target has only one dependency on each other file it depends on, no matter how many times each file is listed as a dependency. So if you list a dependency more than once for a target, the value of $^ contains just one copy of the name.
$+ <br>
This is like '$^', but dependencies listed more than once are duplicated in the order they were listed in the makefile. This is primarily useful for use in linking commands where it is meaningful to repeat library file names in a particular order.
$\* <br>
The stem with which an implicit rule matches (see section How Patterns Match). If the target is 'dir/a.foo.b' and the target pattern is 'a.%.b' then the stem is 'dir/foo'. The stem is useful for constructing names of related files. In a static pattern rule, the stem is part of the file name that matched the `%' in the target pattern. In an explicit rule, there is no stem; so '$*' cannot be determined in that way. Instead, if the target name ends with a recognized suffix (see section Old-Fashioned Suffix Rules), '$*' is set to the target name minus the suffix. For example, if the target name is 'foo.c', then '$*' is set to 'foo', since '.c' is a suffix. GNU make does this bizarre thing only for compatibility with other implementations of make. You should generally avoid using '$*' except in implicit rules or static pattern rules. If the target name in an explicit rule does not end with a recognized suffix, '$*' is set to the empty string for that rule.







