const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var unique_multiples = std.AutoHashMap(u32, void).init(allocator);
    defer unique_multiples.deinit();
    
    for (factors) |factor| {
        if (factor == 0) continue;
        var multiple = factor;

        while (multiple < limit) {
            try unique_multiples.put(multiple, {});
            multiple += factor;
        }
    }
    var total_sum: u64 = 0;
    var iterator = unique_multiples.keyIterator();
    while (iterator.next()) |key_ptr| {
        total_sum += key_ptr.*;
    }
    return total_sum;    
}
