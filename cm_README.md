# CM settings #
# I. [Perforce](https://www.perforce.com/manuals/v15.1/cmdref/global.options.html)
## 1.1 
Use `p4 reopen -c changelist file` to move an open file from its current pending changelist to pending changelist changelist.

reopen the file from symlink to text
p4 reopen  -t text link_file

## 1.2 [File Specifications](https://www.perforce.com/manuals/v18.1/cmdref/Content/CmdRef/filespecs.html)
- wildcards
| Expression     | Matches   | Comments   |
| :---------     | :-------- | :---: |
| J\* | Files in the current directory starting with J |      |
| ./....c    | All files under the current directory and its subdirectories, that end in .c |     |
|  %%1 - %%9     | Positional specifiers for substring rearrangement in filenames, when used in views.   |    |

## 1.3 [Determining the Synced Changelist of a Workspace](https://community.perforce.com/s/article/3458)
- Readonly clients require having P4CLIENT set, or the '-c' global equivalent, in order to access its have-list. For example, the following command can show the highest changelist number sync'ed to a read-only client:
> p4 -c clientname changes -m1 //...#have

- ignore files deleted at the head revision, use the following command:
> p4 changes -m1 @clientname

## 1.4 back out the changelist
    1.4.1. Backing out a very recent changelist (edits only) 
    1.4.2. Backing out an old changelist (edits only) 
    1.4.3. Backing out adds and deletes as well as edits 

## 1.5 add back p4 deleted files
```bash
p4 sync -f deleted_file#<version>
p4 add deleted_file
```

## 1.6 Reopen a changelist to add file:
```bash
p4 reopen -c 5930366 //depot/file/filename.c
```

## 1.7 change the specific filetype
```bash
# -F filter, List only those files that match the criteria specified by filter.
# -T fields, List only those fields that match the field names specified by fields. 
for depotPath in `p4 client -o client_name | awk '$1 ~ "//AA/BB/main/dev"{print $1}' | grep -v '^-' | sed  -e 's/^+//'`; \
    do p4 fstat -F "headType ~= l & ^headType = symlink & ^headAction ~= delete" -T 'depotFile, headType' $depotPath; \
done | grep -c depotFile
    0
```

 
  
## [file name limitations] (https://www.perforce.com/manuals/v17.1/cmdref/Content/CmdRef/filespecs.synopsis.limitations.html)
```bash
 p4 sync //depot/path/status%40june.txt
 @  %40
 #  %23
 *  %2A
 %  %25
```

## list specific status changes
```bash
# From <https://community.perforce.com/s/article/3462> 
p4 changes -s submitted //...@2011/05/16:00:01:00,2011/05/16:07:00:00
```
 
 
 

---
---
# II Git

## 2.1 docs:
[git-scm](https://git-scm.com/book/zh/v2)
[git - 简明指南](http://rogerdudler.github.io/git-guide/index.zh.html)
[入门](http://blog.csdn.net/halaoda/article/details/78856326)
[图解](http://marklodato.github.io/visual-git-guide/index-zh-cn.html)

## 2.2 tips
### 2.2.1 get 'Detached HEAD' commits back into master 
Create a branch where you are, then switch to master and merge it:
```git
git branch my-temporary-work
git checkout master
git merge my-temporary-work
git branch -d my-temporary-work
git push origin master
```

### 2.2.2 git log:  [git log](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E6%9F%A5%E7%9C%8B%E6%8F%90%E4%BA%A4%E5%8E%86%E5%8F%B2)
#### generate patch with lastest  2
```git
git log -p -2
```

### 2.2.3 revert [git commit amend](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E6%92%A4%E6%B6%88%E6%93%8D%E4%BD%9C)

