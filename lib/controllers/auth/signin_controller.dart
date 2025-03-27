// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../nav_menu.dart';
import '../../models/user/user_model.dart';


const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController();
});

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState());

  final String signinUrl = dotenv.env['SIGNIN_URL'] ?? 'https://defaulturl.com/api';

  Future<void> login(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(signinUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final user = User(
          username: responseData['username'],
          password: responseData['password'],
        );

        // Save the token in secure storage
        await _secureStorage.write(key: 'token', value: responseData['token']);
        await _secureStorage.write(key: 'savedUsername', value: username);

        state = state.copyWith(isLoading: false, user: user);

        // Navigate to the new page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  NavigationMenu()),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: jsonDecode(response.body)['message'] ?? 'Login failed',
        );
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, error: "An error occurred. Please try again.");
    }
  }
}
