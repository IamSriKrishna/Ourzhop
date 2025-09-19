// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/themes/app_colors.dart';

class AppPopupMenu<T> extends StatelessWidget {
  const AppPopupMenu({
    super.key,
    required this.items,
    required this.onChanged,
    this.icon = Icons.more_vert,
  });

  final List<T> items;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  String checkType(T item) {
    if (item.isEnum) return item.getEnumString;
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    return PopupMenuButton<T>(
      icon: Icon(icon),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: brandColors.outline),
      ),
      onSelected: (T item) {
        onChanged(item);
      },
      itemBuilder: (BuildContext context) {
        return items
            .map(
              (T item) => PopupMenuItem<T>(
                value: item,
                child: InkWell(child: Text(checkType(item))),
              ),
            )
            .toList();
      },
    );
  }
}

/// Legacy widget for backward compatibility
@Deprecated('Use AppPopupMenu instead')
class PopupMenu<T> extends AppPopupMenu<T> {
  const PopupMenu({
    super.key,
    required super.items,
    required super.onChanged,
    super.icon = Icons.more_vert,
  });
}
