#!/bin/bash

local_path=$(cd "$(dirname $0)";pwd)
NAME=$(basename $local_path)
RESOURCE_DIR=/home/app/content

folderName_tmp=${NAME#*-}
folderName=${folderName_tmp%%-*}

#parse params
USAGE="Usage: ./inst.sh [-i] [-u]
  -i install wgt and config environment
  -u uninstall wgt and remove source file
[-i] option was set as default."

function unzippkg()
{
    #environment clear
    echo "environment clear >>>>>>>>>>>>>>>>>>>>>>>>>>>>>."
    #unzip and push to device
    sdb shell "[ -d $RESOURCE_DIR/tct ] ||  mkdir -p $RESOURCE_DIR/tct"
    sdb shell "[ -d $RESOURCE_DIR/tct/opt/$NAME ] && rm -rf $RESOURCE_DIR/tct/opt/$NAME"
    sdb shell "[ -e $RESOURCE_DIR/tct/$NAME.zip ] && rm -rf $RESOURCE_DIR/tct/$NAME.zip"
    sdb push $local_path/$NAME.zip $RESOURCE_DIR/tct/
    sdb shell "cd $RESOURCE_DIR/tct/;unzip $NAME.zip"
    echo "Package unzip successfully and push to $RESOURCE_DIR/tct/"

}

function cleansource()
{
    sdb shell "[ -d $RESOURCE_DIR/tct/opt/$NAME ] && rm -rf $RESOURCE_DIR/tct/opt/$NAME"
    sdb shell "[ -e $RESOURCE_DIR/tct/$NAME.zip ] && rm -rf $RESOURCE_DIR/tct/$NAME.zip"
    echo "Clean folder successfully..."
}

case "$1" in
    -h|--help) echo "$USAGE"
               exit ;;
    ""|-i) installpkg;;
    -u) uninstallpkg;;
    *) echo "Unknown option: $1"
       echo "$USAGE"
       exit ;;
esac
