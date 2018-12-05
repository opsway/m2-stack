#!/bin/bash
BACKUP_DIR=/backups

if [ ! -d "$BACKUP_DIR" ]; 
then
    echo "Can't find BACKUP_DIR. Add volume ./some_place:/backup"
    exit 1
fi

# DB_BACKUP_STORE_PATH=/backup/db/
# DB_BACKUP_STORE_DAYS=30

# MEDIA_BACKUP_STORE_PATH=/backup/media/
# MEDIA_BACKUP_STORE_DAYS=30

BASE_PATH=/app/current/

BAK_DATE=$(date +%Y-%m-%d--%H-%M)

## db backup
if [ -n "${CREATE_DB}" ]; then
    echo "dumping db ... \n"
    cd $BASE_PATH \
    && n98-magerun2 db:dump --compression="gzip" ${BACKUP_DIR}/db/${BAK_DATE}.sql.gz

    echo "removing old backups ... \n"
    cd ${BACKUP_DIR}/db/ \
    && find ./*.sql.gz -mtime +${DB_BACKUP_STORE_DAYS} -type f -delete
fi

## media backup
# echo "syncing media files ... "
# cd ${BASE_PATH}pub/media \
#    && rsync  -arz --delete --exclude cache --exclude sessions ./ ${MEDIA_BACKUP_STORE_PATH}/latest/

# echo "creating tar ... "
# cd ${MEDIA_BACKUP_STORE_PATH} \
#    && tar -cvzf $(date +%Y%m%d).tar ./latest/  \
#    && find ./*.tar -mtime +${MEDIA_BACKUP_STORE_DAYS} -type f -delete




    

