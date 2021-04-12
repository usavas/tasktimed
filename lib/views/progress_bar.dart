import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar(this.percentage);

  final percentage;

  @override
  Widget build(BuildContext context) {
    Border _border = Border.all(
      width: .6,
      color: Colors.black87,
    );
    const BorderRadius _borderRadius = BorderRadius.all(
      Radius.circular(4),
    );

    const double _lineHeight = 12;

    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: _border,
              borderRadius: _borderRadius,
              color: Colors.white70,
            ),
            width: (3 * 100) / 1.4,
            height: _lineHeight,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: Colors.green,
            ),
            width: (3 * (percentage * 100)) / 1.4,
            height: _lineHeight,
          ),
        ],
      ),
    );
  }
}
