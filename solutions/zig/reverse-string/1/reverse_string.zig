const std = @import("std");

/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    const result = buffer[0..s.len];
    for (s, 0..) |_, i| {
        result[s.len - 1 - i] = s[i];
    }
    return result;
}