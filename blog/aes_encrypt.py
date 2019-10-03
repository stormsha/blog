import base64
from Crypto.Cipher import AES

# 此处16|24|32个字符
AES_SECRET_KEY = 'McQfTjWnZr4u7w!z%C*F-JaNdRgUkXp2'
IV = 'ThWmZq4t7w!z%C&F'


# def _encrypt(key, mode, iv, message):
#     _pad = message + (len(key) - len(message) % len(key)) * chr(len(key) - len(message) % len(key))
#     cryptor = AES.new(key, mode, iv)
#     ciphertext = cryptor.encrypt(_pad)
#     return base64.b64encode(ciphertext)


class AesEncrypt(object):

    def __init__(self):
        self.key = AES_SECRET_KEY
        self.mode = AES.MODE_CBC

    # 加密函数
    def encrypt(self, message):
        cryptor = AES.new(self.key, self.mode, IV)
        ciphertext = cryptor.encrypt(self._pad(message))
        # AES加密时候得到的字符串不一定是ascii字符集的，输出到终端或者保存时候可能存在问题，使用base64编码
        return base64.b64encode(ciphertext)

    # 解密函数
    def decrypt(self, message):
        decode = base64.b64decode(message)
        cryptor = AES.new(self.key, self.mode, IV)
        plain_text = cryptor.decrypt(decode)
        return self._unpad(plain_text.decode('utf-8'))

    def _pad(self, s):
        return s + (len(self.key) - len(s) % len(self.key)) * chr(len(self.key) - len(s) % len(self.key))

    def _unpad(self, s):
        return s[0:-ord(s[-1])]


ae = AesEncrypt()

# if __name__ == '__main__':
#     aes_encrypt = AesEncrypt()
#     msg = '123'
#
#     e = aes_encrypt.encrypt(msg)
#     d = aes_encrypt.decrypt(e)
#     assert msg != e
#     print('Original Text:', msg)
#     print('Encrypt Text:', e)
#     print('Decrypt Text:', d)
