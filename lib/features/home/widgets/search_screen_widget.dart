// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResult {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final String? subtitle;
  final double? similarityScore;
  final double? distanceKm;

  SearchResult({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    this.subtitle,
    this.similarityScore,
    this.distanceKm,
  });
}

class SearchScreenWidgets {
  SearchScreenWidgets._();

  static Widget searchHeader(
    BuildContext context, {
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.primary,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 8,
        16,
        16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                autofocus: true,
                onChanged: onChanged ?? (value) {
                  debugPrint('Search query: $value');
                },
                decoration: InputDecoration(
                  hintText: 'Search shops, items...',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 20,
                    ),
                  ),
                  suffixIcon: controller != null && controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            controller.clear();
                            onChanged?.call('');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.black54,
                              size: 20,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget searchResults(
    BuildContext context, 
    bool isHome,
    ShopState state,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Container(
        color: colorScheme.surface,
        child: _buildSearchContent(context, isHome, state),
      ),
    );
  }

  static Widget _buildSearchContent(
    BuildContext context,
    bool isHome,
    ShopState state,
  ) {
    if (state is SearchLoading) {
      return _buildLoadingState(context);
    } else if (state is SearchResultsLoaded) {
      if (state.searchResults.isEmpty) {
        return _buildEmptyState(context, 'No results found for "${state.query}"');
      }
      return _buildResultsList(context, isHome, state.searchResults);
    } else if (state is SearchError) {
      return _buildErrorState(context, state.message);
    } else if (state is SearchCleared || state is ShopInitial) {
      return _buildInitialState(context);
    } else {
      return _buildInitialState(context);
    }
  }

  static Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 8, 
      itemBuilder: (context, index) => buildShimmerResultItem(context),
    );
  }

  static Widget _buildResultsList(
    BuildContext context,
    bool isHome,
    List<dynamic> results,
  ) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _buildSearchResultItem(
          SearchResult(
            id: result.id,
            name: result.name,
            type: result.type,
            imageUrl: _getImageForType(result.type),
            subtitle: result.description.isNotEmpty 
                ? result.description 
                : '${result.distanceKm.toStringAsFixed(1)} km away',
            similarityScore: result.similarityScore,
            distanceKm: result.distanceKm,
          ),
          context,
          isHome: isHome,
        );
      },
    );
  }

  static Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or check your spelling',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Search for shops and items',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start typing to see results',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  static String _getImageForType(String type) {
    switch (type.toLowerCase()) {
      case 'shop':
        return '🏪';
      case 'product':
        return '📦';
      case 'food':
        return '🍎';
      case 'restaurant':
        return '🍽️';
      case 'grocery':
        return '🛒';
      default:
        return '🏪';
    }
  }

  static Widget _buildSearchResultItem(
    SearchResult result, 
    BuildContext context, {
    required bool isHome,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () {
        isHome
            ? context.goNamed(
                AppRoutes.storeListScreen,
                extra: {'searchResult': result},
              )
            : context.goNamed(
                AppRoutes.categoryStoreListScreen,
                extra: {'searchResult': result},
              );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  result.imageUrl,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        result.type,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (result.similarityScore != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${(result.similarityScore! * 100).toInt()}% match',
                            style: TextStyle(
                              fontSize: 10,
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (result.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      result.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (result.distanceKm != null)
              Icon(
                Icons.location_on,
                size: 16,
                color: colorScheme.onSurface.withOpacity(0.4),
              ),
          ],
        ),
      ),
    );
  }

  static Widget buildShimmerResultItem(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 14,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}