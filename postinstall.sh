#!/bin/sh

#  sudo ./postinstall.sh
#  BigMac MacPro post install tool v0.0.12
#  Created by StarPlayrX on 10.17.2020

printf '\e[48;5;0m\r\n' #black background

printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
printf "[38;5;112mStarPlayrX -> Big Mac Post Installation Tool for Mac Pros v11.0.1\r\n"
printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n\r\n"
printf "[38;5;112m"

printf "🍔 = Apple HD Audio, SSE4.1 Telemetry, SuperDrive Support\r\n"
printf "🧀 = MouSSE 4.2 Emulator for AMD Radeon Video Drivers\r\n"
printf "🍺 = HDMI Audio, Legacy USB Injector\r\n"
printf "📸 = Snapshot removal tool by StarPlayrX\r\n"


destVolume="/"
kexts="/🍔/"
cheese="/🧀/"
pepsi="/🍺/"

source=$(pwd)$kexts
cheesey=$(pwd)$cheese
coke=$(pwd)$pepsi

read -p "
🖥  Destination Volume [ $destVolume = return key | drag volume here -> ]: " destVolume2

if [ "$destVolume2" != "" ]
 then
   mount -uw "$destVolume2"
   destVolume="$destVolume2"
 else
   mount -uw /
fi

read -p "
🍔 Resources [ $source = return key ]: " source2

if [ "$source2" != "" ]
  then
    source="$source2/"
fi

echo "\r\n🖥  Destination --> $destVolume"
echo "\r\n🍔 Resources   --> $source\r\n"
read -p "Press return to proceed:" proceed

kext="/System/Library/Extensions/"
libKext="/Library/Extensions/"
plugins="/System/Library/UserEventPlugins/"
fs="/System/Library/Filesystems/"

libDest=$destVolume$libKext
dest=$destVolume$kext
userEventPlugins=$destVolume$plugins

#Apple Kexts
appleHDA="AppleHDA.kext"
ioATAFamily="IOATAFamily.kext"

##SSE4.1 compatible plugin
telemetry="com.apple.telemetry.plugin"

#Third Party Kexts
AAAMouSSE="AAAMouSSE.kext"
LegacyUSBInjector="LegacyUSBInjector.kext"
HDMIAudio="HDMIAudio.kext"

##ioUSBHostFamily="IOUSBHostFamily.kext"
##ioUSBFamily="IOUSBFamily.kext"

echo "SSE4.2 AMD Radeon Driver Emulator MouSSE"
rm -Rf "$libDest$AAAMouSSE"
ditto -v "$cheesey$AAAMouSSE" "$libDest$AAAMouSSE"
chown -R 0:0 "$libDest$AAAMouSSE"
chmod -R 755 "$libDest$AAAMouSSE"
echo "\r"

echo "Legacy USB Injector"
rm -Rf "$libDest$LegacyUSBInjector"
ditto -v "$coke$LegacyUSBInjector" "$libDest$LegacyUSBInjector"
chown -R 0:0 "$libDest$LegacyUSBInjector"
chmod -R 755 "$libDest$LegacyUSBInjector"
echo "\r"

echo "HDMI Audio"
rm -Rf "$libDest$HDMIAudio"
ditto -v "$coke$HDMIAudio" "$libDest$HDMIAudio"
chown -R 0:0 "$libDest$HDMIAudio"
chmod -R 755 "$libDest$HDMIAudio"
echo "\r"

echo "SSE4.1 compatible Telemetry plugin"
rm -Rf "$userEventPlugins$telemetry"
ditto -v "$source$telemetry" "$userEventPlugins$telemetry"
chown -R 0:0 "$userEventPlugins$telemetry"
chmod -R 755 "$userEventPlugins$telemetry"
echo "\r"

echo "Apple CD/DVD drive Intel PIIX ATA"
rm -Rf "$dest$ioATAFamily"
ditto -v "$source$ioATAFamily" "$dest$ioATAFamily"
chown -R 0:0 "$dest$ioATAFamily"
chmod -R 755 "$dest$ioATAFamily"
echo "\r"

##This also fixes USB Video crash bug in Quicktime Player.
echo "Apple HD Audio"
rm -Rf "$dest$appleHDA"
ditto -v "$source$appleHDA" "$dest$appleHDA"
chown -R 0:0 "$dest$appleHDA"
chmod -R 755 "$dest$appleHDA"
echo "\r"

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

echo "Software Version Check"
version=$($sw '-productVersion')
echo $version
echo ""
##To Do: Move 10.16 and 11.0, maybe read the first 2 characters
if [ $version != "10.16" ] && [ $version != "11.0" ] && [ $version != "11.0.1" ] && [ $version != "11.0.2" ] && [ $version != "11.0.3" ] && [ $version != "11.0.4" ] && [ $version != "11.0.5" ] && [ $version != "11.0.6" ] && [ $version != "11.0.7" ] && [ $version != "11.0.8" ] && [ $version != "11.0.9" ]
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
    ##Barry's version
    echo "\r\nUpdating Boot BootKernelExtensions..."
    kmutil create -n boot --kernel /System/Library/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --system-path /System/Library/KernelCollections/SystemKernelExtensions.kc --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    echo "\r\nUpdating System BootKernelExtensions..."
    kmutil create -n sys --kernel /System/Libary/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --system-path /System/Library/KernelCollections/SystemKernelExtensions.kc --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    
   kcditto="kcditto"
   sbin="/usr/sbin/"
   "$destVolume$sbin$kcditto"
fi


#Snapshot deletion code by StarPlayrX 2020
snapshots=$(diskutil apfs listsnapshots "$destVolume" | grep +-- | sed 's/^.\{4\}//')

echo '\r\nChecking snapshots.'

for uuid in $snapshots
do
    printf '📸 Attempting to delete snapshot => '
    echo $uuid
    echo ''
    
    diskutil apfs deletesnapshot "$destVolume" -uuid $uuid
done

echo '\r\nCreating a bootable blessed snapshot. (tip: clone via asr to remove)'

sudo bless --folder "$destVolume/System/Library/CoreServices" --bootefi --create-snapshot

echo "\r\nThis script was brought to you by StarPlayrX\r\nThe best and only third party Sirius XM Radio player,\r\nVersion 1.1.6 available now in the iOS AppStore!\r\n"

read -p "Press return to Reboot [ options : q for quick ]: " rebootArgs
echo "\r\n"

if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs"
else
    reboot
fi
