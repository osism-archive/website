#!/usr/bin/env bash

lftp -u "$FTP_USERNAME,$FTP_PASSWORD" -e 'set sftp:auto-confirm yes; mirror -R -v build /; exit;' sftp://$FTP_HOSTNAME
