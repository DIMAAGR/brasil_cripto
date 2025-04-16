import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final int favoriteLenght;
  final VoidCallback onTap;
  const FavoriteButton({
    super.key,
    required this.favoriteLenght,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.star_outline,
                color: AppTheme.colors(context).titleText,
                size: 32,
              ),
              if (favoriteLenght > 0)
                Positioned(
                  left: 0,
                  bottom: -2,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: AppTheme.colors(context).notification,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      favoriteLenght.toString(),
                      style: AppTheme.textStyle.labelSmall.copyWith(
                        color: AppTheme.colors(context).white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
