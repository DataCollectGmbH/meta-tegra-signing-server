inherit digsigserver l4t_bsp

def tegra_uefi_signing_deps(d, tasks=False):
    deps = ['curl-native']
    if tasks:
        return ' '.join([d + ':do_populate_sysroot' for d in deps])
    return ' '.join(deps)

TEGRA_UEFI_SIGNING_TASKDEPS ?= "${@tegra_uefi_signing_deps(d, tasks=True)}"
TEGRA_UEFI_SIGNING_DEPENDS ?= "${@tegra_uefi_signing_deps(d)}"
TEGRA_UEFI_USE_SIGNED_FILES = "true"

tegra_uefi_sbsign() {
    digsig_post sign/tegra/uefi -F "machine=${MACHINE}" -F "signing_type=sbsign" -F "artifact=@$1" --output $1
}

tegra_uefi_split_sign() {
    digsig_post sign/tegra/uefi -F "machine=${MACHINE}" -F "signing_type=signature" -F "artifact=@$1" --output "$1".sig
}

tegra_uefi_attach_sign() {
    digsig_post sign/tegra/uefi -F "machine=${MACHINE}" -F "signing_type=attach_signature" -F "artifact=@$1" --output "$1".signed
}
