const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    randomNumberExample();
    randomBytesExample();
    shuffleExample();
}

pub fn randomNumberExample() void {
    const seed: u64 = 0x42;
    var fast_rng: std.rand.DefaultPrng = std.rand.DefaultPrng.init(seed);
    var cryptographically_secure_rng: std.rand.DefaultCsprng = std.rand.DefaultCsprng.init(seed);

    // *Biased functions have a deterministic runtime bound (they are constant-time), but the result may be biased
    // Otherwise they are unbiased, but the runtime is exponentially distributed (pseudo-rng) or unbounded (true fast_rng)
    const random_boolean: bool = fast_rng.random.boolean();
    const random_boolean_cryptographically_secure: bool = cryptographically_secure_rng.random.boolean();
    const random_uint: u64 = fast_rng.random.int(u64);
    const random_sint: i64 = fast_rng.random.int(i64);
    const random_biased_uint_less_than: u64 = fast_rng.random.uintLessThanBiased(u64, 100);
    const random_unbiased_uint_less_than: u64 = fast_rng.random.uintLessThan(u64, 100);
    const random_biased_uint_at_most: u64 = fast_rng.random.uintAtMostBiased(u64, 100);
    const random_unbiased_uint_at_most: u64 = fast_rng.random.uintAtMost(u64, 100);
    const random_biased_int_in_range_less_than: i64 = fast_rng.random.intRangeLessThanBiased(i64, -100, 100);
    const random_unbiased_int_in_range_less_than: i64 = fast_rng.random.intRangeLessThan(i64, -100, 100);
    const random_biased_int_in_range_at_most: i64 = fast_rng.random.intRangeAtMostBiased(i64, -100, 100);
    const random_unbiased_int_in_range_at_most: i64 = fast_rng.random.intRangeAtMost(i64, -100, 100);
    const random_float_uniform: f32 = fast_rng.random.float(f32);
    const random_float_normal: f32 = fast_rng.random.floatNorm(f32);
    const random_float_exp: f32 = fast_rng.random.floatExp(f32);

    warn("\nExample of using random number generation.\n");
    warn("Random boolean: {}\n", random_boolean);
    warn("Random boolean from cryptographically secure PRNG: {}\n", random_boolean_cryptographically_secure);
    warn("Random unsigned integer: {}\n", random_uint);
    warn("Random signed integer: {}\n", random_sint);
    warn("Random unsigned integer, biased: 0 <= {} < 100\n", random_biased_uint_less_than);
    warn("Random unsigned integer, unbiased: 0 <= {} < 100\n", random_unbiased_uint_less_than);
    warn("Random unsigned integer, biased: 0 <= {} <= 100\n", random_biased_uint_at_most);
    warn("Random unsigned integer, unbiased: 0 <= {} <= 100\n", random_unbiased_uint_at_most);
    warn("Random signed integer, biased: -100 <= {} < 100\n", random_biased_int_in_range_less_than);
    warn("Random signed integer, unbiased: -100 <= {} < 100\n", random_unbiased_int_in_range_less_than);
    warn("Random signed integer, biased: -100 <= {} <= 100\n", random_biased_int_in_range_at_most);
    warn("Random signed integer, unbiased: -100 <= {} <= 100\n", random_unbiased_int_in_range_at_most);
    warn("Random float with uniform distribution: 0 <= {d:.4} < 1\n", random_float_uniform);
    warn("Random float with normal distribution (mu=0, sigma=1): {d:.4}\n", random_float_normal);
    warn("Random float with exponential distribution (lambda=1): {d:.4}\n", random_float_exp);
}

pub fn randomBytesExample() void {
    const seed = std.time.timestamp();
    var fast_rng: std.rand.DefaultPrng = std.rand.DefaultPrng.init(seed);
    var cryptographically_secure_rng: std.rand.DefaultCsprng = std.rand.DefaultCsprng.init(seed);

    var insecure_token: [16]u8 = undefined;
    var secure_token: [16]u8 = undefined;

    fast_rng.random.bytes(insecure_token[0..]);
    cryptographically_secure_rng.random.bytes(secure_token[0..]);

    warn("\nExample of filling a buffer with random bytes.\n");
    warn("128-bit token from fast RNG:                     0x{x}\n", @bitCast(u128, insecure_token));
    warn("128-bit token from cryptographically secure RNG: 0x{x}\n", @bitCast(u128, secure_token));
}

pub fn shuffleExample() void {
    const seed = 0x32;
    var fast_rng: std.rand.DefaultPrng = std.rand.DefaultPrng.init(seed);
    var buffer = [_]u8{ 'A', 'B', 'C', 'D', 'E' };

    warn("\nExample of shuffling a buffer.\n");
    warn("Before shuffle: {}\n", buffer);
    fast_rng.random.shuffle(u8, buffer[0..]);
    warn("After shuffle:  {}\n", buffer);
}
