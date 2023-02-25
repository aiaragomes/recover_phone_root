#!/bin/sh
# Recover root on android smartphone with LineageOS and Magisk
# Usage: recover_phone_root.sh <los_dir> <los_dumper>

# Downloading lineage os
echo "-----> Downloading LineageOS"
cd $1
echo -n "Do you need to download the zip (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "y" ]]; then
  rm -f lineage*.zip lineage*sha256
  echo -n "Date of the release (YYYYMMDD)? "
  read -n 8 date
  echo ""
  wget https://mirrorbits.lineageos.org/full/FP3/$date/lineage-19.1-$date-nightly-FP3-signed.zip
  wget https://mirrorbits.lineageos.org/full/FP3/$date/lineage-19.1-$date-nightly-FP3-signed.zip?sha256
  echo ""
  echo "Comparing checksum"
  sha256sum -c lineage-19.1-$date-nightly-FP3-signed.zip?sha256
fi
echo ""

# Getting boot.img
echo "-----> Getting boot.img"
cd $2
echo -n "Do you need to get the boot.img (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "y" ]]; then  
  rm -f *.img
  source .venv/bin/activate
  cp $1/lineage*.zip .
  unzip lineage*.zip
  python payload_dumper.py payload.bin
  deactivate
  cp output/boot.img .
  cp output/vbmeta.img .
  rm -f lineage*.zip
  rm -rf META-INF/ __pycache__/ output/
  rm -f apex_info.pb care_map.pb payload.bin payload_properties.txt
fi
echo ""

# Checking adb
echo "-----> Recovering root"
echo "1) Please plug your phone via USB"
echo ""
echo -n "2) Is rooted USB debugging allowed on your phone (y/n)? "
read -n 1 choice
echo ""
echo "You might need to give permission on your phone..."
if [[ ${choice,,} == "y" ]]; then  
  echo ""
  echo "Checking adb..."
  sudo adb kill-server
  echo "Waiting 15 seconds..."
  sleep 15
  sudo adb start-server
  adb devices
else
  echo ""
  echo "It is not possible to continue..."
  exit -1
fi

# Copying boot.img
adb push boot.img /sdcard/Download/
echo ""
echo -n "3) Do you see boot.img in the Download folder (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "n" ]]; then  
  echo "There might be a problem with adb..."
  exit -1
fi
echo ""

# Recovering root
echo "4) Reinstall/update the Magisk app from the apk or older version"
echo -n "Have you done it (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "n" ]]; then  
  echo "You need Magisk to continue..."
  exit -1
fi
echo ""

echo "5) Please go to the Magisk app and patch the new boot image"
echo -n "Have you patched it (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "y" ]]; then  
        echo -n "What is the code of the patched image (NNNNN_LLLLL)? "
  read -n 11 code
  echo ""
  adb pull /sdcard/Download/magisk_patched-$code.img magisk_patched.img
  adb reboot fastboot
  echo "Waiting 15 seconds..."
  sleep 15
else
  echo "It is not possible to continue..."
  exit -1
fi
echo ""

echo -n "6) Are you in fastboot mode (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "y" ]]; then  
  sudo fastboot flash boot magisk_patched.img
else
  echo "It is not possible to continue..."
  exit -1
fi
echo ""

echo -n "7) Do you want to flash vbmeta (y/n)? "
read -n 1 choice
echo ""
if [[ ${choice,,} == "y" ]]; then  
  sudo fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
fi

echo ""
echo "-----> Final steps"
echo "You can restart your phone now!"
echo ""
echo "Recommended:"
echo "- disable USB debugging"
echo "- hide the Magisk app (if not done yet)"
echo "- clean up Download dir"
echo ""
echo "Done! Enjoy your rooted phone! ;D"
echo ""

