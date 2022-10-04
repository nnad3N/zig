const std = @import("std");

fn read_int(message: []const u8, comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("{s}", .{message});
    try stdout.print("{s}", .{T == u64});


    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        return std.fmt.parseInt(T, input, 10);
    } else {
        return @as(T, 0);
    }
}

fn cin(n: u8, comptime T: type) !T {
    const stdin = std.io.getStdIn().reader();
    const allocator = std.heap.page_allocator;

    const line = (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', n)) orelse "";
    defer allocator.free(line);

    return std.fmt.parseInt(T, line, 10);

    // if (line) |input| {
    //     return std.fmt.parseInt(T, input, 10);
    // } else {
    //     return @as(T, 0);
    // }

}

pub fn main() !void {
    // const limit = try read_int("How many of prime numbers do you need: ", u64);
    // var i: u64 = 2;
    // while (i <= limit ) : (i += 1) {
    //     var j: u64 = 2;
    //         while (j <= i/2) : (j += 1) {
    //             if (i % j == 0) {
    //             break;
    //             } else {
    //                 std.log.info("{d}", .{i});
    //                 break;
    //             }
    //         }
    // }
    std.log.info("{any}", .{try cin(10, u64)});
}