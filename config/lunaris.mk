# Additional props
PRODUCT_PRODUCT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.com.google.ime.theme_id=5 \
    ro.opa.eligible_device=true \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.setupwizard.mode=OPTIONAL \
    setupwizard.feature.predeferred_enabled=false \
    drm.service.enabled=true \
    persist.sys.dun.override=0

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Enable dex2oat64 to do dexopt
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=true

ifeq ($(LUNARIS_BUILD_TYPE),Official)
PRODUCT_PACKAGES += \
    Updater
endif

# BtHelper
PRODUCT_PACKAGES += \
    BtHelper

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-lunaris-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-lunaris-product.xml

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
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

# Private keys
ifeq ($(LUNARIS_BUILD_TYPE),Official)
include vendor/lunaris-priv/keys/keys.mk
else
-include vendor/lunaris-priv/keys/keys.mk
endif
