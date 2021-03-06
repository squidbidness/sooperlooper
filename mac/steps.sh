#!/bin/sh

version=`grep const ../version.h | cut -d" " -f7 | sed -e 's/[";]//g'`
echo Version is $version

mkdir -p macdist/SooperLooper.app/Contents/MacOS/
mkdir -p macdist/SooperLooper.app/Contents/Frameworks
mkdir -p macdist/SooperLooper.app/Contents/Resources

cp ../src/sooperlooper macdist/SooperLooper.app/Contents/MacOS/
cp ../src/gui/slgui macdist/SooperLooper.app/Contents/MacOS/

cp slgui.icns macdist/SooperLooper.app/Contents/Resources/


cp ../OSC macdist/OSC.txt
cp ../README macdist/README.txt
cp ../COPYING macdist/COPYING.txt

cp ../src/slregister macdist/slregister

cp README_AudioUnit.txt macdist/

sed -e "s/VVVVV/$version/g" Info.plist > macdist/SooperLooper.app/Contents/Info.plist

libsrc=/usr/lib

#cd macdist/SooperLooper.app/Contents/MacOS

#install_name_tool -change ${libsrc}/libz.1.dylib @executable_path/../Frameworks/libz.1.dylib slgui 
#install_name_tool -change ${libsrc}/libz.1.dylib @executable_path/../Frameworks/libz.1.dylib sooperlooper 
#install_name_tool -change ${libsrc}/libxml2.2.dylib @executable_path/../Frameworks/libxml2.2.dylib sooperlooper 
#install_name_tool -change ${libsrc}/libxml2.2.dylib  @executable_path/../Frameworks/libxml2.2.dylib slgui 
#install_name_tool -change ${libsrc}/libiconv.2.dylib @executable_path/../Frameworks/libiconv.2.dylib sooperlooper 
#install_name_tool -change ${libsrc}/libiconv.2.dylib @executable_path/../Frameworks/libiconv.2.dylib slgui 

#strip sooperlooper
#strip slgui

#cd .. 
#mkdir -p Frameworks
#cd Frameworks

#cp -f ${libsrc}/libz.1.dylib .
#cp -f ${libsrc}/libxml2.2.dylib .
#cp -f ${libsrc}/libiconv.2.dylib .

#chmod u+w *.dylib

#install_name_tool -id @executable_path/../Frameworks/libiconv.2.dylib libiconv.2.dylib 
#install_name_tool -id @executable_path/../Frameworks/libxml2.2.dylib libxml2.2.dylib 
#install_name_tool -id @executable_path/../Frameworks/libz.1.dylib libz.1.dylib 
#install_name_tool -change ${libsrc}/libxml2.2.dylib @executable_path/../Frameworks/libxml2.2.dylib  libxml2.2.dylib 
#install_name_tool -change ${libsrc}/libz.1.dylib @executable_path/../Frameworks/libz.1.dylib  libxml2.2.dylib 
#install_name_tool -change ${libsrc}/libiconv.2.dylib @executable_path/../Frameworks/libiconv.2.dylib  libxml2.2.dylib 

#cd ../../../..

./stepsau.sh


# now tar it up
ARCH=`uname -p`
distdir=sl_macdist_${version}_${ARCH}
rm -rf $distdir
ln -sf macdist $distdir
tar chfz ${distdir}.tgz $distdir
rm $distdir

#rm -f SooperLooper-${version}.dmg
#hdiutil create -fs HFS+ -volname SooperLooper-${version} -srcfolder macdist SooperLooper-${version}.dmg
