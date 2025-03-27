// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserIdService {
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> getCurrentUserId() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      if (token != null) {
        final decodedToken = parseJwt(token);
        return decodedToken['id'];
      }
    } catch (e) {
      print('Error getting current user ID: $e');
    }
    return null;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    final payloadMap =
        json.decode(utf8.decode(payload)) as Map<String, dynamic>;
    return payloadMap;
  }
}
