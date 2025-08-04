import 'package:flutter/material.dart';

// Digital ticker widget for animated number display
class DigitalTicker extends StatelessWidget {
  final int value;
  final String label;

  const DigitalTicker({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated number with flip effect
        TweenAnimationBuilder(
          tween: IntTween(begin: value, end: value),
          duration: Duration(milliseconds: label == 'Milliseconds' ? 50 : 300), // Faster for ms
          builder: (context, int animatedValue, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Text(
                animatedValue.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: label == 'Milliseconds' ? 20 : 30, // Smaller for ms
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A5ACD), // Blue
                ),
              ),
            );
          },
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6A5ACD),
          ),
        ),
      ],
    );
  }
}