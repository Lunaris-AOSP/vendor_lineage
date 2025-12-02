PRODUCT_PACKAGES += \
    AxionWidgets \
    GameSpace \
    BtHelper \
    LMOFreeform \
    LMOFreeformSidebar \
    LMOSystemUIClock \
    OmniJaws \
    OmniStyle

# Updater
ifeq ($(WITH_GMS),true)
    PRODUCT_PACKAGES += \
        Updater
endif

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
endif

# Quick Tap
TARGET_SUPPORTS_QUICK_TAP ?= true
ifeq ($(TARGET_SUPPORTS_QUICK_TAP),true)
PRODUCT_PACKAGES += \
    ColumbusService
endif

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-crdroid-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-crdroid-product.xml

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

PRODUCT_PRODUCT_PROPERTIES += \
    pm.dexopt.downgrade_after_inactive_days=10 \
    dalvik.vm.enable_pr_dexopt=true \
    dalvik.vm.finalizer-timeout-ms=40000 \
    dalvik.vm.ps-min-first-save-ms=150000

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.minidebuginfo=false \
    dalvik.vm.dex2oat-minidebuginfo=false

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false
OVERRIDE_DISABLE_DEXOPT_ALL := false

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

TARGET_OPTIMIZED_DEXOPT ?= false
ifeq ($(TARGET_OPTIMIZED_DEXOPT),true)
    PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed
    PRODUCT_SYSTEM_PROPERTIES += \
        pm.dexopt.post-boot=speed-profile \
        pm.dexopt.first-boot=speed-profile \
        pm.dexopt.boot-after-ota=speed-profile \
        pm.dexopt.boot-after-mainline-update=speed \
        pm.dexopt.install=speed-profile \
        pm.dexopt.install-fast=speed \
        pm.dexopt.install-bulk=speed-profile \
        pm.dexopt.install-bulk-secondary=speed \
        pm.dexopt.install-bulk-downgraded=speed \
        pm.dexopt.install-bulk-secondary-downgraded=speed \
        pm.dexopt.bg-dexopt=speed \
        pm.dexopt.ab-ota=speed-profile \
        pm.dexopt.inactive=speed \
        pm.dexopt.cmdline=speed \
        pm.dexopt.first-use=speed-profile \
        pm.dexopt.secondary=speed-profile \
        pm.dexopt.shared=speed \
        dalvik.vm.dex2oat-filter=speed \
        dalvik.vm.image-dex2oat-filter=speed \
        dalvik.vm.foreground-heap-growth-multiplier=2.0

    PRODUCT_DEX_PREOPT_DEFAULT_FLAGS += \
        --compiler-filter=speed \
        --no-watch-dog

    $(call add-product-dex-preopt-module-config,services,--compiler-filter=speed)
    $(call add-product-dex-preopt-module-config,wifi-service,--compiler-filter=speed)

    DEX2OAT_THREADS := 8
    DEX2OAT_CORES := 0-7
endif

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.system_server=off
    
# Use a generic profile based boot image by default
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/boot/boot-image-profile.txt

# Quick Switch
TARGET_DEFAULT_PIXEL_LAUNCHER ?= false
WITH_GMS ?= true
ifeq ($(WITH_GMS),true)
ifeq ($(TARGET_DEFAULT_PIXEL_LAUNCHER), true)
# Pixel Launcher
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.default_launcher=1 \
    persist.sys.quickswitch_pixel_shipped=1
else
# Launcher3
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.default_launcher=0 \
    persist.sys.quickswitch_pixel_shipped=1
endif
else
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.default_launcher=0
endif

# Enable blur
TARGET_ENABLE_BLUR ?= true
ifeq ($(TARGET_ENABLE_BLUR),true)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=true \
    persist.sysui.disableBlur=false \
    ro.surface_flinger.supports_background_blur=1
else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=false \
    persist.sysui.disableBlur=true \
    ro.surface_flinger.supports_background_blur=0
endif

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
    persist.sys.pihooks_PRODUCT?=comet_beta \
    persist.sys.pihooks_DEVICE?=comet \
    persist.sys.pihooks_ID?=BP41.250916.015 \
    persist.sys.pihooks_RELEASE?=16 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-10-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=32 \
    persist.sys.pihooks_SDK_INT?=36 \
    persist.sys.pixelprops.gms=true

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/comet_beta/comet:16/BP41.250916.015/14394230:user/release-keys" \
    PihooksGmsModel="Pixel 10 Pro Fold"

PRODUCT_PRODUCT_PROPERTIES += \
    remote_provisioning.enable_rkpd=true \
    remote_provisioning.hostname=remoteprovisioning.googleapis.com

BYPASS_CHARGE_SUPPORTED ?= false

PERF_ANIM_OVERRIDE ?= false
TARGET_USES_SLMK ?= false
TARGET_SLMK_DEBUG ?= false

# uclamp properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.surface_flinger.uclamp.min=165

# UDFPS properties
PRODUCT_SYSTEM_PROPERTIES += \
    lunaris_udfps_custom=$(TARGET_CUSTOM_UDFPS)

# AxionOS properties
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.battery_bypass_supported=$(BYPASS_CHARGE_SUPPORTED) \
    persist.sys.activity_anim_perf_override=$(PERF_ANIM_OVERRIDE) \
    persist.sys.axion_gpu_freqs_path=$(GPU_FREQS_PATH) \
    persist.sys.axion_gpu_minfreq_file=$(GPU_MIN_FREQ_PATH) \
    ro.lmk.use_simple_lmk=$(TARGET_USES_SLMK) \
    ro.lmk.slmk_debug=$(TARGET_SLMK_DEBUG)

ifeq ($(PERF_ANIM_OVERRIDE),true)
PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.predict_hwc_composition_strategy=0
endif

# dex2oat
PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.dex2oat-threads=$(DEX2OAT_THREADS) \
    dalvik.vm.restore-dex2oat-threads=$(DEX2OAT_THREADS) \
    dalvik.vm.dex2oat-cpu-set=$(DEX2OAT_CORES) \
    dalvik.vm.restore-dex2oat-cpu-set=$(DEX2OAT_CORES)
