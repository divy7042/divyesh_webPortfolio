import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/app_store_project_card.dart';

class ProjectSkillScreen extends StatelessWidget {
  const ProjectSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWebMobileOrApp = !kIsWeb || MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isWebMobileOrApp
          ? AppBar(
              title: const Text(
                "Projects",
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectCard(
              "RTC Rider (Rainy Tiffin Choice)",
              "Food Delivery Service",
              "A specialized meal delivery platform providing fresh, healthy, and home-style tiffin services. Features subscription management and real-time delivery tracking for daily meals.",
              "",
              false,
            ),
            const SizedBox(height: 16),
            _buildProjectCard(
              "Amitaly",
              "Italian Food Ordering",
              "A dedicated food ordering app for authentic Italian cuisine. Streamlines the process from menu browsing to secure checkout, bringing the taste of Italy to the user's doorstep.",
              "",
              false,
            ),
            const SizedBox(height: 16),
            const AppStoreProjectCard(
              title: "Video Editor Crop and Mute",
              category: "Multimedia Utility",
              description:
                  "A high-performance video processing tool with a core focus on video merging. Allows users to seamlessly combine multiple clips into a single high-quality video with simple, intuitive controls.",
              urlString:
                  "https://apps.apple.com/in/app/video-editor-crop-and-mute/id6447301534",
              appId: "6447301534",
            ),
            const SizedBox(height: 16),
            const AppStoreProjectCard(
              title: "PushMeBaby",
              category: "macOS Developer Tool",
              description:
                  "A native macOS utility for testing push notifications. Supports .p8 and .p12 authentication for APNs and FCM.",
              urlString:
                  "https://apps.apple.com/in/app/pushmebaby/id6502684602",
              appId: "6502684602",
            ),
            const SizedBox(height: 20),
            const Text(
              "In-Dev",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(height: 16),
            _buildProjectCard(
              "Tribay Auto (Customer App)",
              "Automotive Service Platform • IN DEVELOPMENT",
              "Building a 24/7 auto-rickshaw repair and maintenance platform. Implementing features for expert mechanic booking, transparent pricing, and real-time service tracking.",
              "",
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String category,
    String description,
    String link,
    bool isUpcoming,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          if (link.isNotEmpty) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _launchURL(link),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "View Project",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  try {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch \$urlString');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
