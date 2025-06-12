load("//build/kernel/kleaf:kernel.bzl", "ddk_module")
load("//build/bazel_common_rules/dist:dist.bzl", "copy_to_dist_dir")

def eavb_get_srcs():
    srcs = [
        "virtio_eavb.c",
    ]

    return srcs

def define_target_variant_module(target, variant):
    tv = "{}_{}".format(target, variant)
    rule_name = "{}_virtio_eavb".format(tv)
    kernel_build = "//msm-kernel:{}".format(tv)

    ddk_module(
        name = rule_name,
        out = "eavb_fe.ko",
        srcs = eavb_get_srcs(),
        hdrs = ["vio_eavb.h",
            "eavb_shared.h"],
        deps = [
            "//msm-kernel:all_headers"],
        kernel_build = kernel_build,
        visibility = ["//visibility:public"]
    )

    copy_to_dist_dir(
        name = "{}_dist".format(rule_name),
        data = [rule_name],
        dist_dir = "out/eavb",
        flat = True,
        wipe_dist_dir = False,
        allow_duplicate_filenames = False,
        mode_overrides = {"**/*": "644"},
        log = "info",
    )

def define_target_module(target):
    define_target_variant_module(target, "gki")
    define_target_variant_module(target, "consolidate")