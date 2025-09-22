import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> stores;
  final bool isLoadingMore;
  final bool hasMoreData;

  const StoreLoaded({
    required this.stores,
    this.isLoadingMore = false,
    this.hasMoreData = true,
  });

  @override
  List<Object?> get props => [stores, isLoadingMore, hasMoreData];

  StoreLoaded copyWith({
    List<StoreModel>? stores,
    bool? isLoadingMore,
    bool? hasMoreData,
  }) {
    return StoreLoaded(
      stores: stores ?? this.stores,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}

class StoreCubit extends Cubit<StoreState> {
  final String? categoryId;
  static const int _pageSize = 10;
  int _currentPage = 0;

  StoreCubit({this.categoryId}) : super(StoreInitial());

  Future<void> loadStores() async {
    emit(StoreLoading());
    _currentPage = 0;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      final stores = _getDummyStores();
      emit(StoreLoaded(
        stores: stores,
        hasMoreData: stores.length == _pageSize,
      ));
    } catch (e) {
      emit(StoreError('Failed to load stores: ${e.toString()}'));
    }
  }

  Future<void> loadMoreStores() async {
    final currentState = state;
    if (currentState is! StoreLoaded || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentPage++;
      final newStores = _getDummyStores(startIndex: currentState.stores.length);

      emit(currentState.copyWith(
        stores: [...currentState.stores, ...newStores],
        isLoadingMore: false,
        hasMoreData: newStores.length == _pageSize,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refreshStores() async {
    _currentPage = 0;
    await loadStores();
  }

  List<StoreModel> _getDummyStores({int startIndex = 0}) {
    return List.generate(_pageSize, (index) {
      final realIndex = startIndex + index;
      final categories = [
        'Fashion',
        'Bakery',
        'Electronics',
        'Grocery',
        'Beauty'
      ];
      final category = categories[realIndex % categories.length];

      return StoreModel(
        storeId: 'store_${realIndex + 1}',
        name: 'Store name ${realIndex + 1}',
        category: category,
        imageUrl: _getStoreImage(category),
        rating: 4.5,
        deliveryTime: '10-15 mins',
        distance: '5 Kms',
        freeDelivery: realIndex % 2 == 0,
        isOpen: true,
      );
    });
  }

  String _getStoreImage(String category) {
    switch (category.toLowerCase()) {
      case 'fashion':
        return 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=400&h=200&fit=crop';
      case 'bakery':
        return 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&h=200&fit=crop';
      case 'electronics':
        return 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400&h=200&fit=crop';
      case 'grocery':
        return 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=200&fit=crop';
      default:
        return 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=200&fit=crop';
    }
  }
}

class StoreModel {
  final String storeId;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final String distance;
  final bool freeDelivery;
  final bool isOpen;

  const StoreModel({
    required this.storeId,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    this.freeDelivery = false,
    this.isOpen = true,
  });
}
