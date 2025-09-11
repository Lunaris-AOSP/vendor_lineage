PRODUCT_PACKAGES += \
    GameSpace \
    BtHelper \
    LMOFreeform \
    LMOFreeformSidebar \
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

# Google Overlays
PRODUCT_PACKAGES += \
    CustomFontPixelLauncherOverlay

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Enable optimized dexopt tuning (default: false)
TARGET_OPTIMIZED_DEXOPT ?= false
ifeq ($(TARGET_OPTIMIZED_DEXOPT),true)
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.install=speed-profile \
    pm.dexopt.install-fast=speed-profile \
    pm.dexopt.install-bulk=speed-profile \
    pm.dexopt.install-bulk-secondary=speed \
    pm.dexopt.install-bulk-downgraded=speed \
    pm.dexopt.install-bulk-secondary-downgraded=speed \
    pm.dexopt.bg-dexopt=speed \
    pm.dexopt.inactive=speed \
    pm.dexopt.cmdline=speed \
    pm.dexopt.secondary=speed \
    pm.dexopt.shared=speed \
    pm.dexopt.downgrade_after_inactive_days=20
endif

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile
OVERRIDE_DISABLE_DEXOPT_ALL := false

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Quick Switch
TARGET_DEFAULT_PIXEL_LAUNCHER ?= true
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
    persist.sys.pihooks_PRODUCT?=husky_beta \
    persist.sys.pihooks_DEVICE?=husky \
    persist.sys.pihooks_ID?=BP31.250610.009 \
    persist.sys.pihooks_RELEASE?=16 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-07-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=32 \
    persist.sys.pihooks_SDK_INT?=36 \
    persist.sys.pixelprops.gms=true

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/husky_beta/husky:16/BP31.250610.009/13905196:user/release-keys" \
    PihooksGmsModel="Pixel 8 Pro"

PRODUCT_PACKAGES += \
    CertifiedKeyboxOverlay

LUNARIS_CPU_SMALL_CORES ?= 0,1,2,3
LUNARIS_CPU_BIG_CORES ?= 4,5,6,7
LUNARIS_ALL_CORES ?= 0-7
LUNARIS_CPU_BG ?= 0-2
LUNARIS_CPU_SYS_BG ?= 0-3
LUNARIS_CPU_FG ?= 0-7
LUNARIS_CPU_LIMIT_BG ?= 0-1
LUNARIS_CPU_LIMIT_UI ?= 0-2
LUNARIS_CPU_DISPLAY ?= 0-5

BYPASS_CHARGE_SUPPORTED ?= false

PERF_ANIM_OVERRIDE ?= false

DEX2OAT_CORES ?= 0,1,2,3,4,5
DEX2OAT_THREADS ?= 5

# uclamp properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lmk.critical_upgrade=true \
    ro.lmk.upgrade_pressure=40 \
    ro.lmk.downgrade_pressure=60 \
    ro.lmk.kill_heaviest_task=false \
    ro.config.per_app_memcg=true \
    ro.surface_flinger.uclamp.min=1

# AxionOS properties
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.axion_cpu_big=$(LUNARIS_CPU_BIG_CORES) \
    persist.sys.axion_cpu_small=$(LUNARIS_CPU_SMALL_CORES) \
    persist.sys.axion_cpu_bg=$(LUNARIS_CPU_BG) \
    persist.sys.axion_cpu_limit_bg=$(LUNARIS_CPU_LIMIT_BG) \
    persist.sys.axion_cpu_sys_bg=$(LUNARIS_CPU_SYS_BG) \
    persist.sys.axion_cpu_fg=$(LUNARIS_CPU_FG) \
    persist.sys.axion_cpu_limit_ui=$(LUNARIS_CPU_LIMIT_UI) \
    persist.sys.axion_cpu_unlimit_ui=$(LUNARIS_ALL_CORES) \
    persist.sys.axion_cpu_display=$(LUNARIS_CPU_DISPLAY) \
    persist.sys.battery_bypass_supported=$(BYPASS_CHARGE_SUPPORTED) \
    persist.sys.activity_anim_perf_override=$(PERF_ANIM_OVERRIDE)

# dex2oat
PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.dex2oat-threads=$(DEX2OAT_THREADS) \
    dalvik.vm.restore-dex2oat-threads=$(DEX2OAT_THREADS) \
    dalvik.vm.dex2oat-cpu-set=$(DEX2OAT_CORES) \
    dalvik.vm.restore-dex2oat-cpu-set=$(DEX2OAT_CORES)
