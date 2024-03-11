#!/bin/bash
#增量备份时复制mysql--bin.00000*的目标目录
backupDir=/opt/db_bak/mysql/bakdir_add
#mysql的数据目录
mysqlDir=/var/lib/mysql
#mysql的index文件路径，，放在数据目录下的
logFile=/opt/db_bak/mysql/bakdir_add.log
BinFile=/var/lib/mysql/mysql-bin.index

#生产新的mysql--bin.00000*文件
mysqladmin -uroot -pjft@zjk2022.com flush-logs
#awk切片并统计行数
Counter=`wc -l $BinFile |awk '{print $1}'`
NextNum=0
#这个for循环用于比对$Counter,$NextNum这两个值来确定文件是不是存在或最新的
for file in `cat $BinFile`
do
    base=`basename $file`
    echo $base
    #basename用于截取mysql-bin.00000*文件名，去掉./mysql-bin.000005前面的./
    NextNum=`expr $NextNum + 1`
    if [ $NextNum -eq $Counter ]
    then
          echo $base skip! >> $logFile
    else
          dest=$backupDir/$base
          if (test -e $dest)
          #test -e用于检测目标文件是否存在，存在就写exist!到$logFile去
          then
                echo $base exist! >> $logFile
          else
                cp $mysqlDir/$base $backupDir
                echo $base copying >> $logFile
          fi
    fi
done
echo `date +"%Y年%m月%d日 %H:%M:%S"` $Next Bakup succ! >> $logFile
