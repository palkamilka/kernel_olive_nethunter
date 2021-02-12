#!/bin/bash
echo -e "\e[32mKernel build started\e[0m"
echo -e "\e[32mStep 1 Clearing...\e[0m"
export TARGET_PRODUCT=lolz
sudo make clean
sudo make mrproper
sudo rm -rf out
sudo rm -rf compile/kernel.zip
sudo rm -rf kernel.zip
sudo rm -rf compile/Image.gz-dtb
sudo rm -rf compile/wlan.ko
sudo rm -rf kernel-headers
sudo rm -rf kernel-headers.zip
echo -e "\e[32mCleaning complete\e[0m"
sleep 10
clear
echo -e "\e[32m Step 2 Defconfig build...\e[0m"
sudo make palkamilka_3.0_defconfig O=out ARCH=arm64
cd out
sudo perl -i -pe 's/CONFIG_LOCALVERSION="0"/CONFIG_LOCALVERSION="NetHunterv2.9"/' .config
cd ../
echo -e "\e[32mDefconfig build completed\e[0m"
echo -e "\e[32mStep 3 Building the kernel...\e[0m"
sudo make -j17 O=out ARCH=arm64 CROSS_COMPILE=/home/palkamilka/kernel_olive_nethunter/gcc_arm64/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/kernel_olive_nethunter/gcc_arm64/bin/arm-linux-gnueabihf- TARGET_PRODUCT=lolz
echo -e "\e[32mBuilding the kernel complited\e[0m"
sleep 10
echo -e "\e[32mStep 4 Build a zip archive for installation in TWRP...\e[0m"
sudo cp -rf out/arch/arm64/boot/Image.gz-dtb compile/Image.gz-dtb
sudo cp -rf out/drivers/staging/prima/wlan.ko compile/wlan.ko
cd compile
sudo zip -r kernel.zip *
cd ../
sudo cp compile/kernel.zip kernel.zip
echo -e "\e[32mCompleted zip compilation\e[0m"
#echo -e "\e[32mStep 5 The kernel-headers assembly...\e[0m"
#sudo make -j9 O=kernel-headers ARCH=arm64 CROSS_COMPILE=/home/palkamilka/gcc/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/cc/bin/arm-linux-gnueabihf- palkamilka_1.4_defconfig 
#sudo make -j9 O=kernel-headers ARCH=arm64 CROSS_COMPILE=/home/palkamilka/gcc/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/cc/bin/arm-linux-gnueabihf- modules_prepare
#sudo make -j9 O=kernel-headers ARCH=arm64 CROSS_COMPILE=/home/palkamilka/gcc/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/cc/bin/arm-linux-gnueabihf- modules INSTALL_MOD_PATH=kernel-headers
#sudo make -j9 O=kernel-headers ARCH=arm64 CROSS_COMPILE=/home/palkamilka/gcc/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/cc/bin/arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=kernel-headers
#sudo make -j9 headers_install ARCH=arm64 CROSS_COMPILE=/home/palkamilka/gcc/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=/home/palkamilka/cc/bin/arm-linux-gnueabihf- INSTALL_HDR_PATH=kernel-headers 
#cd kernel-headers
#sudo zip -r kernel-headers.zip *
#cd ../
#sudo cp kernel-headers/kernel-headers.zip kernel-headers.zip
#echo -e "\e[32mKernel-headers build done\e[0m"
echo -e "\e[32mCOMPLETED\e[0m"
