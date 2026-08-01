# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

PRODUCT_MAKEFILES := \
    aosp_kenzo:$(LOCAL_DIR)/aosp_kenzo.mk \
    lineage_kenzo:$(LOCAL_DIR)/lineage_kenzo.mk

 $(foreach build_type, user userdebug eng, \
    $(eval COMMON_LUNCH_CHOICES += aosp_kenzo-$(build_type)) \
    $(eval COMMON_LUNCH_CHOICES += lineage_kenzo-$(build_type)))
