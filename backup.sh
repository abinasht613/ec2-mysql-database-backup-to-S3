# Backup storage directory
backupfolder=/opt/dbbackups

# MySQL user
user=mysql_user_name

# MySQL password
password=mysql_user_password

# MySQL Database
database=databse_name

# Number of days to store the backup on server
keep_day=7

sqlfile=$backupfolder/database-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/database-$(date +%d-%m-%Y_%H-%M-%S).zip

# Create a backup
mysqldump --column-statistics=0 --no-tablespaces -u $user -p$password $database > $sqlfile

if [ "$?" -eq 0 ]; then
  echo 'Sql dump created'
fi

# Compress backup
zip $zipfile $sqlfile
if [ "$?" -eq 0 ]; then
  echo 'The backup was successfully compressed'
fi

# Uploaded to S3
/usr/local/bin/aws s3 cp $zipfile s3://bucket_name/ 
if [ "$?" -eq 0 ]; then
  echo "uploaded to s3"
  # Delete SQL file and zip
  rm $zipfile $sqlfile
  echo 'zip & sql file deleted'

  # Delete old backups
  find $backupfolder -mtime +$keep_day -delete
fi
