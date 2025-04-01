class CheckoutModel {
  final double totalAmount;
  final List<dynamic> cartItems;
  final bool isLoading;
CheckoutModel({
    required this.totalAmount,
    required this.cartItems,
    required this.isLoading,
  });

  CheckoutModel copyWith({
    double? totalAmount,
    List<dynamic>? cartItems,
    bool? isLoading
  }) {
    return CheckoutModel(
      totalAmount: totalAmount ?? this.totalAmount,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}