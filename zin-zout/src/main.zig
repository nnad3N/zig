const std = @import("std");

pub fn zin(allocator: std.mem.Allocator, comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();

    const delimiter = if (@import("builtin").os.tag == .windows) '\r' else '\n';

    const line = try stdin.readUntilDelimiterAlloc(allocator, delimiter, 512);

    return switch(@typeInfo(T)){
        .Int => try std.fmt.parseInt(T, line, 10),
        .Float => try std.fmt.parseFloat(T, line),    
        .Pointer => line,
        else => unreachable,
    };
}

pub fn zout(comptime format: []const u8, args: anytype) !void {
    const stdout = std.io.getStdOut();

    try stdout.writer().print(format, args);
}

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const output = try zin(allocator, []const u8);
    try zout("{s}", .{output});

    defer {
        allocator.free(output);
        const leaked = gpa.deinit();
        if (leaked) @panic("GPA leak");
    }
}