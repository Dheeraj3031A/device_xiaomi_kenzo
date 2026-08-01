# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

TARGET_DEVICE_PATH := device/xiaomi/kenzo
DEVICE_PATH := $(TARGET_DEVICE_PATH)
USES_DEVICE_XIAOMI_KENZO := true

# Inherit from your forked mainline/qcom-common (which has soc/msm8956)
include device/mainline/qcom-common/BoardConfigMainlineQcomCommon.mk

# Bootloader (lk2nd)
ifneq ($(TARGET_LK2ND_PLATFORM),)
BOARD_BOOT_HEADER_VERSION := 2
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_LK2ND_MAKE_FLAGS := OSVERSION_IN_BOOTIMAGE=1
endif

# Boot parameters
BOARD_KERNEL_CMDLINE := \
    $(MAINLINE_COMMON_ANDROIDBOOT_PARAMS) \
    $(MAINLINE_COMMON_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_KERNEL_PARAMS) \
    $(MAINLINE_QCOM_SOC_ANDROIDBOOT_PARAMS) \
    $(MAINLINE_QCOM_SOC_KERNEL_PARAMS) \
    androidboot.verifiedbootstate=orange \
    console=tty0

ifneq ($(TARGET_LK2ND_PLATFORM),)
BOARD_KERNEL_CMDLINE := lk2nd.pass-ramoops=zap
endif

BOARD_KERNEL_CMDLINE += \
    androidboot.selinux=permissive \
    audit=0 \
    androidboot.hardware=kenzo

# Filesystem
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Kernel (Codeberg msm8956-mainline)
TARGET_KERNEL_SOURCE := kernel/mainline/msm8956-mainline
TARGET_DTB_LIST_WILDCARD := \
    qcom/msm8956-xiaomi-kenzo \
    qcom/msm8976-xiaomi-kenzo
TARGET_KERNEL_CONFIG_EXT := \
    kernel/mainline/configs/fragments/android-base-pre/common.config \
    kernel/mainline/configs/fragments/android-base-pre/arm64.config \
    kernel/configs/b/android-6.12/android-base.config \
    kernel/mainline/configs/fragments/android-base-conditional/CONFIG_ARM64-y.config \
    kernel/mainline/configs/fragments/common.config \
    kernel/mainline/configs/fragments/y/fbcon.config \
    kernel/mainline/configs/fragments/n/disable-clang-hardening-features.config \
    kernel/mainline/configs/fragments/n/faster-build-time.config \
    $(TARGET_DEVICE_PATH)/kconfigs/basic.config \
    $(TARGET_DEVICE_PATH)/kconfigs/fixups.config

ifneq ($(TARGET_LK2ND_PLATFORM),)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
endif

# Kernel modules
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD := \
    $(strip $(shell cat $(TARGET_DEVICE_PATH)/modprobe/mainline/modules.load.basic)) \
    $(strip $(shell cat $(TARGET_DEVICE_PATH)/modprobe/mainline/modules.load.drm)) \
    $(strip $(shell cat $(TARGET_DEVICE_PATH)/modprobe/mainline/modules.load.panel.kenzo)) \
    $(strip $(shell cat $(TARGET_DEVICE_PATH)/modprobe/mainline/modules.load.touchscreen))
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := \
    $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)
TARGET_AUTO_COLLECT_KERNEL_MODULE_DEPS := true

# OTA
AB_OTA_UPDATER := false
TARGET_OTA_ASSERT_DEVICE := kate,kenzo

# Partitions (A-only; stock kenzo layout)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_VENDORIMAGE_EXTFS_INODE_COUNT := -1
BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_METADATA_PARTITION := true
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
TARGET_RECOVERY_DENSITY := xxhdpi
TARGET_RECOVERY_FSTAB := $(TARGET_DEVICE_PATH)/fstab/fstab.kenzo

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/properties/vendor.prop

# Ramdisk
BOARD_RAMDISK_USE_LZ4 := true

# SELinux
BOARD_ODM_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/odm

# VINTF
DEVICE_MANIFEST_FILE := \
    $(DEVICE_PATH)/vintf/manifest.xml
