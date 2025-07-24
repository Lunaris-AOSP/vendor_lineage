# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/lineage/config/tablet.mk)

$(call inherit-product, vendor/lineage/config/telephony.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/foldable_book

# GMS
WITH_GMS ?= true
ifeq ($(WITH_GMS),true)
  ifeq ($(TARGET_USES_OMNI_GAPPS),true)
    $(call inherit-product, vendor/gms/gms_mini.mk)
    $(call inherit-product, vendor/pixel-style/config/common.mk)
    LUNARIS_PACKAGE_TYPE := Omni
  else ifeq ($(TARGET_USES_CORE_GAPPS),true)
    $(call inherit-product, vendor/gms/gms_pico.mk)
    $(call inherit-product, vendor/pixel-style/config/common.mk)
    LUNARIS_PACKAGE_TYPE := Core
  else
    $(call inherit-product, vendor/gms/gms_full.mk)
    $(call inherit-product, vendor/pixel-style/config/common.mk)
    LUNARIS_PACKAGE_TYPE := Gapps
  endif
else
  LUNARIS_PACKAGE_TYPE := Vanilla
endif