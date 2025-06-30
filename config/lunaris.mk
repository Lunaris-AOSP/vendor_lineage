PRODUCT_PACKAGES += \
    Updater \
    GameSpace \
    BtHelper

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
endif

# Google Overlays
PRODUCT_PACKAGES += \
    CustomFontPixelLauncherOverlay

# Art
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.post-boot=speed \
    pm.dexopt.first-boot=speed \
    pm.dexopt.boot-after-ota=speed-profile \
    pm.dexopt.boot-after-mainline-update=speed \
    pm.dexopt.install=speed-profile \
    pm.dexopt.install-fast=speed \
    pm.dexopt.install-bulk=speed-profile \
    pm.dexopt.install-bulk-secondary=speed \
    pm.dexopt.install-bulk-downgraded=speed \
    pm.dexopt.install-bulk-secondary-downgraded=speed \
    pm.dexopt.bg-dexopt=speed \
    pm.dexopt.ab-ota=speed \
    pm.dexopt.inactive=speed \
    pm.dexopt.cmdline=speed \
    pm.dexopt.first-use=speed \
    pm.dexopt.secondary=speed \
    pm.dexopt.shared=speed \
    pm.dexopt.downgrade_after_inactive_days=20

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed
OVERRIDE_DISABLE_DEXOPT_ALL := false

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Face Unlock
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=tangorpro_beta \
    persist.sys.pihooks_DEVICE?=tangorpro \
    persist.sys.pihooks_ID?=BP31.250523.006 \
    persist.sys.pihooks_RELEASE?=16 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-05-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21 \
    persist.sys.pihooks_SDK_INT?=35

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/tangorpro_beta/tangorpro:16/BP31.250523.006/13607978:user/release-keys" \
    PihooksGmsModel="Pixel Tablet"
