#!/bin/bash
# ##mysql用户
user="root"
# ##mysql密码
userPWD="jft@zjk2022.com"
# ##需要定时备份的数据库列表
dbNames=(pemass mysql)
# ##备份数据以日期创建文件夹存放,同时删除过期备份
DATE=`date -d "now" +%Y%m%d-%H%M%S`
ODATE=`date -d "-7day" +%Y%m%d-%H%M%S`
newdir=/opt/db_bak/mysql/$DATE
olddir=/opt/db_bak/mysql/$ODATE
# ##删除过期备份数据
if [ -d $olddir ];
  then
    rm -rf $olddir
fi
# ##创建新备份文件夹
mkdir $newdir
# ##对备份数据库列表的所以数据库备份
for dbName in ${dbNames[*]}
do
  dumpFile=$dbName-$DATE.sql.gz
  /usr/bin/mysqldump -u$user -p$userPWD $dbName | gzip > $newdir/$dumpFile
done
