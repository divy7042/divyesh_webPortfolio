import 'package:flutter/material.dart';

class MyTimelineItem extends StatelessWidget {
  final Widget content;
  final bool isLast;

  const MyTimelineItem({super.key, required this.content, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // The Timeline Column
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // 1. The Dot
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  // Aligns with the badge/text
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                // 2. The Line (Expanded to fill the rest of the height)
                Expanded(
                  child: Container(
                    width: 2,
                    // If it's the last item, we don't draw the line
                    color: isLast ? Colors.transparent : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // The Content on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
