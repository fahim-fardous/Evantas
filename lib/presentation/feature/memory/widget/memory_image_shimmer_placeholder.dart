import 'package:flutter/material.dart';

class MemoryImageShimmerPlaceholder extends StatefulWidget {
  const MemoryImageShimmerPlaceholder({super.key});

  @override
  State<MemoryImageShimmerPlaceholder> createState() =>
      _MemoryImageShimmerPlaceholderState();
}

class _MemoryImageShimmerPlaceholderState
    extends State<MemoryImageShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color base =
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.08);
    final Color highlight =
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.18);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            final double width = bounds.width;
            final double t = _controller.value;
            return LinearGradient(
              begin: Alignment(-1.0 + (2.4 * t), -0.25),
              end: Alignment(-0.4 + (2.4 * t), 0.25),
              colors: [base, highlight, base],
              stops: const [0.1, 0.5, 0.9],
            ).createShader(Rect.fromLTWH(0, 0, width, bounds.height));
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            color: base,
          ),
        );
      },
    );
  }
}
