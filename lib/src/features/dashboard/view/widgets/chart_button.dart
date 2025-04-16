import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ChartButton extends StatelessWidget {
  final VoidCallback onTap;
  const ChartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.colors(context).inputSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        maximumSize: const Size(344, 40),
        iconColor: AppTheme.colors(context).input,
        textStyle: AppTheme.textStyle.labelMedium,
        foregroundColor: AppTheme.colors(context).input,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart_outlined),
          SizedBox(width: 8),
          Text(
            'Veja o gráfico das suas moedas favoritas',
          ),
        ],
      ),
    );
  }
}
