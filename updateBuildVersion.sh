#!/bin/sh
complieInfoPlist="./SwiftDemo/Info.plist"
version=`git rev-list HEAD | wc -l | awk '{print $1}'`
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" $complieInfoPlist