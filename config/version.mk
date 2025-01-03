PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

ifeq ($(WITH_GMS), true)
    LUNARIS_EDITION ?= PIXEL
else
    LUNARIS_EDITION ?= VANILLA
endif

# Increase CR Version with each major release.
LUNARIS_VERSION := 2.4

# Internal version
LINEAGE_VERSION := Lunaris-OS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-v$(LUNARIS_VERSION)-$(LUNARIS_EDITION)

# Display version
LINEAGE_DISPLAY_VERSION := v$(LUNARIS_VERSION)-$(shell date +%Y%m%d)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.lunaris.build.version=$(LINEAGE_VERSION) \
    ro.lunaris.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lunaris.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LUNARIS_VERSION)
