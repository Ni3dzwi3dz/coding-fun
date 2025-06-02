class VigenereCipher(object):
    
    def __init__(self, key, alphabet):
        self.key = key
        self.alphabet = alphabet
    
    def encode(self, text: str) -> str:
        return self.code(text, encode=True)
       
    def decode(self, text: str) -> str:
        return self.code(text, encode=False)

    def code(self, text: str, encode=True) -> str:
        result = []
        for i, char in enumerate(text):
            if char in self.alphabet:
                shift = self.alphabet.index(self.key[self._get_position_in_key(i)])
                if encode:
                    new_index = (self.alphabet.index(char) + shift) % len(self.alphabet)
                else:
                    new_index = (self.alphabet.index(char) - shift) % len(self.alphabet)
                result.append(self.alphabet[new_index])
            else:
                result.append(char)
        return ''.join(result)
    
    def _get_position_in_key(self, index: int) -> int:
        return index % len(self.key)




if __name__ == "__main__":
    abc = "abcdefghijklmnopqrstuvwxyz"
    key = "password"
    c = VigenereCipher(key, abc)

    test_cases =  [
        ('codewars','rovwsoiv'),
        ('waffles', 'laxxhsj'),
        ('CODEWARS', 'CODEWARS')
    ]

    for plain, expected in test_cases:
        encoded = c.encode(plain)
        print(f"Encoded: {encoded}, Expected: {expected}")
        assert encoded == expected, f"Failed for {plain}: {encoded} != {expected}"

    for plain, expected in test_cases:
        decoded = c.decode(expected)
        print(f"Decoded: {decoded}, Expected: {plain}")
        assert decoded == plain, f"Failed for {expected}: {decoded} != {plain}"