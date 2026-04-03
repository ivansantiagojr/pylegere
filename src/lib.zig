const pyoz = @import("PyOZ");
const legere = @import("legere");

// ============================================================================
// Define your functions here
// ============================================================================

fn ari(text: []const u8) !f64 {
    const result = try legere.ari(text);
    return result;
}

// ============================================================================
// Module definition
// ============================================================================

pub const Module = pyoz.module(.{
    .name = "pylegere",
    .doc = "pylegere - Python bindings for the Zig implementation of liblegere.",
    .funcs = &.{
        pyoz.func("ari", ari, "Return the Automated Readability Index of an English text."),
    },
    .classes = &.{},
});

// Required: forces analysis of all pub decls so PyInit_ is exported.
comptime {
    for (@typeInfo(@This()).@"struct".decls) |decl| {
        _ = @field(@This(), decl.name);
    }
}
