include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Device/Default
  PROFILES := Default
  KERNEL := $(KERNEL_DTB) | uImage lzma
  IMAGE_SIZE := 7808k
  SUPPORTED_DEVICES := $(subst _,$(comma),$(1))
  DEVICE_VENDOR := Generic
  DEVICE_MODEL := MT76x8 device
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | check-size
endef

define Device/keenetic_kn-1121
	BLOCKSIZE := 64k
	IMAGE_SIZE := 31488k
	DEVICE_VENDOR := Keenetic
	DEVICE_MODEL := KN-1121
	DEVICE_PACKAGES := kmod-mt76x2 kmod-usb2 kmod-usb-ohci
	IMAGES += factory.bin
	IMAGE/factory.bin := $$(sysupgrade_bin) | pad-to $$$$(BLOCKSIZE) | \
		check-size | zyimage -d 0x801121 -v "KN-1121"
endef
TARGET_DEVICES += keenetic_kn-1121
