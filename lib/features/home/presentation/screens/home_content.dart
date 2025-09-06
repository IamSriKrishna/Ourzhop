import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/features/home/widgets/home_content_widgets.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeContentWidgets.searchAndLocation(),
          HomeContentWidgets.appBar(),
          HomeContentWidgets.content(),
          SliverToBoxAdapter(
            child: Image.asset(AppImages.homeWallpaper),
          )
        ],
      ),
    );
  }
}
