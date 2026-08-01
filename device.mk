# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

TARGET_DEVICE_PATH := device/xiaomi/kenzo

# Inherit options from mainline/qcom-common
TARGET_HAS_IR := true
TARGET_QCOM_SOC_FAMILY := msm8956
TARGET_SENSORS_HAL := iio
TARGET_SUPPORTS_SUSPEND := false
include device/mainline/qcom-common/optional/options.mk

# Inherit from mainline/qcom-common
 $(call inherit-product, device/mainline/qcom-common/mainline_qcom-common.mk)

# Bluetooth class of device (phone)
PRODUCT_ODM_PROPERTIES += \
    bluetooth.device.class_of_device=90,2,12

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true

# HIDL
PRODUCT_PACKAGES += \
    vndservicemanager

# Kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(TARGET_DEVICE_PATH)/overlays/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.consumerir.xml

# Set device properties
PRODUCT_PACKAGES += \
    set_device_prop \
    set_device_prop.recovery

# Scoped storage
 $(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Sensors (IIO)
PRODUCT_PACKAGES += \
    android.hardware.sensor.accelerometer.prebuilt.xml \
    android.hardware.sensor.compass.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 28

# AAPT
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio (TinyHAL policy xml)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.xml,$(TARGET_DEVICE_PATH)/audio/,$(TARGET_COPY_OUT_VENDOR)/etc/)

TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Dalvik heap
 $(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)



# libinit reads device props from devicetree
 $(call soong_config_set,mainline_common_libinit,set_properties_from,devicetree)

# Partitions
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(TARGET_DEVICE_PATH) \
    kernel/mainline/configs

# Dynamically copy mainline firmware files to the vendor image
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/prebuilts/firmware,$(TARGET_COPY_OUT_VENDOR)/firmware) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/prebuilts/acdb,$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8976-tasha-snd-card)

# Vendor specific files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.kenzo.rc:root/init.kenzo.rc \
    $(LOCAL_PATH)/init/init.recovery.kenzo.rc:root/init.recovery.kenzo.rc \
    $(LOCAL_PATH)/init/ueventd.kenzo.rc:root/ueventd.kenzo.rc \
    $(LOCAL_PATH)/fstab/fstab.kenzo:root/fstab.kenzo \
    $(LOCAL_PATH)/fstab/fstab.kenzo.ramdisk:root/fstab.kenzo.ramdisk \
    $(LOCAL_PATH)/modprobe/mainline/modules.load.basic:$(TARGET_COPY_OUT_VENDOR)/etc/modules.load.basic \
    $(LOCAL_PATH)/modprobe/mainline/modules.load.drm:$(TARGET_COPY_OUT_VENDOR)/etc/modules.load.drm \
    $(LOCAL_PATH)/modprobe/mainline/modules.load.panel.kenzo:$(TARGET_COPY_OUT_VENDOR)/etc/modules.load.panel.kenzo \
    $(LOCAL_PATH)/modprobe/mainline/modules.load.touchscreen:$(TARGET_COPY_OUT_VENDOR)/etc/modules.load.touchscreen
