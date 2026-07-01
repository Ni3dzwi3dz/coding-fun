const std = @import("std");
const utils = @import("utils.zig");

pub fn vignereCypher(alloc: std.mem.Allocator, message: []const u8, key: []const u8, encrypt: bool) ![]u8 {
    var output = try alloc.alloc(u8, message.len);

    for (message, 0..message.len) |char, idx| {
        if (utils.isLetter(char)) {
            output[idx] = switch (char) {
                'A'...'Z' => utils.shiftChar(char, calculateShift(encrypt, key, idx), 'A'),
                'a'...'z' => utils.shiftChar(char, calculateShift(encrypt, key, idx), 'a'),
                else => char,
            };
        } else {
            output[idx] = char;
        }
    }
    return output;
}

fn calculateShift(encrypt: bool, key: []const u8, index: usize) u8 {
    const keyChar = key[index % key.len];
    const shift = switch (keyChar) {
        'A'...'Z' => keyChar - 'A',
        'a'...'z' => keyChar - 'a',
        else => 0,
    };

    return if (encrypt) shift else 26 - shift;
}

test "Encrypt and decrypt with Vigenère cipher" {
    const allocator = std.testing.allocator;
    const plaintext = "All your base are belong to us!";
    const key = "Lemon";

    const encrypted = try vignereCypher(allocator, plaintext, key, true);
    defer allocator.free(encrypted);
    try std.testing.expectEqualStrings("Lpx lzyd olwq nci prwszu es if!", encrypted);

    const decrypted = try vignereCypher(allocator, encrypted, key, false);
    defer allocator.free(decrypted);
    try std.testing.expectEqualStrings(plaintext, decrypted);
}
