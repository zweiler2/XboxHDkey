const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "xboxhdkey",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    exe.root_module.addIncludePath(b.path("include"));
    exe.root_module.addCSourceFiles(.{
        .language = .c,
        .root = b.path("src"),
        .files = &.{
            "apt.c",
            "sgio.c",
            "sysfs.c",
            "BootEEPROM.c",
            "BootHddKey.c",
            "rc4.c",
            "sha1.c",
            "main.c",
        },
        .flags = &.{
            "-std=gnu99",
            "-Wall",
            "-Wextra",
            "-Werror",
        },
    });

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();
}
