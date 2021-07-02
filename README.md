# Big Mac 2.0.2 beta 19

## 🍔  Download: http://starplayrx.com/bigmac2/Big_Mac_2.0.2_beta19.dmg

## Race Condition
* The race condition in macOS 11.4 is getting worse and worse. I will be reverting the BigSur side of bigmac to 11.2.3 soon.

## What's New:
* Removed close buttons from BigMac2 and CloneToolX1 that caused Springboard to freeze up due to bigmac2 running in the background. This happened when a user would close the window, click on the background and going to another app such as Recovery and this keeps the instance of bigmac2 running causing Springboard not to release. This should now be resolved. If not, this is the absolute best we can do at this time.
* macOS 11.4 Big Sur
* macOS 12.0 Beta Monterey
* Includes CloneToolX exclusive disk cloning software by Todd Bruss
* Please beware of kernel related PCIe recondition issue that Apple introduced around 11.3.x (this will haunt your system)

## Mac Pro 3,1 (Early 2008 Users)
* Bluetooth 2 EDR is not compatible with macOS 11 or later. Pull the card during the installation.
* Native APFS booting is required. See dosdude1's APFS ROM Patcher
* iMac style 802.11ac/BT4LE cards are recommended for native air drop and hand off

## Recommendations
* the BigMac 2.0 app itself runs on Intel and M1, so you can create a USB Installer from a supported Mac!
* 70% of BigMac2's code was developed on an M1.
* Previous unsupported Mac use is very helpful
* Try to get your system up to Catalina 10.15.7 using Dosdude1's patcher
* Do not try to install unless you can create a disk from a supported Mac or you are familar with running unsupported MacOS'.
* If you on a really old OS, you have an uphill battle as macOS 11.3 and later is very challenging instal and boot up.

## Known Issues
* macOS 11.3 and later has a PCIe race condition at the kernel level. This can make booting up macOS very challenging and can require several reboots or having to remove all PCIe non-video cards. This seemly happens at random and gets worse over time. There is no known fix other than being super patient or reverting back to macOS 11.2.3

        Select your macOS version (macOS 11.4 or macOS 12.0 Beta). Then to download it from Apple click "Download macOS"
<img width="664" alt="Screen Shot 2021-06-28 at 7 18 47 PM" src="https://user-images.githubusercontent.com/52664524/123715182-bcfd6c00-d845-11eb-8c76-79c24ba9daf4.png">


        Click "Create Installer Disk" Erase an APFS partition, SSD or Fast Flash Thumb drive (32GB or bigger)
<img width="664" alt="Screen Shot 2021-06-28 at 7 03 19 PM" src="https://user-images.githubusercontent.com/52664524/123714802-039e9680-d845-11eb-8b76-4e47c9420b4e.png">

        This will create your installer disk to an APFS volume
<img width="664" alt="Screen Shot 2021-06-28 at 7 08 36 PM" src="https://user-images.githubusercontent.com/52664524/123714673-c803cc80-d844-11eb-813c-4c8231905dd5.png">

        Boot up the installer disk (Not compatible with USB 1 or BT2 EDR)
<img width="664" alt="Screen Shot 2021-06-28 at 7 11 20 PM" src="https://user-images.githubusercontent.com/52664524/123714687-cdf9ad80-d844-11eb-985e-c62b5c2dcf72.png">

        From the boot disk select these options and press Launch Installer
<img width="664" alt="Screen Shot 2021-06-28 at 7 14 25 PM" src="https://user-images.githubusercontent.com/52664524/123714830-12854900-d845-11eb-8340-cb4135854d38.png">

        Recommended checkboxes. If unsure, use Telemetry and Remove APFS Snapshots to start

<img width="664" alt="image" src="https://user-images.githubusercontent.com/52664524/123714867-2761dc80-d845-11eb-901e-9ff625f288fd.png">

        ClonetoolX included with Big Mac 2.0 (See Big Mac 2.0's boot disk)
<img width="637" alt="Screen Shot 2021-06-28 at 7 04 20 PM" src="https://user-images.githubusercontent.com/52664524/123715347-1c5b7c00-d846-11eb-935a-d3ebcce67c32.png">
