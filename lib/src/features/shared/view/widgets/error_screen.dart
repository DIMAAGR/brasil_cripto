import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 72,
          ),
          SizedBox(height: 16),
          Text(
            'Ops, houve um erro! \nVerifique sua conexão e tente novamente!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
