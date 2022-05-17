import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

const secetPassAES = "123xxczxcxxzzMCbsJs4LRzjBHUFM";
String encryptAESCryptoJS(String plainText) {
  try {
    var listint = new List<int>();
    listint.add(1);
    listint.add(5);
    listint.add(4);
    listint.add(2);
    listint.add(3);
    listint.add(2);
    listint.add(1);
    listint.add(5);
    final salt = Uint8List.fromList(listint);
    var keyndIV = deriveKeyAndIV(secetPassAES, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64.encode(encrypted.bytes);
  } catch (error) {
    throw error;
  }
}

String decryptAESCryptoJS(String encrypted) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    var listint = new List<int>();
    listint.add(1);
    listint.add(5);
    listint.add(4);
    listint.add(2);
    listint.add(3);
    listint.add(2);
    listint.add(1);
    listint.add(5);
    final salt = Uint8List.fromList(listint);
    var keyndIV = deriveKeyAndIV(secetPassAES, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt64(base64.encode(encryptedBytesWithSalt), iv: iv);
    return decrypted;
  } catch (error) {
    throw error;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(currentHash + password + salt);
    else
      preHash = Uint8List.fromList(password + salt);

    var a = preHash.toList();
    currentHash = md5.convert(preHash).bytes;

    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBtyes = concatenatedHashes.sublist(0, 32);
  var ivBtyes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}
