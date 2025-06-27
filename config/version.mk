PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0

# Increase EVO Version with each major release.
LUNARIS_VERSION := 3.0
LUNARIS_BUILD_TYPE ?= Beta

# Internal version
LINEAGE_VERSION := Lunaris-AOSP-$(shell date -u +%Y%m%d%H)-$(LINEAGE_BUILD)-$(LUNARIS_VERSION)-$(LUNARIS_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := v$(LUNARIS_VERSION)-$(shell date -u +%Y%m%d)

# Lunaris os version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.lunaris.build.version=$(LINEAGE_VERSION) \
    ro.lunaris.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lunaris.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LUNARIS_VERSION)
