import 'package:flutter/material.dart';

class MyProfileIconAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  const MyProfileIconAppBar({super.key, required this.title, required this.onTap, required this.icon});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            iconSize: 35,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () => onTap(),
          ),
        )
      ],
    );
  }
}
