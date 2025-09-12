import 'package:customer_app/features/home/widgets/store_list_widgets.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreStores();
    }
  }

  void _loadMoreStores() {
    print('Loading more stores...');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
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
              context: context,
              scrollController: _scrollController,
              categoryId: widget.categoryId,
            ),
          ),
        ],
      ),
    );
  }
}
