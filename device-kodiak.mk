#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# kodiak (Pixel 11 Pro XL); the shared family config is in device/google/malibu.

# Prebuilt; the Image is the family build, vendor_dlkm and dtbo are kodiak's own.
TARGET_LINUX_KERNEL_VERSION := 6.12
TARGET_KERNEL_DEVICE := kodiak
TARGET_KERNEL_DIR := device/google/$(TARGET_KERNEL_DEVICE)-kernels/$(TARGET_LINUX_KERNEL_VERSION)

# Recovered from the stock overlays the blob list drops; priorities are stock's own,
# vendor 0 and product 1.
PRODUCT_PACKAGES += \
    FrameworkResOverlayVendorKodiak \
    FrameworkResOverlayProductKodiak \
    SystemUIGoogleOverlayVendorKodiak \
    SystemUIGoogleOverlayProductKodiak \
    SettingsGoogleOverlayVendorKodiak \
    SettingsGoogleOverlayProductKodiak \
    TeleServiceOverlayVendorKodiak \
    TeleServiceOverlayProductKodiak \
    SettingsProviderOverlayVendorKodiak \
    SettingsProviderOverlayProductKodiak \
    FrameworkResOverlayLineageKodiak \
    LineageSdkOverlayKodiak \
    SettingsOverlayLineageKodiak

# config_face_enroll points Settings here; the HAL draws the preview itself.
PRODUCT_PACKAGES += \
    FaceEnroll

# Alch3myOS About phone
PRODUCT_PACKAGES += \
    Alch3mySettingsKodiak

PRODUCT_PRODUCT_PROPERTIES += \
    ro.alch3my.maintainer=Pyrtle93 \
    ro.alch3my.maintainer.url=https://t.me/PyrtlesPixels

# The three vendor.*.modules/devices.ready properties gate the init blocks incl. the
# vibrator HAL; without them system_server waits on IVibratorManager forever.
PRODUCT_COPY_FILES += \
    device/google/kodiak/init.insmod.kodiak.cfg:$(TARGET_COPY_OUT_VENDOR_DLKM)/etc/init.insmod.kodiak.cfg

# Starts stock's NFC HAL; the blob list skips stock's own init script for it.
PRODUCT_COPY_FILES += \
    device/google/kodiak/nfc/nfc2-service-default.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/nfc2-service-default.rc

# The qfp extension interface only the fingerprint daemon registers.
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/vintf/qfp_framework_matrix_system_ext.xml

# Vendor properties recovered from stock. Without ro.hardware.egl there is no display.
include device/google/kodiak/vendor_props.mk
