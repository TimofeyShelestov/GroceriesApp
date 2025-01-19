import 'package:flutter/material.dart';

class ErrorSnackbar extends StatelessWidget {
  final String message;

  const ErrorSnackbar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: colorScheme.onError,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: colorScheme.onError,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      ErrorSnackbar(message: message).build(context) as SnackBar,
    );
  }
}
