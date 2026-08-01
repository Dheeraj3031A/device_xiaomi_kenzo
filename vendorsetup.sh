#!/bin/bash

# Common Mainline QCOM Tree
rm -rf device/mainline/qcom-common
git clone https://github.com/LineageOS/android_device_mainline_qcom-common.git -b lineage-23.2 device/mainline/qcom-common --depth=1

# Mainline Kernel (Codeberg)
rm -rf kernel/mainline/msm8956-mainline
git clone https://codeberg.org/msm8956-mainline/linux.git kernel/mainline/msm8956-mainline --depth=1

# Mainline Common Device Tree
rm -rf device/mainline/common
git clone https://github.com/LineageOS/android_device_mainline_common.git -b lineage-23.2 device/mainline/common --depth=1

# Mainline Kernel Configs
rm -rf kernel/mainline/configs
git clone https://github.com/LineageOS/android_kernel_mainline_configs.git -b lineage-23.2 kernel/mainline/configs --depth=1

# Mainline Hardware Common
rm -rf hardware/mainline/common
git clone https://github.com/LineageOS/android_hardware_mainline_common.git -b lineage-23.2 hardware/mainline/common --depth=1

# Mainline Prebuilts Bootmgr
rm -rf prebuilts/bootmgr
git clone https://github.com/LineageOS/android_prebuilts_bootmgr.git -b lineage-23.2 prebuilts/bootmgr --depth=1

# Mainline Graphics (Mesa)
rm -rf external/mesa
git clone https://github.com/LineageOS/android_external_mesa.git -b lineage-23.2 external/mesa --depth=1

# Mainline Graphics (Minigbm)
rm -rf external/minigbm-upstream
git clone https://github.com/LineageOS/android_external_minigbm-upstream.git -b lineage-23.2 external/minigbm-upstream --depth=1

# Mainline Graphics (DRM HWComposer)
rm -rf external/drm_hwcomposer-upstream
git clone https://github.com/LineageOS/android_external_drm_hwcomposer-upstream.git -b lineage-23.2 external/drm_hwcomposer-upstream --depth=1

# Mainline Audio (TinyHAL)
rm -rf external/tinyhal
git clone https://github.com/LineageOS/android_external_tinyhal.git -b lineage-23.2 external/tinyhal --depth=1

# Mainline Linux Firmware
rm -rf external/linux-firmware-mainline
git clone https://github.com/LineageOS/android_external_linux-firmware-mainline.git -b lineage-23.2 external/linux-firmware-mainline --depth=1

# Mainline Bootloader (lk2nd)
rm -rf external/lk2nd
git clone https://github.com/LineageOS/android_external_lk2nd.git -b lineage-23.2 external/lk2nd --depth=1

# Mainline Sensors (IIO)
rm -rf hardware/intel/sensors-iio
git clone https://github.com/LineageOS/android_hardware_intel_sensors-iio.git -b lineage-23.2 hardware/intel/sensors-iio --depth=1

# Timekeep
rm -rf hardware/sony/timekeep
git clone https://github.com/LineageOS/android_hardware_sony_timekeep -b lineage-23.2 harwdware/sony/timekeep --depth=1

# Mainline Graphics (DRM HWComposer)
rm -rf external/libdisplay-info-upstream
git clone https://github.com/LineageOS/android_external_libdisplay-info-upstream.git -b lineage-23.2 external/libdisplay-info-upstream --depth=1

# Auto-fix: Create the msm8956 SoC folder in qcom-common if it doesn't exist
QCOM_COMMON_SOC="device/mainline/qcom-common/soc/msm8956"
if [ ! -d "$QCOM_COMMON_SOC" ]; then
    echo -e "${YELLOW}Setting up msm8956 SoC family in qcom-common...${NC}"
    cp -r device/mainline/qcom-common/soc/msm8953 "$QCOM_COMMON_SOC"
    
    # Update the makefiles to reference msm8956 instead of msm8953
    sed -i 's/msm8953/msm8956/g' "$QCOM_COMMON_SOC/board.mk"
    sed -i 's/msm8953/msm8956/g' "$QCOM_COMMON_SOC/product.mk"
    echo -e "${GREEN}Created msm8956 SoC family successfully.${NC}"
else
    echo -e "${GREEN}msm8956 SoC family already exists.${NC}"
fi
