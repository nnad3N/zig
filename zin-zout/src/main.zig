const std = @import("std");



pub fn cin(comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const delimiter = if(@import("builtin").os.tag == .windows) '\r' else '\n';

    const line: [] u8 = try stdin.readUntilDelimiterAlloc(allocator, delimiter, 512);
    defer allocator.free(line);

    const info = @typeInfo(T);

    // std.log.info("{any}", .{info});

    return switch(info){
        .Int => try std.fmt.parseInt(T, line, 10),
        .Float => try std.fmt.parseFloat(T, line),
        .Pointer => try std.fmt.allocPrint(allocator, "{s}", .{line}),
        else => unreachable,
    };
}

pub fn main() anyerror!void {
    const out = try cin([]i32);
    const out2 = try cin([]const u8);

    std.log.info("one: {s} \n two: {s}", .{out, out2});
}

// test "basic test" {
//     try std.testing.expectEqual(10, 3 + 7);
// }
