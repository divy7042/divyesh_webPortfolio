import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ItunesService {
  static Future<Map<String, dynamic>?> fetchAppDetails(String appId) async {
    try {
      // Direct URL for Mobile, Proxied URL for Web to bypass CORS
      String urlString = 'https://itunes.apple.com/lookup?id=$appId&country=in';

      if (kIsWeb) {
        urlString = 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(urlString)}';
      }

      final response = await http.get(Uri.parse(urlString));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['resultCount'] > 0) {
          return data['results'][0];
        }
      }
    } catch (e) {
      debugPrint('iTunes Fetch Error: $e');
    }
    return null;
  }
}