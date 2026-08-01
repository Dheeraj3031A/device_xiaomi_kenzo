# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

 $(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
 $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
 $(call inherit-product, device/xiaomi/kenzo/device.mk)

PRODUCT_NAME := aosp_kenzo
PRODUCT_DEVICE := kenzo
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := Redmi Note 3
