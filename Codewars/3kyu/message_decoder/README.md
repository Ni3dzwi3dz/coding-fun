**Kata link** [Help the general decode secret enemy messages.](https://www.codewars.com/kata/52cf02cd825aef67070008fa)

**Description**
General Patron is faced with a problem , his intelligence has intercepted some secret messages from the enemy but they are all encrypted. Those messages are crucial to getting the jump on the enemy and winning the war. Luckily intelligence also captured an encoding device as well. However even the smartest programmers weren't able to crack it though. So the general is asking you , his most odd but brilliant programmer.

You can call the encoder like this.
`encode("Hello World!")`
Our cryptoanalysts kept poking at it and found some interesting patterns.
```python
print(
encode("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
print(
encode("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"))
print(encode("!@#$%^&*()_+-"))
a,b,c = "", "", ""
for w in "abcdefghijklmnopqrstuvwxyz":
    a += encode(  "" + w)[0]
    b += encode( "_" + w)[1]
    c += encode("__" + w)[2]
print(a)
print(b)
print(c)
```
We think if you keep on this trail you should be able to crack the code! You are expected to fill in the decode function. Good luck ! General Patron is counting on you!

**Comment**
This seems to be by far the most enjoyable kata i've done on Codewars. It certainly
resonates with my love for riddles and mysteries.

We are given nothing, but a black-box encoding function and some examples - we'll write more  
later, but now let's take a look at the ones provided:
 * First two examples, of strings using repeated letter, show that probably encoding is based not only on an input character, but also it's position in string
 * After encoding, the two strings are shifted by one character (`aaaa` and `bbbb`), as input chars are also shifted by one. So, if `i` is position in coded string, and `c` is the ord of coded character, `f(i,c+1) == f(i+1,c)`
 * However, check for more characters prove this to be wrong - 
 * If we check `ord(coded) - ord(original)`, for first elements we get 1,3,7,15 which is 
  $2^{n+1} -1$
 * There is a group of neutral characters, that don't get encoded `!@#$%^&*()_+-`.
 9First intuition would be, that they fall out of some range, that gets encoded.
However, characters with unicodes 91-96, that are between capital and small letters,
are all excluded
 * Therefore, either the shift somehow omits those numbers, or there are a lot of `if`
 statements in code, or the coding function uses it's own alphabet.
 * **BRUTE FORCE SOLUTION** at this point, we know, that there are two factors that determine
 what the encoded character will be - the character itself, and it's position in string. So, for every character in the coded string, we can check every possible character, try to encode it in correct position, and if we get the character from coded string- this is the encoded char.

 * Solution above works, but is far from elegant, so i dive deeper. First, provided examples
 should be enough to get the characters in the alphabet- there are 66 different chars. They
 are small and capital letters, digits, `.`, `,` , `?` and whitespace..
 * Shift is smallest for small letter and much bigger for the capital ones. So i start 
 with `abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.,? `
 * As position of `a` is 0, it should probably leave the coding algorithm rely only on 
 position in string. So i try coding a long string of `a` with `alphabet[(2 ** (i+1) - 1) % 67]` - it works nice, but some characters are off. Switching the digits part of the alphabet to start with `0` fixes it.
 * Some experimenting with other letters allowed me to work out the coding algorithm:
 ```python
 for i, j in enumerate(66 * 'c'):
     pos = 2 ** (i + 1)
     index = alphabet.index(j) + 1
     shift = (index * pos - 1) % 67
     result += alphabet[shift]
 ```
 * Some mingling with the formula gives us the final algorithm:
 ```python
 for i, char in enumerate(s):
    if char in alphabet:
    position = 2 ** (i + 1)
    shift = alphabet.index(char)
    original_index = ((shift + 1) * pow(position,-1,67) -1) % 67
    
    result += alphabet[original_index]
```

