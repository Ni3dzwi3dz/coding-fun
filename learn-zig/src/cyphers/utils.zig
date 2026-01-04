pub fn isLetter(c: u8) bool {
    return (c >= 'A' and c <= 'Z') or (c >= 'a' and c <= 'z');
}

pub fn shiftChar(char: u8, shift: u8, base: u8) u8 {
    return base + ((char - base + shift) % 26);
}
