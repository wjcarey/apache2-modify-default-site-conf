#! /bin/bash

if [ -z "$1" ]
    then
        echo -e "\e[32menter the default path you would like to use... \e[39m"
        read INSTALL_PATH
        echo -e "\e[32mconfirm defaut site path to ${INSTALL_PATH}, Do you want to continue? [Y/n] \e[39m"
        read CONFIRM_INSTALL_PATH
    else
    INSTALL_PATH=${2}
    CONFIRM_INSTALL_PATH="Y"
fi

INSTALL_PATH=$(realpath -s --canonicalize-missing $INSTALL_PATH)

if [ "$CONFIRM_INSTALL_PATH" != "${CONFIRM_INSTALL_PATH#[Yy]}" ] ;then
    echo "updating apache2 default virtual host for directory ${INSTALL_PATH} ..."
    sed -i "s/^Document Root.*/Document Root ${INSTALL_PATH}/" /etc/apache2/sites-available/000-default.conf
    echo "restarting apache2 ..."
    systemctl restart apache2
else
    echo "notice: configuration of default site was skipped by user..."
fi

#SELF DELETE AND EXIT
rm -- "$0"
exit