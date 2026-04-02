//! Build script for pylegere
//!
//! You can use this directly with `zig build`, or use `pyoz build` for
//! automatic Python configuration detection.

const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Strip option (can be set via -Dstrip=true or from pyoz CLI)
    const strip = b.option(bool, "strip", "Strip debug symbols from the binary") orelse false;

    // Get PyOZ dependency
    const pyoz_dep = b.dependency("PyOZ", .{
        .target = target,
        .optimize = optimize,
    });

    // Legere dependency
    const legere = b.dependency(
        "legere",
        .{
            .target = target,
            .optimize = optimize,
        },
    );

    // Create the user's lib module
    const user_lib_mod = b.createModule(.{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
        .strip = strip,
        .imports = &.{
            .{ .name = "PyOZ", .module = pyoz_dep.module("PyOZ") },
            .{ .name = "legere", .module = legere.module("legere") },
        },
    });

    // To add custom C include paths or link objects, add them to user_lib_mod:
    //   user_lib_mod.addIncludePath(b.path("vendor/include"));
    //   user_lib_mod.addObjectFile(b.path("vendor/libfoo.a"));

    // Build the Python extension as a dynamic library
    const lib = b.addLibrary(.{
        .name = "pylegere",
        .linkage = .dynamic,
        .root_module = user_lib_mod,
    });

    // Link libc (required for Python C API)
    lib.linkLibC();

    // On Windows, link against the Python stable ABI library (python3.lib).
    // These options are passed automatically by `pyoz build`.
    // For manual `zig build` on Windows, pass: -Dpython-lib-dir=<path> -Dpython-lib-name=python3
    if (b.option([]const u8, "python-lib-dir", "Python library directory")) |lib_dir| {
        lib.addLibraryPath(.{ .cwd_relative = lib_dir });
    }
    if (b.option([]const u8, "python-lib-name", "Python library name")) |lib_name| {
        lib.linkSystemLibrary(lib_name);
    }

    // Determine extension based on target OS (.pyd for Windows, .so otherwise)
    const ext = if (builtin.os.tag == .windows) ".pyd" else ".so";

    // Install the shared library
    const install = b.addInstallArtifact(lib, .{
        .dest_sub_path = "pylegere" ++ ext,
    });
    b.getInstallStep().dependOn(&install.step);
}
