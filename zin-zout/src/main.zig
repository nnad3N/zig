const std = @import("std");



pub fn cin(comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const delimiter = if (@import("builtin").os.tag == .windows) '\r' else '\n';

    const line = try stdin.readUntilDelimiterAlloc(allocator, delimiter, 512);

    defer {
        allocator.free(line);
        const leaked = gpa.deinit();
        if (leaked) @panic("GPA leak");
    }

    return switch(@typeInfo(T)){
        .Int => try std.fmt.parseInt(T, line, 10),
        .Float => try std.fmt.parseFloat(T, line),    
        else => unreachable,
    };
}

pub fn main() anyerror!void {
    const out = try cin(u32);

    std.log.info("{d}", .{out});
}

// test "basic test" {
//     try std.testing.expectEqual(10, 3 + 7);
// }
