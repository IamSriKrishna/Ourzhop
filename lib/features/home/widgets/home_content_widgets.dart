// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeContentWidgets {
  HomeContentWidgets._();
  static Widget searchAndLocation(String location, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.primary,
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onTap: () {
                        context.goNamed(AppRoutes.searchScreen);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for "store name"',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(
                    color: colorScheme.onPrimary.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        location.toCapital,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Transform.rotate(
                      angle: 1.5708,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: colorScheme.onPrimary,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget appBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 0.5, 1.0],
            colors: [
              colorScheme.primary,
              colorScheme.primary,
              colorScheme.surface,
              colorScheme.surface,
            ],
          ),
        ),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: List.generate(
                            16,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: HomeContentSubwidget
                                      .buildStickyCategoryShimmer(context),
                                )),
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is CategoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: colorScheme.error),
                ),
              );
            }
            if (state is CategoryLoaded) {
              return Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: state.categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: HomeContentSubwidget.buildStickyCategory(
                              category.name,
                              category.iconUrl,
                              false,
                              context,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  static Widget content(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        child: Column(
          children: [
            const SizedBox(height: 30),
            HomeContentSubwidget.homeCarousel(context),
            HomeContentSubwidget.tabContent(context),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            HomeContentSubwidget.recommendedWidgets(context),
            const SizedBox(height: 20),
            ...List.generate(
                5, (index) => HomeContentSubwidget.buildStoreCard(context)),
          ],
        ),
      ),
    );
  }
}
