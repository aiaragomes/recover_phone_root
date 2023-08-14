# Recover root on LineageOS

Script that guides you through the process of recovering root on a smartphone
with **LineageOS** (LOS), rooted with **Magisk**, and with boot ramdisk. This is
useful because root is lost after every LOS update. The script basically
automates some of the steps of the 
[Magisk installation guide](https://topjohnwu.github.io/Magisk/install.html),
which includes getting the `boot.img`, and guides you through the steps that are
more difficult to automate. You can also use this script if you are rooting your
phone for the first time. Just make sure that you install the 
[Magisk app](https://github.com/topjohnwu/Magisk/releases/tag/v25.2) before
starting. Please read all steps before starting and **proceed at your own risk**.


## Requirements

- [required] Smartphone with LineageOS
- [required] Magisk app installed
- [required] Device's bootloader has to be unlocked
- [required] Device with boot ramdisk
- [required] A few basic Unix commands: `wget` & `sha256sum`
- [required] Android tools: `adb` & `fastboot`

This script was tested under Linux.


## Usage

### Adding script to your local commands

You can add this script to you local commands to facilitate usage in the
future.

``` bash
  $ chmod u+x recover_phone_root.sh
  $ echo 'export PATH="$(pwd):$PATH"' >> $HOME/.bashrc  # add current dir to your PATH permanently
  $ bash  # refresh terminal for change to take effect
```

### Using the script

You can run the script to recover root as following:

``` bash
  $ recover_phone_root.sh <los_dir>
```

where `<los_dir>` is the path where you want to store the LineageOS installation
package and boot and vbmeta images. If you run the script from the
root directory of this repo, you can for instance do the following:

``` bash
  $ mkdir lineageos
  $ ./recover_phone_root.sh $(pwd)/lineageos
```

The script will guide you through the necessary steps to recover root.
You will be asked for some input while the script is running. You need to give
the correct input to successfully complete the process. Please be mindful that 
this script will flash a Magisk patched boot image, so proceed at your **own
risk**. Have a good look at the script to see what it is doing before using it.

