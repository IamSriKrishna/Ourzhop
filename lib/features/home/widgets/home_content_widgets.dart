import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:flutter/material.dart';

class HomeContentWidgets {
  HomeContentWidgets._();

  static Widget searchAndLocation() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xFF8B5CF6),
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
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for "store name"',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  'Current Location',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chennai, India',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Transform.rotate(
                      angle: 1.5708,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
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

  static Widget appBar() {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 0.5, 1.0],
            colors: [
              Color(0xFF8B5CF6),
              Color(0xFF8B5CF6),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeContentSubwidget.buildStickyCategory(
                      'All', Icons.apps, false),
                  HomeContentSubwidget.buildStickyCategory(
                      'Grocery', Icons.shopping_cart, true),
                  HomeContentSubwidget.buildStickyCategory(
                      'Electronics', Icons.headphones, false),
                  HomeContentSubwidget.buildStickyCategory(
                      'Bakery', Icons.cake, false),
                  HomeContentSubwidget.buildStickyCategory(
                      'Medicine', Icons.medical_services, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget content() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.grey.withOpacity(0.05),
        child: Column(
          children: [
            HomeContentSubwidget.homeCarousel(),
            HomeContentSubwidget.tabContent(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            HomeContentSubwidget.recommendedWidgets(),
            const SizedBox(height: 20),
            ...List.generate(
                5, (index) => HomeContentSubwidget.buildStoreCard()),
          ],
        ),
      ),
    );
  }
}
