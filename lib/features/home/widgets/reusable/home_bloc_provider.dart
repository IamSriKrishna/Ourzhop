import 'package:customer_app/features/home/presentation/cubit/location_cubit.dart';
import 'package:customer_app/features/home/domain/usecase/category_usecase.dart';
import 'package:customer_app/features/home/domain/usecase/search_usecase.dart';
import 'package:customer_app/features/home/domain/usecase/shop_usecase.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlocProviders extends StatelessWidget {
  final Widget child;

  const HomeBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocationCubit()..getCurrentLocation(),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            getCategories: serviceLocator<GetCategoriesUseCase>(),
          )..add(GetCategoriesEvent(limit: 10, cursor: null)),
        ),
        BlocProvider(
          create: (_) => ShopBloc(
            getShopsByLocation: serviceLocator<GetShopsByLocationUseCase>(),
            getAutocompleteResults: serviceLocator<GetAutocompleteResultsUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}