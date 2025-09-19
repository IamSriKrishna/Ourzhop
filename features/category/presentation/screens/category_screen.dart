// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_extensions.dart';
import 'package:customer_app/common/widget/app_primary_action_button.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:customer_app/features/category/presentation/bloc/category_event.dart';
import 'package:customer_app/features/category/presentation/bloc/category_state.dart';
import 'package:customer_app/features/category/presentation/widgets/category_widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Trigger initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CategoryBloc>().add(const CategoriesRequested());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listenWhen: (previous, current) =>
          current is CategoriesFailure && previous is! CategoriesFailure,
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType ||
          (current is CategoriesSuccess &&
              previous is CategoriesSuccess &&
              current.categories.length != previous.categories.length),
      listener: _handleCategoryStateChange,
      builder: (context, state) => _buildMainScaffold(context, state),
    );
  }

  Widget _buildMainScaffold(BuildContext context, CategoryState state) {
    final appColors = context.appColors;

    return Container(
      decoration: BoxDecoration(gradient: appColors.backgroundGradient),
      child: SafeArea(
        child: _buildScrollableContent(context, state),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context, CategoryState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        _buildHeaderSection(context),

        // Main Content
        Expanded(
          child: _buildMainContent(context, state),
        ),
      ],
    );
  }

  /// Builds the header section with title - Figma design
  Widget _buildHeaderSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appColors = context.appColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
      child: Text(
        l10n.categoriesPageTitle,
        style: AppFonts.poppins(
          size: 16.0, // Figma: fontSize: 16
          weight: FontWeight.w600, // Figma: fontWeight: 600
          color: appColors.onBackground,
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, CategoryState state) {
    return switch (state) {
      CategoriesInitial() => _buildLoadingState(context),
      CategoriesLoading() => state.categories.isEmpty
          ? _buildLoadingState(context)
          : _buildSuccessState(context, state.categories, true),
      CategoriesSuccess() =>
        _buildSuccessState(context, state.categories, state.hasMore),
      CategoriesFailure() => _buildFailureState(context, state.error),
      _ => _buildLoadingState(context),
    };
  }

  Widget _buildLoadingState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLoadingStates.loadingIndicator(context),
          const SizedBox(height: 16.0),
          Text(
            l10n.categoriesLoadingMessage,
            style: AppFonts.poppins(
              size: 16.0,
              color: context.appColors.onBackground.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureState(BuildContext context, String error) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.0,
              color: context.appColors.error,
            ),
            const SizedBox(height: 16.0),
            Text(
              error.isNotEmpty ? error : l10n.categoriesLoadError,
              textAlign: TextAlign.center,
              style: AppFonts.poppins(
                size: 16.0,
                color: context.appColors.onBackground,
              ),
            ),
            const SizedBox(height: 24.0),
            AppPrimaryActionButton(
              text: l10n.categoriesRetryButton,
              onPressed: () => _handleRetryPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(
      BuildContext context, List<CategoryEntity> categories, bool hasMore) {
    final l10n = AppLocalizations.of(context)!;

    if (categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category_outlined,
                size: 64.0,
                color: context.appColors.onBackground.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16.0),
              Text(
                l10n.categoriesNoDataMessage,
                textAlign: TextAlign.center,
                style: AppFonts.poppins(
                  size: 16.0,
                  color: context.appColors.onBackground.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, // Figma spacing
                mainAxisSpacing: 16.0, // Figma spacing
                childAspectRatio: 1.5, // Figma card proportions
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildCategoryItem(context, categories[index]),
                childCount: categories.length,
              ),
            ),
          ),
          if (hasMore) _buildLoadMoreSection(context),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryEntity category) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          false, // Static item, no rebuilds needed
      builder: (context, state) {
        return CategoryWidgets.enhancedCategoryCard(
          context: context,
          name: category.name,
          description: category.description,
          iconUrl: category.iconUrl,
          onTap: () => _handleCategoryTap(context, category),
        );
      },
    );
  }

  Widget _buildLoadMoreSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        buildWhen: (previous, current) =>
            (previous is CategoriesLoading) != (current is CategoriesLoading),
        builder: (context, state) {
          if (state is CategoriesLoading && state.categories.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: AppLoadingStates.loadingIndicator(context)),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _handleCategoryStateChange(BuildContext context, CategoryState state) {
    if (state is CategoriesFailure) {
      // Show error but don't navigate - let the user see the error state
      AppErrorDisplay.showSnackBar(
        context,
        state.error,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _handleRetryPressed(BuildContext context) {
    context.read<CategoryBloc>().add(const CategoriesRequested());
  }

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<CategoryBloc>().add(const CategoriesRefresh());
    // Wait for state change to complete refresh
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _handleCategoryTap(BuildContext context, CategoryEntity category) {
    // TODO: Navigate to category detail or products screen
    debugPrint('Tapped category: ${category.name}');
  }

  void _onScroll() {
    if (_isBottom && context.read<CategoryBloc>().state is CategoriesSuccess) {
      final state = context.read<CategoryBloc>().state as CategoriesSuccess;
      if (state.hasMore) {
        context.read<CategoryBloc>().add(const CategoriesNextPageRequested());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
