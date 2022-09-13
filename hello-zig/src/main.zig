const std = @import("std");

fn read_int(message: []const u8) !i64 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("{s}", .{message});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        return std.fmt.parseInt(i64, input, 10);
    } else {
        return @as(i64, 0);
    }
}

pub fn main() !void {
    const limit = try read_int("How many of prime numbers do you need: ");
    var i: i64 = 2;
    while (i <= limit ) : (i += 1) {
        var j: i64 = 2;
            while (j <= i) : (j += 1) {
                if (@mod(i, j) == 0) {
                break;
                } else {
                    std.log.info("{d}", .{i});
                    break;
                }
            }
    }
}