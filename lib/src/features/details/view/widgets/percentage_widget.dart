import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PercentageWidget extends StatelessWidget {
  final double value;
  const PercentageWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          value < 0 ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
          color: value < 0 ? AppTheme.colors(context).red : AppTheme.colors(context).green,
        ),
        Text(
          '${value.abs().toStringAsFixed(2)}%',
          style: AppTheme.textStyle.percentage.copyWith(
            color: value < 0 ? AppTheme.colors(context).red : AppTheme.colors(context).green,
          ),
        ),
      ],
    );
  }
}
