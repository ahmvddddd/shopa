import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../nav_menu.dart';
import '../../utils/constants/colors.dart';
import '../auth/userId_controller.dart';
import 'clear_cart_controller.dart';

final processOrderProvider = Provider((ref) => ProcessOrderController(ref));

class ProcessOrderController {
  final Ref ref;

  ProcessOrderController(this.ref);

  Future<void> processOrder( BuildContext context, List<dynamic> products) async {
    try {
      final String processOrderUrl = dotenv.env['PROCESS_ORDERS'] ?? 'https://defaulturl.com/api';
    final userIdService = UserIdService();
    final String userId = await userIdService.getCurrentUserId() ?? '';
      
      final response = await http.post(
        Uri.parse(processOrderUrl),
        body: json.encode({
          "userId": userId,
          "products": products,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        ref.read(clearCartProvider).clearCart(context);
        CustomSnackbar.show(
        context: context,
        title: '',
        message: 'Your order is been shipped out',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => NavigationMenu()
          ),
        );
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not place order. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not place order. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}


 