import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class WaitMessage extends StatelessWidget {
  const WaitMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: CircularProgressIndicator(
            color: AppTheme.colors(context).inputSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Por favor, aguarde...',
          style: AppTheme.textStyle.subtitle.copyWith(
            color: AppTheme.colors(context).inputSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
