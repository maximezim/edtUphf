import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool shadowColor = false;
  final double scrolledUnderElevation = 3.0;
  final String? title;
  const TopAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!),
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
