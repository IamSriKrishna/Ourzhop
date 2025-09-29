import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartAppBar extends StatelessWidget {
  final String title;
  final String location;
  final VoidCallback? onBackPressed;

  const CartAppBar({
    super.key,
    this.title = 'Cart',
    this.location = 'Chennai, India',
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: colorScheme.primary,
      elevation: 0,
      toolbarHeight: 88,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withOpacity(0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                _BackButton(
                  onPressed: onBackPressed ?? () => context.pop(),
                  color: colorScheme.onPrimary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _TitleSection(
                    title: title,
                    location: location,
                    textColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const _BackButton({
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: color,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String location;
  final Color textColor;

  const _TitleSection({
    required this.title,
    required this.location,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: textColor.withOpacity(0.85),
              size: 14,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                location,
                style: TextStyle(
                  color: textColor.withOpacity(0.85),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: textColor.withOpacity(0.85),
              size: 18,
            ),
          ],
        ),
      ],
    );
  }
}