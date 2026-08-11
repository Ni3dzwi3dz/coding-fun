const std = @import("std");

pub fn score(s: []const u8) u32 {
    var result: u32 = 0;
    const scores: []const u5 = &[_]u5{
    1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3,
    1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10,
    };

    for (s) |c| {
        const lower = std.ascii.toLower(c);
        if (lower >= 'a' or lower <= 'z') {
            result += scores[lower - 'a'];
        }
    }
    return result;
}
