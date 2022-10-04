const std = @import("std");



pub fn cin(comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const delimiter = if(@import("builtin").os.tag == .windows) '\r' else '\n';

    const line: [] u8 = try stdin.readUntilDelimiterAlloc(allocator, delimiter, 512);
    defer allocator.free(line);

    // const info = @typeInfo(T);

    // return switch(info){
    //     .Int => std.fmt.parseInt(T, line, 10),
    //     .Float => std.fmt.parseFloat(T, line),
    //     .Pointer => line,
    //     else => unreachable,
    // };

    std.log.info("{s}", .{line});

    return line;

    // return "10";

    // if (line) |input| {
    //     return std.fmt.parseInt(T, input, 10);
    // } else {
    //     return @as(T, 0);
    // }

}

pub fn main() anyerror!void {
    std.log.info("{s}", .{try cin([]const u8)});
}

// test "basic test" {
//     try std.testing.expectEqual(10, 3 + 7);
// }
