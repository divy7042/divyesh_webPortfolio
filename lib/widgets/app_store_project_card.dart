import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/itunes_service.dart';

class AppStoreProjectCard extends StatefulWidget {
  final String title;
  final String category;
  final String description;
  final String urlString;
  final String appId;

  const AppStoreProjectCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.urlString,
    required this.appId,
  });

  @override
  State<AppStoreProjectCard> createState() => _AppStoreProjectCardState();
}

class _AppStoreProjectCardState extends State<AppStoreProjectCard> {
  Map<String, dynamic>? _appData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await ItunesService.fetchAppDetails(widget.appId);
    if (mounted) {
      setState(() {
        _appData = data;
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch ${widget.urlString}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildImage(String url, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      // Use standard Image.network for Web to better handle CORS/Renderers
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconUrl = _appData?['artworkUrl512'];
    final List<dynamic> rawScreenshots = _appData?['screenshotUrls'] ?? [];
    final List<String> screenshots = rawScreenshots
        .map((e) => e.toString())
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : iconUrl != null
                      ? _buildImage(iconUrl)
                      : const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Main Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            widget.description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          if (screenshots.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: screenshots.length,
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Container(
                    width: 112,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12, width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: _buildImage(screenshots[index]),
                    ),
                  );
                },
              ),
            ),
          if (screenshots.isNotEmpty) const SizedBox(height: 16),
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _launchURL,
              icon: const Icon(Icons.apple),
              label: const Text(
                "View on App Store",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
