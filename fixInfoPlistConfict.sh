#!/bin/sh
projectDir=`pwd`
infoplist="$projectDir/SwiftDemo/Info.plist"
tmpfile="${infoplist}.tmp"
linenumberStart=`cat $infoplist | grep -n "^=======" | awk 'BEGIN {FS=":"}{print $1}'`
linenumberEnd=`cat $infoplist | grep -n "^>>>>>>>" | awk 'BEGIN {FS=":"}{print $1}'`
if [ -z ${linenumberStart} ] || [ -z ${linenumberEnd} ]; then
echo "Info.plist is normal , did not need to handle confict!"
else
cat $infoplist | sed "$linenumberStart,$linenumberEnd d" | grep -v "<<<<<<< HEAD" | grep -v "=======" | grep -v "^>>>>>>> "  >$tmpfile
mv $tmpfile $infoplist
echo "fix ok"
fi

