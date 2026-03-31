const pyoz = @import("PyOZ");

// ============================================================================
// Define your functions here
// ============================================================================

/// Add two integers
fn add(a: i64, b: i64) i64 {
    return a + b;
}

/// Multiply two floats
fn multiply(a: f64, b: f64) f64 {
    return a * b;
}

/// Greet someone by name
fn greet(name: []const u8) ![]const u8 {
    _ = name;
    return "Hello from pylegere!";
}

// ============================================================================
// Module definition
// ============================================================================

pub const Module = pyoz.module(.{
    .name = "pylegere",
    .doc = "pylegere - A Python extension module built with PyOZ",
    .funcs = &.{
        pyoz.func("add", add, "Add two integers"),
        pyoz.func("multiply", multiply, "Multiply two floats"),
        pyoz.func("greet", greet, "Return a greeting"),
    },
    .classes = &.{},
});

// Required: forces analysis of all pub decls so PyInit_ is exported.
comptime {
    for (@typeInfo(@This()).@"struct".decls) |decl| {
        _ = @field(@This(), decl.name);
    }
}
