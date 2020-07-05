#!/bin/sh

#  postinstall.sh v0.0.5
#  Created by StarPlayrX on 7/1/20.

# Credits
# APFS ROM Patcher by Dosdude1, see the dude 😎 folder.
# LegacyUSBInjector by ParrotGeek
# Recommended for Mac Pro 3,1. Use with extreme care! No warranty is provided.

cat './🎨/post-art.ans'

destVolume="/"
kexts="/🍔/"
source=$(pwd)$kexts
read -p "
🖥  Destination Volume [ $destVolume = return key | drag volume here -> ]: " destVolume2

if [ "$destVolume2" != "" ]
 then
   destVolume="$destVolume2/"
fi

mount -uw $destVolume

read -p "
🍔 Resources [ $source = return key ]: " source2


if [ "$source2" != "" ]
  then
    source="$source2/"
fi

echo "
🍔 Resources   --> $source"
echo "
🖥  Destination --> $destVolume\r\n"

read -p "Press return to proceed:" proceed

kext="/System/Library/Extensions/"
libKext="/Library/Extensions/"
plugins="/System/Library/UserEventPlugins/"
fs="/System/Library/Filesystems/"

libDest=$destVolume$libKext
dest=$destVolume$kext

userEventPlugins=$destVolume$plugins
appleHDA="AppleHDA.kext"
telemetry="com.apple.telemetry.plugin"
ioATAFamily="IOATAFamily.kext"
ioHIDFamily="IOHIDFamily.kext"
legacyUSBInjector="LegacyUSBInjector.kext"
legacyUSBVideoSupport="LegacyUSBVideoSupport.kext"
#HFSEncodings="HFSEncodings.kext"
#HFSStandard="HFS.kext"
#HFSfs="hfs.fs"

echo "SSE3 compatible Telemetry plugin"
ditto -v $source$telemetry $plugins$telemetry
echo "\r"

echo "Apple High Def Audio"
ditto -v $source$appleHDA $dest$appleHDA
echo "\r"

echo "Apple CD/DVD drive"
ditto -v $source$ioATAFamily $dest$ioATAFamily
echo "\r"

##By ParrotGeek
echo "LegacyUSBInjector (ParrotGeek)"
ditto -v $source$legacyUSBInjector $libKext$legacyUSBInjector
echo "\r"

echo "legacyUSBVideoSupport"
ditto -v $source$legacyUSBVideoSupport $libKext$legacyUSBVideoSupport
echo "\r"


## On hold until I can compile a new Kext
##echo "Apple Standard HFS and HFS+ Disks"
##ditto -v $source$HFSStandard $dest$HFSStandard
##echo "\r"

##echo "Apple Standard HFS and HFS+ Encodings"
##ditto -v $source$HFSEncodings $fs$HFSEncodings
##echo "\r"

##echo "Apple Standard HFS and HFS+ FileSystem"
##ditto -v $source$HFSfs $dest$HFSfs
##echo "\r"

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

echo "Software Version Check"
version=$($sw '-productVersion')
echo $version

if [ $version != "10.16" ] && [ $version != "10.16.1" ] && [ $version != "11.0" ] && [ $version != "11.0.1" ]
 then
   ## Use is not Catalina
   if [ "$destVolume" == "/" ]
   then
     echo "\r\nUpdating System Prelinked Kernel...\r\n"
       kextcache -system-prelinked-kernel
     echo "\r\nUpdating System Caches...\r\n"
       kextcache -system-caches
     else
       echo "\r\nUpdating kextcache on volume $destVolume...\r\n"
         kextcache -u "$destVolume"
       echo "\r\nUpdating startup kextcache check on volume $destVolume...\r\n"
         kextcache -U "$destVolume"
   fi
 
 else
   kmutil install --force --volume-root $destVolume
   kcditto
fi


##Clean up our mess
##kmutil create -n boot --boot-path /Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions




echo "\r\nThis script was brought to you by StarPlayrX\r\nThe Most Awesome Sirius XM Radio player,\r\nVersion 1.1 is in public beta via TestFlight:\r\nhttps://testflight.apple.com/join/Ecz0xXvf\r\n"

read -p "Press return to Reboot [ options : q for quick ]: " rebootArgs
echo "\r\n"

if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs"
elsex
    reboot
fi