// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/home_event.dart';
import 'package:customer_app/features/home/presentation/bloc/home_state.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Categories',
              style: AppFonts.poppins(
                size: 18.0,
                weight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          // Category List
          SizedBox(
            height: 100.0, // Fixed height for horizontal scrolling
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.categoryState != current.categoryState,
              builder: (context, state) {
                final categoryState = state.categoryState;

                if (categoryState is HomeCategoryInitial) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryPurple));
                }

                if (categoryState is HomeCategoryLoading) {
                  // Show existing categories with loading indicator
                  if (categoryState.categories.isEmpty) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryPurple));
                  } else {
                    return _buildCategoryList(
                      context,
                      categoryState.categories,
                      isLoading: true,
                    );
                  }
                }

                if (categoryState is HomeCategorySuccess) {
                  return _buildCategoryList(
                    context,
                    categoryState.categories,
                    hasMore: categoryState.hasMore,
                  );
                }

                if (categoryState is HomeCategoryFailure) {
                  return _buildErrorWidget(context, categoryState.error);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    List<CategoryEntity> categories, {
    bool hasMore = false,
    bool isLoading = false,
  }) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: categories.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == categories.length) {
          // Load more indicator
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(color: AppColors.primaryPurple),
            ),
          );
        }

        final category = categories[index];
        return _buildCategoryItem(context, category);
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryEntity category) {
    return GestureDetector(
      onTap: () => _handleCategoryTap(context, category),
      child: Container(
        width: 80.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            // Category Icon/Image Container
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: AppColors.primaryPurpleLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(
                  color: AppColors.lightGray,
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.category_outlined,
                color: AppColors.primaryPurple,
                size: 24.0,
              ),
            ),

            const SizedBox(height: 8.0),

            // Category Name
            Text(
              category.name,
              style: AppFonts.poppins(
                size: 12.0,
                weight: FontWeight.w500,
                color: AppColors.darkGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.mediumGray,
            size: 32.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Failed to load categories',
            style: AppFonts.poppins(
              size: 14.0,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 4.0),
          TextButton(
            onPressed: () => _handleRetry(context),
            child: Text(
              'Retry',
              style: AppFonts.poppins(
                size: 14.0,
                weight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCategoryTap(BuildContext context, CategoryEntity category) {
    // TODO: Navigate to category detail screen or filter products by category
    debugPrint('Category tapped: ${category.name}');
  }

  void _handleRetry(BuildContext context) {
    context.read<HomeBloc>().add(const HomeCategoryLoadRequested());
  }
}
