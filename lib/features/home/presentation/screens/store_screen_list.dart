import 'package:customer_app/features/home/presentation/cubit/store_list_cubit.dart';
import 'package:customer_app/features/home/widgets/store_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreenList extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;

  const StoreScreenList({
    super.key,
    this.categoryId,
    this.categoryName,
  });

  @override
  State<StoreScreenList> createState() => _StoreScreenListState();
}

class _StoreScreenListState extends State<StoreScreenList> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => StoreCubit(categoryId: widget.categoryId)..loadStores(),
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        body: Column(
          children: [
            StoreAppBar(
              context: context,
              searchController: _searchController,
              categoryName: widget.categoryName,
            ),
            Expanded(
              child: StoreList(
                scrollController: _scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}