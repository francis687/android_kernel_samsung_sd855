#!/bin/bash

DEVICE=gts6l
DEFCONFIG=gts6l_eur_open_defconfig

BUILD_CROSS_COMPILE=/home/mentalmuso/kernel/toolchain/4.9-2/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=/home/mentalmuso/kernel/toolchain/clang2/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"
KERN=/home/mentalmuso/kernel/android_kernel_samsung_sd855
TODAY=`date +%Y-%m-%d.%H:%M`
WETA=$KERN/WETA

export ANDROID_MAJOR_VERSION=p
export PLATFORM_VERSION=9.0.0

mkdir out
mkdir $WETA
mkdir $WETA/$DEVICE

export ARCH=arm64

make -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE $DEFCONFIG
time make -j9 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE

cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
cp $(pwd)/out/arch/arm64/boot/Image-dtb $(pwd)/WETA/$DEVICE/Image-dtb

echo " "
echo "###########################################"
echo "# Kernel zip and img found in WETA folder #"
echo "###########################################"
echo " "


