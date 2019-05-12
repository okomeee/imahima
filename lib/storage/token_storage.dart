import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class TokenStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/token.txt');
  }

  Future<String> readToken() async {
    try {
      final file = await _localFile;
      String token = await file.readAsString();
      return token;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeToken(String t) async {
    String token = t;
    final file = await _localFile;
    return file.writeAsString(token);
  }
}