
import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/home/presentation/cubit/location_cubit.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/features/home/widgets/home_content_widgets.dart';
import 'package:customer_app/features/home/widgets/reusable/home_main_content.dart';
import 'package:customer_app/features/home/widgets/reusable/load_more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScrollView extends StatelessWidget {
  final UserModel user;

  const HomeScrollView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<LocationCubit, LocationState>(
      listener: (context, locationState) {
        if (locationState.lat != null && locationState.lng != null) {
          context.read<ShopBloc>().add(GetShopsByLocationEvent(
            limit: 10,
            lat: locationState.lat!,
            lng: locationState.lng!,
            cursor: null,
          ));
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        body: CustomScrollView(
          slivers: [
            HomeContentWidgets.searchAndLocation(user.location!, context),
            HomeContentWidgets.appBar(context),
            HomeMainContent(),
            LoadMoreButton(),
            SliverToBoxAdapter(
              child: Image.asset(AppImages.homeWallpaper),
            ),
          ],
        ),
      ),
    );
  }
}