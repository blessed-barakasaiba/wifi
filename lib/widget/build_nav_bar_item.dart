import 'package:flutter/material.dart';

class BuildNavBarItem extends StatelessWidget {
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;
  final IconData iconData;
  const BuildNavBarItem({
    super.key,
    required this.label,
    required this.currentIndex,
    required this.onTap,
    required this.iconData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == index;
    final textStyle = TextStyle(
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      color: isSelected ? Colors.blue : Colors.grey[400],
      fontSize: 12,
    );

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: isSelected ? Colors.blue : Colors.grey[400]),
            const SizedBox(height: 3),
            Text(label, style: textStyle,)
          ],
        ),
      ),
    );
  }
}
