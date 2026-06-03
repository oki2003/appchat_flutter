import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  const ErrorWidgetCustom({
    super.key,
    required this.message,
    required this.onRefresh,
  });

  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        GestureDetector(
          onTap: () => onRefresh(),
          child: Text('Thử lại', style: Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }
}
