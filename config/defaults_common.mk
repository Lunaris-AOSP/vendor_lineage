# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

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

PRODUCT_PACKAGES += \
    LowProfileOverlay

TARGET_PRODUCT_PROP += \
    vendor/lineage/config/defaults_common.prop
