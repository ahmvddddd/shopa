// // ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user/user_model.dart';
import '../../screens/authentication/splash_screen.dart';


const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

final signupControllerProvider =
    StateNotifierProvider<SignupController, SignupState>((ref) {
  return SignupController();
});

class SignupController extends StateNotifier<SignupState> {
  SignupController() : super(SignupState());
  
  final String signupUrl = dotenv.env['SIGNUP_URL'] ?? 'https://defaulturl.com/api';

  Future<void> signup(
      BuildContext context, String firstname, String lastname, String username, String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'firstname': firstname, 'lastname': lastname, 'username': username, 'email': email, 'password': password, 'userType': 'provider'}),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Save the token in secure storage
        await _secureStorage.write(key: 'token', value: responseData['token']);

        // Navigate to the new page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  SplashScreen()),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: jsonDecode(response.body)['message'] ?? 'Signup failed',
        );
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, error: "An error occurred. Please try again.");
    }
  }
}