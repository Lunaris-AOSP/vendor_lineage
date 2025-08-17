#!/bin/bash
#
# Copyright (C) 2019-2025 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#

# $1 = TARGET_DEVICE
# $2 = PRODUCT_OUT
# $3 = FILE_NAME

existingOTAjson=./vendor/OTA/builds/$1.json
output=$2/$1.json

# Cleanup old file
if [ -f "$output" ]; then
    rm "$output"
fi

echo "Generating JSON file data for OTA support..."

# Helper function to extract field from JSON
extract_field() {
    grep "\"$1\":" "$existingOTAjson" \
        | sed -n "s/.*\"$1\": *\"\([^\"]*\)\".*/\1/p" \
        | xargs
}

if [ -f "$existingOTAjson" ]; then
    MAINTAINER=$(extract_field "maintainer")
    OEM=$(extract_field "oem")
    DEVICE=$(extract_field "device")
    BUILDTYPE=$(extract_field "buildtype")
    FORUM=$(extract_field "forum")
    GAPPS=$(extract_field "gapps")
    FIRMWARE=$(extract_field "firmware")
    MODEM=$(extract_field "modem")
    BOOTLOADER=$(extract_field "bootloader")
    RECOVERY=$(extract_field "recovery")
    PAYPAL=$(extract_field "paypal")
    TELEGRAM=$(extract_field "telegram")
    DT=$(extract_field "dt")
    COMMON_DT=$(extract_field "common-dt")
    KERNEL=$(extract_field "kernel")
fi

# OTA data
FILENAME=$3

VERSION=$(echo "$3" | cut -d'-' -f5 | sed 's/v//')
V_MAX=$(echo "$VERSION" | cut -d'.' -f1)
V_MIN=$(echo "$VERSION" | cut -d'.' -f2)
VERSION="$V_MAX.$V_MIN"

BUILDPROP="$2/system/build.prop"
TIMESTAMP=$(grep "ro.system.build.date.utc" "$BUILDPROP" | cut -d'=' -f2)

MD5=$(md5sum "$2/$3" | cut -d' ' -f1)
SHA256=$(sha256sum "$2/$3" | cut -d' ' -f1)
SIZE=$(stat -c "%s" "$2/$3")

# Generate JSON output (Python-compatible download URL)
cat <<EOF >"$output"
{
  "response": [
    {
      "maintainer": "${MAINTAINER:-}",
      "oem": "${OEM:-}",
      "device": "${DEVICE:-}",
      "filename": "$FILENAME",
      "download": "https://sourceforge.net/projects/ghosuto/files/$1/$3/download",
      "timestamp": $TIMESTAMP,
      "md5": "$MD5",
      "sha256": "$SHA256",
      "size": $SIZE,
      "version": "$VERSION",
      "buildtype": "${BUILDTYPE:-}",
      "forum": "${FORUM:-}",
      "gapps": "${GAPPS:-}",
      "firmware": "${FIRMWARE:-}",
      "modem": "${MODEM:-}",
      "bootloader": "${BOOTLOADER:-}",
      "recovery": "${RECOVERY:-}",
      "paypal": "${PAYPAL:-}",
      "telegram": "${TELEGRAM:-}",
      "dt": "${DT:-}",
      "common-dt": "${COMMON_DT:-}",
      "kernel": "${KERNEL:-}"
    }
  ]
}
EOF

if [ ! -f "$existingOTAjson" ]; then
    echo "There is no official support for this device yet"
fi

echo "JSON file generation completed"
