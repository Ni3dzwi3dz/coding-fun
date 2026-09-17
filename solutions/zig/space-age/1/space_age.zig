const std = @import("std");

pub const seconds_per_earth_year: f64 = 31_557_600.0;

pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn orbitalPeriod(self: Planet) f64 {
        return switch (self) {
            .mercury => 0.2408467,
            .venus => 0.61519726,
            .earth => 1.0,
            .mars => 1.8808158,
            .jupiter => 11.862615,
            .saturn => 29.447498,
            .uranus => 84.016846,
            .neptune => 164.79132,
        };
    }

    pub fn age(self: Planet, seconds: u64) f64 {
        const s: f64 = @floatFromInt(seconds);
        return s / (seconds_per_earth_year * self.orbitalPeriod());
    }
};