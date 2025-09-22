import 'package:equatable/equatable.dart';

class CartItem {
  final String id;
  final String productId;
  final String name;
  final String weight;
  final String price;
  final String originalPrice;
  final String? discount;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.weight,
    required this.price,
    required this.originalPrice,
    this.discount,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? weight,
    String? price,
    String? originalPrice,
    String? discount,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
    );
  }

  double get numericPrice => double.parse(price.replaceAll('₹', ''));
  double get totalPrice => numericPrice * quantity;
}

class CartState extends Equatable {
  final List<CartItem> items;
  final bool isVisible;
  final int selectedSectionIndex;
  final Map<String, List<bool>> selectedOptions;
  final Map<String, String> selectedVariants; // New field for selected variants

  const CartState({
    this.items = const [],
    this.isVisible = false,
    this.selectedSectionIndex = 0,
    this.selectedOptions = const {},
    this.selectedVariants = const {}, // Initialize selected variants
  });

  CartState copyWith({
    List<CartItem>? items,
    bool? isVisible,
    int? selectedSectionIndex,
    Map<String, List<bool>>? selectedOptions,
    Map<String, String>? selectedVariants,
  }) {
    return CartState(
      items: items ?? this.items,
      isVisible: isVisible ?? this.isVisible,
      selectedSectionIndex: selectedSectionIndex ?? this.selectedSectionIndex,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      selectedVariants: selectedVariants ?? this.selectedVariants,
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool isItemInCart(String itemId) {
    return items.any((item) => item.id == itemId);
  }

  CartItem? getItem(String itemId) {
    try {
      return items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  bool hasActiveFilters() {
    return selectedOptions.values.any((options) => options.any((selected) => selected));
  }

  List<String> getSelectedOptionsForSection(String sectionTitle) {
    final options = selectedOptions[sectionTitle];
    if (options == null) return [];
    
    List<String> selected = [];
    for (int i = 0; i < options.length; i++) {
      if (options[i]) {
        selected.add('Option $i');
      }
    }
    return selected;
  }

  // Helper method to get selected variant for a product
  String? getSelectedVariant(String productId) {
    return selectedVariants[productId];
  }

  @override
  List<Object> get props => [items, isVisible, selectedSectionIndex, selectedOptions, selectedVariants];
}