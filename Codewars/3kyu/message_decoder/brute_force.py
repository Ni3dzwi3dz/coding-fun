def decode(s):
    alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,? "
    result = ""

    for i, char in enumerate(s):
        if char not in alphabet:
            result += char
            continue
            
        for tested in alphabet:
            if encode(i*'_' + tested)[i] == char:
                result += tested
                print('adding ', tested)
                break
                
    return result