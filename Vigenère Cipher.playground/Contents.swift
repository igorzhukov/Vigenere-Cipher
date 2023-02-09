import UIKit

fileprivate extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class Vigenere {
    let alphabet: String
    let alphabetSize: Int
    let key: String
    let keySize: Int

    init(alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", key: String) {
        self.alphabet = alphabet.uppercased()
        self.alphabetSize = alphabet.count
        self.key = key.uppercased()
        self.keySize = key.count
    }
    
    private func indexOfAlphabet(forCharacter character: Character) -> Int? {
        var index = 0

        for chr in alphabet {
            if chr == character {
                return index
            }
            index += 1
        }

        return nil
    }

    func encrypt(plainText: String) -> String {
        var encryptedText = ""
        var index = 0

        // don't use `.enumerated()` as Alphabet doesn't contain numbers and special characters but plainText can
        for character in plainText.uppercased() {
            if let indexInAlphabet = indexOfAlphabet(forCharacter: character) {
                let keyToEncryptWith = key[index % keySize]
                let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
                // `keyIndexInAlphabet` is always not nil if this block is executed
                let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet! + alphabetSize) % alphabetSize
                encryptedText.append(alphabet[encryptedLetterIndex])
                index += 1
            } else {
                encryptedText.append(character)
            }
        }

        return encryptedText
    }

    
    func decrypt(encryptedText: String) -> String {
        var decryptedText = ""
        var index = 0

        // don't use .enumerated() as Alphabet doesn't contain numbers and special characters but plainText can
        
        
        for character in encryptedText.uppercased() {
            if let indexInAlphabet = indexOfAlphabet(forCharacter: character) {
                let keyToEncryptWith = key[index % keySize]
                let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
                // `keyIndexInAlphabet` is always not nil if this block is executed
                let encryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet! + alphabetSize) % alphabetSize
                decryptedText.append(alphabet[encryptedLetterIndex])
                index += 1
            } else {
                decryptedText.append(character)
            }
          
        }

        return decryptedText
    }
     

   
}


let vigenere = Vigenere(key: "CryptoKey")
let plainText = "Here is Vigenere Cipher ciper 1.0 in action!"
print(plainText) // Here is Vigenere Cipher ciper 1.0 in action!
let encrypted = vigenere.encrypt(plainText: plainText)
print(encrypted) // JVPT BG FMEGECGX QSTFGI AXISB 1.0 ML CTRXHB!
let decrypted = vigenere.decrypt(encryptedText: encrypted)
print(decrypted) // HERE IS VIGENERE CIPHER CIPER 1.0 IN ACTION!



