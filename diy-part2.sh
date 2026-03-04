#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
# Добавляем поддержку KN-1121 с правильными табами
printf '\ndefine Device/keenetic_kn-1121\n\tBLOCKSIZE := 64k\n\tIMAGE_SIZE := 31488k\n\tDEVICE_VENDOR := Keenetic\n\tDEVICE_MODEL := KN-1121\n\tDEVICE_PACKAGES := kmod-mt76x2 kmod-usb2 kmod-usb-ohci\n\tIMAGES += factory.bin\n\tIMAGE/factory.bin := $$(sysupgrade_bin) | pad-to $$$$(BLOCKSIZE) | check-size | zyimage -d 0x801121 -v "KN-1121"\nendef\nTARGET_DEVICES += keenetic_kn-1121\n' >> target/linux/ramips/image/mt76x8.mk
sudo rm -rf /swapfile
curl -sSL https://github.com/akruserg/fqaa/edit/main/mt76x8.mk > target/linux/ramips/image/mt76x8.mk
