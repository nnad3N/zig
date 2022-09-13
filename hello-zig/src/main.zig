const std = @import("std");

fn read_int(message: []const u8) !u64 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("{s}", .{message});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        return std.fmt.parseInt(u64, input, 10);
    } else {
        return @as(u64, 0);
    }
}

pub fn main() !void {
    const limit = try read_int("How many of prime numbers do you need: ");
    var i: u64 = 2;
    while (i <= limit ) : (i += 1) {
        var j: u64 = 2;
            while (j <= i/2) : (j += 1) {
                if (i % j == 0) {
                break;
                } else {
                    std.log.info("{d}", .{i});
                    break;
                }
            }
    }
}