# linux下hadoop集群常用的命令
```
1.上传文件

    1）hadoop fs -put words.txt /path/to/input/

    2）hdfs dfs -put words.txt /path/wc/input/

2.获取hdfs中的文件

    hadoop fs -get /path/wc/input/words.txt

3.合并下载多个文件

    hadoop fs -getmerge /path/wc/input/words.txt /path/wc/input/words2.txt

4.查看某目录下所含文件

    1）hadoop fs -ls /path/wc/input/

    2）hadoop fs -ls hdfs://node1:9000/path/wc/input/

5.查看文件内容

    hadoop fs -cat /path/wc/input/words.txt

6.显示一个文件的末尾

    hadoop fs -tail /weblog/test.log

7.以字符形式打印一个文件的内容 

    hadoop fs -text /weblog/test.log

8.在hdfs上创建目录

    hadoop fs -mkdir -p /aaa/bbb/cc/dd 

9.从本地剪切粘贴到hdfs 

    hadoop fs -moveFromLocal /home/hadoop/a.txt /aaa/bbb/cc/dd

10.从hdfs剪切粘贴到本地 

    hadoop fs -moveToLocal /aaa/bbb/cc/dd /home/hadoop/a.txt 

11.从本地文件系统中拷贝文件到hdfs路径去

    hadoop fs -copyFromLocal /home/hadoop/a.txt /aaa/bbb/cc/dd

12.从hdfs拷贝到本地 

    hadoop fs -copyToLocal /aaa/bbb/cc/dd /home/hadoop/a.txt 

13.从hdfs的一个路径拷贝hdfs的另一个路径 

    hadoop fs -cp /aaa/test1.txt /bbb/test2.txt

14.在hdfs目录中移动文件 

    hadoop fs -mv /aaa/jdk.tar.gz / 

15.追加一个文件到已经存在的文件末尾 

    1）hadoop fs -appendToFile hello.txt hdfs://node1:9000/hello.txt

    2）hadoop fs -appendToFile hello.txt /hello.txt

16.离开hadoop的 安全模式(系统处于只读状态,namenode不会处理任何块的复制和删除命令)

    hadoop dfsadmin -safemode leave

17.删除目录及其里面内容 

    hadoop fs -rmr /path/wc/input/words.txt

18.删除空目录

    hadoop fs -rmdir  /aaa/bbb/ccc

19.与linux文件系统中的用法一样，对文件所属权限

    1）hadoop fs -chmod 666 /hello.txt 

    2）hadoop fs -chown someuser:somegrp /hello.txt 

20.统计文件系统的可用空间信息 

    hadoop fs -df -h /

21.统计文件夹的大小信息

    hadoop fs -du -s -h /aaa/*

22.统计一个指定目录下的文件节点数量 

    hadoop fs -count /aaa/

23.设置hdfs中文件的副本数量 

    hadoop fs -setrep 3 /aaa/test.txt
--------------------- 
作者：xl.zhang 
来源：CSDN 
原文：https://blog.csdn.net/u011254180/article/details/79399422 
版权声明：本文为博主原创文章，转载请附上博文链接！
```
