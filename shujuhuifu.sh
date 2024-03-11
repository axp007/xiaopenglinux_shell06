#恢复全量备份
mysql -h localhost -uroot -pxiaopeng@126.com < bakdup.sql
#在恢复全量备份之后，要将全量备份之后的增量备份也恢复回数据库中
mysql> show master status;
mysql> select * from users;
mysqlbinlog /var/lib/mysql/mysql-bin.000*** | mysql -uroot -pxiaopeng@126.com name;
#执行命令source /root/20151010.sql 执行数据库导入命令
mysqldump -h 127.0.0.1 -uroot -p pemass ec_order > /tmp/ec_order.sql
Enter password:shxiaopeng@pe#mass
