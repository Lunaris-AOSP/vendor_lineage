# Use a profile based boot image for this device. Low ram optimized taken from atv devices.
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_COPY_FILES += vendor/lineage/product/lowram_boot_profiles/preloaded-classes:system/etc/preloaded-classes
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := vendor/lineage/product/lowram_boot_profiles/boot-image-profile.txt

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/etc/preloaded-classes.txt

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.madvise.vdexfile.size=31457280\
    dalvik.vm.madvise.odexfile.size=31457280\
    dalvik.vm.madvise.artfile.size=0

TARGET_PRODUCT_PROP += \
    vendor/lineage/config/defaults_common.prop
