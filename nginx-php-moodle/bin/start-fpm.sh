#!/usr/bin/with-contenv sh
#
# Copyright (c) 2018 SD Elements Inc.
#
#  All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains
# the property of SD Elements Incorporated and its suppliers,
# if any.  The intellectual and technical concepts contained
# herein are proprietary to SD Elements Incorporated
# and its suppliers and may be covered by U.S., Canadian and other Patents,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from SD Elements Inc..
# Version

echo "Starting PHP-FPM init script"

echo "Make unix socket for nginx/php"
mkdir -p /var/run/php-fpm
touch /var/run/php-fpm/www.sock
chown -R www-data:www-data /var/run/php-fpm

echo "Configure SSMTP"
sed -i -e 's/mailhub=mail/mailhub=postfix/' \
    -e "s/#rewriteDomain=/rewriteDomain=${SSMTP_REWRITEDOMAIN}/" \
    -e '/hostname=/d' \
    /etc/ssmtp/ssmtp.conf

echo "Fixing permissions on moodledata directory..."
chown -R www-data:www-data /opt/moodle/moodledata

# Configure Moodle - this script will wait for PHP and PostgreSQL to come up
# in the background before attempting to configure or upgrade Moodle.
(/usr/local/bin/configure-moodle.sh) &

echo "Starting PHP-FPM"
"/usr/sbin/php-fpm${PHP_VERSION}" -R -F
