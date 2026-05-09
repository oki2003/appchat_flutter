import 'package:flutter/material.dart';

class LoadingOverlay {
  static late GlobalKey<NavigatorState> _navigatorKey;
  static OverlayEntry? _overlayEntry;

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static void showLoading() {
    final overlay = _navigatorKey.currentState?.overlay;
    if (overlay == null) return;
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0,
        child: const WaveDotsLoading(),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class WaveDotsLoading extends StatefulWidget {
  final int dotCount;
  final double dotSize;
  final Color color;

  const WaveDotsLoading({
    super.key,
    this.dotCount = 3,
    this.dotSize = 10,
    this.color = Colors.blue,
  });

  @override
  State<WaveDotsLoading> createState() => _WaveDotsLoadingState();
}

class _WaveDotsLoadingState extends State<WaveDotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calcOffset(int index) {
    final delay = index * 0.2;
    final value = (_controller.value - delay) % 1.0;
    return (value * 2 - 1).abs(); // tạo dạng sóng
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.6,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.dotCount, (index) {
                  final scale = 0.5 + (_calcOffset(index) * 0.5);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        width: widget.dotSize,
                        height: widget.dotSize,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
