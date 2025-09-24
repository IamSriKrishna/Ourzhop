import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void _safeEmit(CartState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Cart methods
  void addItem(CartItem item) {
    final currentItems = List<CartItem>.from(state.items);
    final existingItemIndex = currentItems.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      currentItems[existingItemIndex] = currentItems[existingItemIndex]
          .copyWith(quantity: currentItems[existingItemIndex].quantity + 1);
    } else {
      currentItems.add(item);
    }

    _safeEmit(state.copyWith(
      items: currentItems,
      isVisible: true,
    ));
  }

  void removeItem(String itemId) {
    final currentItems = List<CartItem>.from(state.items);
    final existingItemIndex = currentItems.indexWhere((i) => i.id == itemId);

    if (existingItemIndex != -1) {
      if (currentItems[existingItemIndex].quantity > 1) {
        currentItems[existingItemIndex] = currentItems[existingItemIndex]
            .copyWith(quantity: currentItems[existingItemIndex].quantity - 1);
      } else {
        currentItems.removeAt(existingItemIndex);
      }
    }

    _safeEmit(state.copyWith(
      items: currentItems,
      isVisible: currentItems.isNotEmpty,
    ));
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final currentItems = List<CartItem>.from(state.items);
    final existingItemIndex = currentItems.indexWhere((i) => i.id == itemId);

    if (existingItemIndex != -1) {
      currentItems[existingItemIndex] =
          currentItems[existingItemIndex].copyWith(quantity: quantity);
    }

    _safeEmit(state.copyWith(items: currentItems));
  }

  void clearCart() {
    _safeEmit(const CartState());
  }

  void showCart() {
    _safeEmit(state.copyWith(isVisible: true));
  }

  void hideCart() {
    _safeEmit(state.copyWith(isVisible: false));
  }

  // Selected Variants Management
  void selectVariant(String productId, String variantId) {
    final updatedVariants = Map<String, String>.from(state.selectedVariants);
    updatedVariants[productId] = variantId;
    
    _safeEmit(state.copyWith(selectedVariants: updatedVariants));
  }

  void clearVariantSelection(String productId) {
    final updatedVariants = Map<String, String>.from(state.selectedVariants);
    updatedVariants.remove(productId);
    
    _safeEmit(state.copyWith(selectedVariants: updatedVariants));
  }

  String? getSelectedVariant(String productId) {
    return state.selectedVariants[productId];
  }

  // Filter methods
  void initializeFilters(List<Map<String, dynamic>> filterSections) {
    if (state.selectedOptions.isNotEmpty) {
      return;
    }
    
    Map<String, List<bool>> selectedOptions = {};
    for (var section in filterSections) {
      final sectionTitle = section['title'] as String;
      final options = section['options'] as List<String>;
      selectedOptions[sectionTitle] = List.filled(options.length, false);
    }
    
    _safeEmit(state.copyWith(
      selectedOptions: selectedOptions,
      selectedSectionIndex: 0,
    ));
  }

  void selectSection(int index) {
    if (state.selectedSectionIndex != index) {
      _safeEmit(state.copyWith(selectedSectionIndex: index));
    }
  }

  void toggleOption(String sectionTitle, int optionIndex) {
    final updatedOptions = Map<String, List<bool>>.from(state.selectedOptions);
    
    if (!updatedOptions.containsKey(sectionTitle)) {
      return;
    }
    
    final sectionOptions = updatedOptions[sectionTitle]!;
    if (optionIndex < 0 || optionIndex >= sectionOptions.length) {
      return;
    }
    
    updatedOptions[sectionTitle] = List.from(sectionOptions);
    updatedOptions[sectionTitle]![optionIndex] = !updatedOptions[sectionTitle]![optionIndex];
    
    _safeEmit(state.copyWith(selectedOptions: updatedOptions));
  }

  void resetFilters() {
    if (state.selectedOptions.isEmpty) {
      return;
    }
    
    final resetOptions = <String, List<bool>>{};
    for (var entry in state.selectedOptions.entries) {
      resetOptions[entry.key] = List.filled(entry.value.length, false);
    }
    
    _safeEmit(state.copyWith(
      selectedSectionIndex: 0,
      selectedOptions: resetOptions,
    ));
  }

  void clearFilters() {
    _safeEmit(state.copyWith(
      selectedSectionIndex: 0,
      selectedOptions: {},
    ));
  }

  void applyFilters() {
    // Implementation for applying filters
  }
}