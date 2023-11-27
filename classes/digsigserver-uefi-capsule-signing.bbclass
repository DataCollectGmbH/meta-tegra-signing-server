TEGRA_UEFI_CAPSULE_SIGNING_EXTRA_DEPS = "${DIGSIG_DEPS} gzip-native:do_populate_sysroot"

inherit digsigserver l4t_bsp


sign_uefi_capsules() {
    if [ -e ${DEPLOY_DIR_IMAGE}/${BUPFILENAME}.bl_only.bup-payload ]; then
        digsig_post sign/tegra/ueficapsule -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "guid=${GUID}" -F "artifact=@${DEPLOY_DIR_IMAGE}/${BUPFILENAME}.bl_only.bup-payload" --output ./tegra-bl.cap
    fi
    if [ -e ${DEPLOY_DIR_IMAGE}/${BUPFILENAME}.kernel_only.bup-payload ]; then
        digsig_post sign/tegra/ueficapsule -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "guid=${GUID}" -F "artifact=@${DEPLOY_DIR_IMAGE}/${BUPFILENAME}.kernel_only.bup-payload" --output ./tegra-kernel.cap
    fi
}
