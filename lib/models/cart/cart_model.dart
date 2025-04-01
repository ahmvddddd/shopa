class CartModel {
  final List<dynamic> cartItems;
  final bool isLoading;
CartModel({
    required this.cartItems,
    required this.isLoading,
  });

  CartModel copyWith({
    List<dynamic>? cartItems,
    bool? isLoading
  }) {
    return CartModel(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
