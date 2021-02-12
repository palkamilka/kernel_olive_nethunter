# begin properties
properties() { '
kernel.string=NetHunterv2.9 for Olive/OliveLite
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=olivelite
device.name2=olive
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

set_con() {
  chcon -h u:object_r:"$1":s0 $2
  chcon u:object_r:"$1":s0 $2
}

# AnyKernel install
dump_boot;

ui_print "Adding kernel Boot Script..."
umount /vendor || true
umount /system || true
mount -o rw /dev/block/bootdevice/by-name/vendor /vendor
mount -o rw /dev/block/bootdevice/by-name/system /system
rm -rf /system/system/overlay
rm -rf /system/system/priv-app/ims
rm -rf /vendor/data-app
android_version=$(getprop ro.build.version.release)
av=${android_version:0:2}
if [[ $av == 10 ]]; then
	cp -rf /tmp/anykernel/10/system  /system
	cp -rf /tmp/anykernel/10/vendor  /vendor
fi
if [[ $av == 11 ]]; then
	cp -rf /tmp/anykernel/11/system  /system
	cp -rf /tmp/anykernel/11/vendor  /vendor
fi
cp -fr /tmp/anykernel/init.qcom.test.rc /vendor/etc/init/hw/init.qcom.test.rc
chmod 644 /vendor/etc/init/hw/init.qcom.test.rc
chown root.root /vendor/etc/init/hw/init.qcom.test.rc
cp -fr /tmp/anykernel/wlan.ko /vendor/lib/modules/pronto_wlan.ko
chmod 644 /vendor/lib/modules/pronto_wlan.ko
chown root.root /vendor/lib/modules/pronto_wlan.ko
set_con vendor_configs_file /vendor/etc/init/hw/init.qcom.test.rc
ui_print "Kernel Boot Script Added!!..."
ui_print "Cleaning /vendor/lib/modules..."
rm -rf /vendor/lib/modules/audio_*
rm -rf /vendor/lib/modules/exfat.ko
ui_print "Cleaned Successfully!!"

write_boot;
## end install
