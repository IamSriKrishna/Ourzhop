
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/store/presentation/widgets/circular_icon_button.dart';
import 'package:customer_app/features/store/presentation/widgets/store_info_header.dart';
import 'package:flutter/material.dart';

class GroceryAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String? storeName;
  final String? location;
  final String? deliveryInfo;
  final String? timeInfo;
  final VoidCallback? onSearch;

  const GroceryAppBar({
    super.key,
    required this.onBack,
    this.storeName = 'Store name',
    this.location = 'Chennai',
    this.deliveryInfo = 'Free delivery',
    this.timeInfo = '10-15 mins • 6 kms',
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      floating: false,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularIconButton(
          icon: Icons.arrow_back,
          onTap: onBack,
        ),
      ),
      title: StoreInfoHeader(
        storeName: storeName!,
        location: location!,
        deliveryInfo: deliveryInfo!,
        timeInfo: timeInfo!,
      ),
      actions: [
        CircularIconButton(
          icon: Icons.search,
          onTap: onSearch ?? () {},
        )
      ],
      backgroundColor: context.appColors.primary,
      elevation: 0,
    );
  }
}