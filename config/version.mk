PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0

# Increase Lunaris Version with each major release.
LUNARIS_VERSION := 3.7

# Internal version
LINEAGE_VERSION := LunarisAOSP-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-v$(LUNARIS_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := v$(LUNARIS_VERSION)-$(shell date +%Y%m%d)

# LineageOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lunaris.build.version=$(LUNARIS_VERSION) \
    ro.lunaris.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lunaris.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
