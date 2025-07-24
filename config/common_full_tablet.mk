# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/lineage/config/tablet.mk)

$(call inherit-product, vendor/lineage/config/telephony.mk)

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