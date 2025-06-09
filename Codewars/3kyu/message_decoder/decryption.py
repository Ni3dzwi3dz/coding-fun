def decode(s):
    alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,? '
    result = ''
    
    for i, char in enumerate(s):
        if char in alphabet:
            position = 2 ** (i + 1)
            shift = alphabet.index(char)
            original_index = ((shift + 1) * pow(position,-1,67) -1) % 67
            
            result += alphabet[original_index]
        
        else:
            result += char

    return result