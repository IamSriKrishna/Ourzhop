import 'dart:async';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/features/home/widgets/search_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/service_locator.dart';

class SearchScreen extends StatefulWidget {
  final bool isHome;
  const SearchScreen({super.key, required this.isHome});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ShopBloc _shopBloc;
  Timer? _debounceTimer;
  final TextEditingController _searchController = TextEditingController();
  
  static const double _defaultLat = 12.853699836797558;
  static const double _defaultLng = 80.06829697271316;

  @override
  void initState() {
    super.initState();
    _shopBloc = serviceLocator<ShopBloc>();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _shopBloc.close();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    
    if (query.trim().isEmpty) {
      _shopBloc.add(ClearSearchEvent());
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _shopBloc.add(SearchAutocompleteEvent(
        query: query.trim(),
        lat: _defaultLat,
        lng: _defaultLng,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider.value(
      value: _shopBloc,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Column(
          children: [
            SearchScreenWidgets.searchHeader(
              context, 
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            BlocBuilder<ShopBloc, ShopState>(
              builder: (context, state) {
                return SearchScreenWidgets.searchResults(
                  context, 
                  widget.isHome,
                  state,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}