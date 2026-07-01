// Caesar cipher implementation in Zig

const std = @import("std");
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");

pub fn caesarCypher(allocator: Allocator, input: []const u8, shift: i8, encrypt: bool) ![]u8 {
    var output = try allocator.alloc(u8, input.len);
    const offset = calculateOffset(encrypt, shift);
    for (input, 0..input.len) |char, idx| {
        output[idx] = switch (char) {
            'A'...'Z' => utils.shiftChar(char, offset, 'A'),
            'a'...'z' => utils.shiftChar(char, offset, 'a'),
            else => char,
        };   
    }
    return output;
}


fn calculateOffset(encrypt: bool, shift: i8) u8 {
    if (encrypt) {
        return @as(u8, @abs(@rem(@rem(shift, 26) + 26, 26)));
    }
    else {
        return @as(u8, @abs(@rem(@rem(-shift, 26) + 26, 26)));
    }
}

test "Encrypt and decrypt with Caesar cipher" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = 3;

    const encrypted = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings("Khoor, Zruog!", encrypted);

    const decrypted = try caesarCypher(allocator, encrypted, shift, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);

}

test "Encrypt with positive shift" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = 7;

    const encrypted = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings("Olssv, Dvysk!", encrypted);

    const decrypted = try caesarCypher(allocator, encrypted, shift, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);
}

test "Encrypt with negative shift" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = -5;

    const encrypted = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings("Czggj, Rjmgy!", encrypted);

    const decrypted = try caesarCypher(allocator, encrypted, shift, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);
}

test "Encrypt with a zero shift" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = 0;

    const encrypted = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings(plaintext, encrypted);

    const decrypted = try caesarCypher(allocator, encrypted, shift, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);
}

test "Encrypt with a full rotation shift" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = 26;

    const encrypted = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings(plaintext, encrypted);

    const decrypted = try caesarCypher(allocator, encrypted, shift, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);
}

test "Encrypt with a large shift" {
    const allocator = std.testing.allocator;
    const plaintext = "Hello, World!";
    const shift: i8 = 29; // Equivalent to a shift of 3

    const encrypted29 = try caesarCypher(allocator, plaintext, shift, true);
    defer allocator.free(encrypted29);
    try std.testing.expectEqualStrings("Khoor, Zruog!", encrypted29);

    const encrypted3 = try caesarCypher(allocator, plaintext, 3, true);
    defer allocator.free(encrypted3);
    try std.testing.expectEqualStrings(encrypted29, encrypted3);

}   