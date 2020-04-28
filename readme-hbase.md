# hbase 基本常识


## 常用命令
```bash
# help 命令的使用
help 'create'

# 列出所有命名空间(默认有default以及系统自带的hbase)
list_namespace
# 创建/删除命名空间
create_namespace/drop_namespace 'ns1'
# 修改命名空间
alter_namespace 'ns1',{METHOD => 'set','PROPERTY_NAME' => 'PROPERTY_VALUE'}

# 列出所有表
list
# 列出指定命名空间下的所有表
list_namespace_tables 'ns1'
# 新建表(命名空间为ns1，表为t1，列族为cf)
create 'ns1:t1', 'cf'
# 删除表
disable 'ns1:t1'
drop 'ns1:t1'
# 查看表内容
scan 'ns1:t1'
scan 'ns1:t1',{LIMIT=>5}  # 查看前5行数据
# 插入数据(向命名空间ns1的表t1中，行号为r1,列族为cf，列名为c1,值为value)
put 'ns1:t1','r1','cf:c1','value'
# 查看行号为r1的数据
get 'ns1:t1','r1'

# 分区
## 建表时预分2个区，该表在HDFS上有2个文件夹，如果没有预分区，则只有一个文件夹
create 'ns1:t1','cf',{SPLITS => ['1','2']}

```


## 参考文献
