import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/themes/provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final isLightMode = Provider.of<ThemeProvider>(context).isLightMode;

    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(
            isLightMode
                ? Icons.wb_sunny
                : Icons
                    .nightlight_round, // Sun icon for light mode, moon for dark mode
          ),
          onPressed: () {
            setState(() {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            });
          },
        ),
      ],
    );
  }
}
