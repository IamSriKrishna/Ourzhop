import 'package:flutter/material.dart';

class SearchLoadingIndicator extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry? margin;

  const SearchLoadingIndicator({
    super.key,
    this.height = 60,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 8.0),
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
