import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ResumeViewerScreen extends StatefulWidget {
  const ResumeViewerScreen({super.key});

  @override
  State<ResumeViewerScreen> createState() => _ResumeViewerScreenState();
}

class _ResumeViewerScreenState extends State<ResumeViewerScreen> {
  Uint8List? _pdfBytes;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final ByteData data = await rootBundle.load('assets/Divyesh_resume.pdf');
      if (mounted) {
        setState(() {
          _pdfBytes = data.buffer.asUint8List();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Could not load PDF asset. Please ensure 'assets/Divyesh_resume.pdf' is listed in pubspec.yaml and the file exists.";
        });
      }
      debugPrint("PDF Load Error: $e");
    }
  }

  Future<void> _shareResume() async {
    if (kIsWeb || _pdfBytes == null) return;

    try {
      final directory = await getTemporaryDirectory();
      final io.File file = io.File('${directory.path}/Divyesh_resume.pdf');
      await file.writeAsBytes(_pdfBytes!);

      if (mounted) {
        final XFile xFile = XFile(file.path);
        await Share.shareXFiles(
          [xFile],
          subject: 'Divyesh Parmar Resume',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error sharing resume: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Resume',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          if (!kIsWeb && _pdfBytes != null && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android))
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.lightBlueAccent,
              ),
              onPressed: _shareResume,
              tooltip: "Share Resume",
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        color: Colors.white, // Ensure the container background is white
        child: _errorMessage != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            : _pdfBytes == null
                ? const Center(child: CircularProgressIndicator(color: Colors.lightBlueAccent))
                : SfPdfViewer.memory(
                    _pdfBytes!,
                    onDocumentLoadFailed: (details) {
                      if (mounted) {
                        setState(() {
                          _errorMessage = "PDF viewer failed: ${details.description}";
                        });
                      }
                    },
                  ),
      ),
    );
  }
}
