import 'package:customer_app/features/store/presentation/bloc/product_bloc.dart';
import 'package:customer_app/features/store/presentation/bloc/product_event.dart';
import 'package:customer_app/service_locator.dart';

class BlocManager {
  static final Map<String, ProductBloc> _productBlocs = {};

  static ProductBloc getProductBloc(String shopId) {
    if (!_productBlocs.containsKey(shopId)) {
      _productBlocs[shopId] = serviceLocator<ProductBloc>()
        ..add(LoadProductsEvent(shopId: shopId));
    }
    return _productBlocs[shopId]!;
  }

  static void dispose(String shopId) {
    _productBlocs[shopId]?.close();
    _productBlocs.remove(shopId);
  }

  static void disposeAll() {
    _productBlocs.values.forEach((bloc) => bloc.close());
    _productBlocs.clear();
  }
}