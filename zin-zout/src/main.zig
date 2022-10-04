const std = @import("std");



pub fn cin(comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const delimiter = if(@import("builtin").os.tag == .windows) '\r' else '\n';

    const line: []const u8 = try stdin.readUntilDelimiterAlloc(allocator, delimiter, 512);
    defer allocator.free(line);

    const info = @TypeOf(T);

    const s = switch(info){
        u32 => std.fmt.parseInt(T, line, 10),
        f32 => std.fmt.parseFloat(T, line),
        []const u8 => line,
        else => unreachable,
    };

    std.log.info("{d}", .{s});

    return s;

    // return "10";

    // if (line) |input| {
    //     return std.fmt.parseInt(T, input, 10);
    // } else {
    //     return @as(T, 0);
    // }

}

pub fn main() anyerror!void {
    // std.log.info("All your codebase are belong to us.", .{});
    std.log.info("{s}", .{try cin(u32)});
}

// test "basic test" {
//     try std.testing.expectEqual(10, 3 + 7);
// }
