import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DetailsTitleSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isColumn;
  const DetailsTitleSubtitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.isColumn = true,
  });

  @override
  Widget build(BuildContext context) {
    return isColumn
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.textStyle.title,
              ),
              Text(
                subtitle,
                style: AppTheme.textStyle.subtitle,
              ),
              const SizedBox(height: 16),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTheme.textStyle.labelLarger.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: AppTheme.textStyle.labelMedium,
                ),
              ],
            ),
          );
  }
}
