import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final bool showFavoriteIcon;
  final bool showCompleteButton;
  final Future<bool> Function()? isFavorite;
  final VoidCallback? onCompletePressed;
  final Future<void> Function()? onFavoriteToggle;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.titleColor,
    this.showFavoriteIcon = false,
    this.showCompleteButton = false,
    this.isFavorite,
    this.onCompletePressed,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        if (showFavoriteIcon && isFavorite != null && onFavoriteToggle != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<bool>(
              future: isFavorite!(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Icon(Icons.favorite_border, color: Colors.white);
                }
                bool isFav = snapshot.data!;
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.black,
                  ),
                  onPressed: onFavoriteToggle,
                );
              },
            ),
          ),
        if (showCompleteButton && onCompletePressed != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(onPressed: onCompletePressed, child: Text('Completed',style: TextStyle(color: Colors.black87),)),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
