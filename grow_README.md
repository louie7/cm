# grow #
# 1. BASICS  #
## 1.1 stage
music bg
Rain - Ultimate Rain Sounds Collection
    • TRD: https://github.com/google/styleguide https://www.cnblogs.com/fnng/archive/2012/01/07/2315685.html https://www.analyticsvidhya.com/blog/2016/01/complete-tutorial-learn-data-science-python-scratch-2/
    • urls http://swe-web-prod3:8030/amIalive/rtracer

---

## 1.2 check process elapsed time
etime In the POSIX locale, the elapsed time since the process was started, in the form: [[dd-]hh:]mm:ss
```bash
ps -eo pid,cmd,etime
```

## 1.3 OOM Kill

## 1.4 difference-between-eval-and-exec
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
# Finally, cmd | getline pipes the output of cmd into getline; each call of getline returns the next line of output from cmd.  
# In all cases, getline returns 1 for a successful input, 0 for end of file, and -1 for an error.
```

### 2.1.3 find the broken symbol links
```bash
find -name '*' -type l ! -exec test -e {} \; -print
## use xargs + sh as:
find -name '*' -type l -print0 | xargs -0 -P2 -I"{}" sh -c ' [[ -e "{}" ]] || ls -al --color {}'

## rm deadlinks at current dir level
find ./ -maxdepth 1 -type l -! -exec test -e {} \; -print | xargs rm -f
```

## 2.2 tar usage examples
tar is faster, cp -a is stable, rsync is better to do incremental
```bash
## tar with exclude directoryies
tar -czvf backup-`date +%m-%d-%Y-%H%M`.tar.gz \ 
     --exclude={./public_html/templates/cache,./public_html/templates/compiled,./public_html/images} \ 
     ./public_html
## tar with high compression rate
env GZIP=-9 tar cvzf file.tar.gz /path/to/directory 
## http://superuser.com/questions/514260/how-to-obtain-maximum-compression-with-tar-gz files and derictories transfer performance
```


## 2.3 crontab
``` bash
    1. When cron job is run from the users crontab it is executed as that user. It does not however source any files in the users home directory like their .cshrc or .bashrc or any other file. If you need cron to source (read) any file that your script will need you should do it from the script cron is calling. Setting paths, sourcing files, setting environment variables, etc.
    2. If the users account has a crontab but no usable shell in /etc/passwd then the cronjob will not run. You will have to give the account a shell for the crontab to run.
    3. If your cronjobs are not running check if the cron daemon is running. Then remember to check /etc/cron.allow and /etc/cron.deny files. If they exist then the user you want to be able to run jobs must be in /etc/cron.allow. You also might want to check if the /etc/security/access.conf file exists. You might need to add your user in there.
    4. Crontab is not parsed for environmental substitutions. You can not use things like PATH,HOME, or ~/sbin. You can set things like MAILTO= or PATH= and other environment variables the /bin/sh shell uses.
    5. Cron does not deal with seconds so you can't have cron job's going off in any time period dealing with seconds. Like a cronjob going off every 30 seconds.
    6. You can not use % in the command area. They will need to be escaped and if used with command substitution like the date command you can put it in backticks. Ex. date +\%Y-\%m-\%d. Or use bash's command substituion $().
    7. Watch out using day of month and day of week together. Day of month and day of week fields with restrictions (no *) makes this an "or" condition not an "and" condition. When either field is true it will be executed.
```

## 2.4 rsync
```bash
## rsync to remote site dir
rsync  -avz <dir2rsync> <hostname>:<dir_dest>

## rsync with exclude dir (relative path)
rsync -avz --exclude 'object_root' <src> <dest>

## clean the dir faster mothod high performance 
## --delete delete extraneous files from dest dirs
/bin/usr/time -v rsync -av   --delete  empty_dir/ to_clean_dir/

## 只同步/data2/rsinc.list文件中列出来的文件
/usr/bin/rsync -rvazu --ignore-errors  --timeout=200 --files-from=/data2/rsinc.list 10.0.0.103::bokee_html/ /data2/ottest
```


3. python exp
get clientroot with valid client naming
    1. ref_client = ''.join([src.rsplit('_btracer',1)[0],'_us01']).rsplit('/',1)[1]
    2. ref_client_root = subprocess.check_output(['/usr/local/bin/p4find_client', '-r', ref_client]).rstrip()    
check python script syntax
    1. python -m py_compile  <py_script>.py
re
re.escape to escape meta character use (?:aaa|bbb) to group re match
SET operations
s.update(t) s |= t return set s with elements added from t s.intersection_update(t) s &= t return set s keeping only elements also found in t s.difference_update(t) s -= t return set s after removing elements found in t s.symmetric_difference_update(t) s ^= t return set s with elements from s or t but not both s.add(x) add element x to set s s.remove(x) remove x from set s; raises KeyError if not present s.discard(x) removes x from set s if present s.pop() remove and return an arbitrary element from s; raises KeyError if empty s.clear() remove all elements from set s
use SET to do one loop to find the pair whose summary is 6
(use space to exchange time)
    1. s1 = set([1, 3, 2, 5, 4])
    2. s = frozenset([1, 3, 2, 5, 4])
    3. r = []
    4. for i in s:
    5.    s1.discard(i)
    6.    t = 6 - i
    7.    if t in s1:
    8.        r.append([i, t])
    9.        s1.discard(t)
sorted instance
sorted(iterable, cmp=None, key=None, reverse=False) --> new sorted list
    1. >>> l
    2. ['Chr1-10.txt', 'Chr1-1.txt', 'Chr1-2.txt', 'Chr1-14.txt', 'Chr1-3.txt', 'Chr1-20.txt', 'Chr1-5.txt']
    3. >>> sorted(l, key = lambda d: int(d.split('-')[-1].split('.')[0]))
    4. ['Chr1-1.txt', 'Chr1-2.txt', 'Chr1-3.txt', 'Chr1-5.txt', 'Chr1-10.txt', 'Chr1-14.txt', 'Chr1-20.txt']
    5. >>> l
    6. ['Chr1-10.txt', 'Chr1-1.txt', 'Chr1-2.txt', 'Chr1-14.txt', 'Chr1-3.txt', 'Chr1-20.txt', 'Chr1-5.txt']
list sort
    1. >>> print (l.sort.__doc__)
    2. L.sort(cmp=None, key=None, reverse=False) -- stable sort *IN PLACE*;
    3. cmp(x, y) -> -1, 0, 1
    4. >>> l = [('b',2),('a',1),('c',3)]
    5. >>> l.sort(key=lambda x:x[1])
    6. >>> l
    7. [('a', 1), ('b', 2), ('c', 3)]
dict sorted
    1. >>> d = {'banana':3, 'apple':4, 'pear':1, 'orange':2}
    2. >>> import collections
    3. >>> collections.OrderedDict(sorted(d.items(),key = lambda t:t[0]))
    4. OrderedDict([('apple', 4), ('banana', 3), ('orange', 2), ('pear', 1)])
    5. >>> collections.OrderedDict(sorted(d.items(),key = lambda t:t[1]))
    6. OrderedDict([('pear', 1), ('orange', 2), ('banana', 3), ('apple', 4)])
fatest to check if key in hash
efficient way to check if key exist
    1. if key in MyDict:
    2.  print 'exist'

4. Snippet
print column by trim its prefix space with awk
    1. awk -F':'  '{print gensub(/^[[:space:]]+/,"",1,$2);}'  /tmp/bb 

get host with available slots

find the pattern appear in consecutive ine
    1. awk '{/succeeded$/?f++:f=0; if(f==2){print NR};}'  ufile.txt

call external shell command by "sh" in awk (piping into shell)
    1. find src/ -name '.depends' -type f  | awk '{t=gensub(/.depends$/,"3116456_depends",1,\$0); print "diff", \$0, t | "sh"  }END{close( "sh" )}'  


check which process is listening on the port
    1. netstat -lntp

install package (buildable) by rpm2cpio
e.g. install rsync for AIX http://www.rpm.org/max-rpm/s1-rpm-miscellania-rpm2cpio.html download rsync (static one) for AIX used http://www.bullfreeware.com/affichage.php?id=2374# rpm2cpio rsync-3.0.9-2.aix6.1.ppc.rpm | cpio -idmv
ignore the ENV to execute shell command (ignore the ENV loaded from .bashrc etc )
    1. env -i ... 
    2. '--norc' '--noprofile' ??? 
    3. 
    4. ## To debug env issue  
    5. env -i sh -c "export VAR='AAA'; run_cmd" 
http://www.perlmonks.org/?node_id=716774 From bash manpage:
--norc: Do not read and execute the system wide initialization file /etc/bash.bashrc and the personal initialization file ~/.bashrc if the shell is interactive. This option is on by default if the shell is invoked as sh. --noprofile: Do not read either the system-wide startup file /etc/profile or any of the personal initializa‐tion files ~/.bash_profile, ~/.bash_login, or ~/.profile. By default, bash reads these files when it is invoked as a login shell. If you want to keep using the system-wide rc file, but not the personal one, I imagine you can use the following and only name the system-wide one: --rcfile file: Execute commands from file instead of the system wide initialization file /etc/bash.bashrc and the standard personal initialization file ~/.bashrc if the shell is interactive.

test disk IO stauts with dd
    1. dd if=/dev/zero of=test bs=1000M count=1

# 3. LESSONS #
## 3.1 to avoid NFS failure by refresh NFS cache with ‘rm -f’ before creating symlink 

## 3.2 lsof debug/monitor usage
check open file monitor and debug with lsof
check if file is written by process 
```bash
lsof -f -- a_file COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME cat 52391 bob 1w REG 1,2 15 19545007 a_file 1w :: 1 file descriptor; w meaning write mode
```

## 3.3 the backslash is tricky when call external command in perl of ternimal
``` bash
## avoid $ \ interpreted by shell
perl -e '$a=qx|awk "/^INCLUDE/{print \$2}" file.txt |; print $a; '

perl -e '$a=qx|awk "/^INCLUDE/{print \\\$2}" file.txt |; print $a; '

```


others
三围 97,87,96

