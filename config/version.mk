PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0

# Increase EVO Version with each major release.
LUNARIS_VERSION := 3.1
LUNARIS_BUILD_TYPE ?= Community

# Internal version
LINEAGE_VERSION := Lunaris-AOSP-$(LINEAGE_BUILD)-$(LUNARIS_BUILD_TYPE)-$(LUNARIS_VERSION)-$(LUNARIS_PACKAGE_TYPE)-$(shell date -u +%Y%m%d%H)

# Display version
LINEAGE_DISPLAY_VERSION := v$(LUNARIS_VERSION)-$(shell date -u +%Y%m%d)

# Lunaris os version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.lunaris.build.version=$(LINEAGE_VERSION) \
    ro.lunaris.package.type=$(LUNARIS_PACKAGE_TYPE) \
    ro.lunaris.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lunaris.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LUNARIS_VERSION) \
    ro.lunaris.build.type=$(LUNARIS_VERSION)-$(LUNARIS_BUILD_TYPE)

