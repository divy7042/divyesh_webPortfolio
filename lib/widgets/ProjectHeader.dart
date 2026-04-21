import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color themeColor;
  final bool showButton;
  final VoidCallback? onTap;

  const ProjectHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.themeColor = Colors.lightBlueAccent,
    this.showButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            // Status Dot
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Tagline / Subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        if (showButton) ...[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4), // Moves shadow downwards
                  spreadRadius: 1,
                ),
              ],
            ),
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                side: const BorderSide(color: Colors.white), // Makes border invisible against bg
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "View Projects",
                style: TextStyle(
                  fontWeight: FontWeight.w700, // Fixed syntax from .w700 to FontWeight.w700
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
