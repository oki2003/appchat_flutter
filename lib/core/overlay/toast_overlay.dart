import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToastOverlay {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static void showToastBottom(String message, bool isSuccess) {
    final overlay = _navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 14,
          left: 14,
          right: 14,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 60, end: 0),
            duration: Duration(milliseconds: 150),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Material(
              color: Colors.transparent,
              child: _buildToastBottom(message, isSuccess),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 5), () {
      overlayEntry.remove();
    });
  }

  static Widget _buildToastBottom(String message, bool isSuccess) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              child: Icon(
                isSuccess ? Icons.check : Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
