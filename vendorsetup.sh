# Vendor Tree
rm -rf vendor/xiaomi/kenzo
git clone https://github.com/Dheeraj3031A/vendor_xiaomi_kenzo.git -b lineage-19.1-test vendor/xiaomi/kenzo --depth=1

# Kernel Tree
rm -rf kernel/xiaomi/kenzo
git clone https://github.com/Dheeraj3031A/kernel_xiaomi_kenzo.git kernel/xiaomi/kenzo --depth=1
