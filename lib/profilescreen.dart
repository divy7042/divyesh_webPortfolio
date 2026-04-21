import 'package:divyesh_portfolio/app_strings.dart';
import 'package:divyesh_portfolio/resume_viewer_screen.dart';
import 'package:divyesh_portfolio/widgets/MyTimelineItem.dart';
import 'package:divyesh_portfolio/widgets/ProjectHeader.dart';
import 'package:divyesh_portfolio/widgets/technical_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static final Map<String, List<String>> organizedSkills = {
    AppStrings.mobileDevelopment: [
      "Swift 5",
      "UIKit",
      "Multi-Threading",
      "Core Location",
      "Traccar",
      "Third-party SDK Integration",
      "UI/UX Design",
    ],
    AppStrings.backendApi: [
      "Firebase",
      "Firebase Crashlytics",
      "RESTful APIs",
      "Alamofire",
      "Google Maps API",
      "Push Notifications",
      "Payment Integration",
    ],
    AppStrings.dataPersistence: ["SQLite", "CoreData"],
    AppStrings.toolsEnvironment: [
      "GitHub",
      "SourceTree",
      "CocoaPods",
      "SPM",
      "Xcode",
      "App Store Connect",
    ],
  };

  void _handleResumeView(BuildContext context) {
    if (kIsWeb) {
      // On Web, open the Google Drive URL in a new tab
      _openUrl(AppStrings.driveUrl);
    } else {
      // On Android/iOS, navigate to the local PDF viewer
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResumeViewerScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 900;
    bool showAppBar = !isWideScreen;

    return Scaffold(
      appBar: showAppBar 
        ? AppBar(
            title: const Text(
              AppStrings.resume,
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.file_copy, color: Colors.lightBlueAccent),
                tooltip: 'View Resume',
                onPressed: () {
                  _handleResumeView(context);
                },
              ),
              const SizedBox(width: 10),
            ],
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            surfaceTintColor: Colors.transparent,
          )
        : null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TechnicalHeader(
                icon: Icons.push_pin_rounded,
                title: AppStrings.resume,
                subtitle: AppStrings.professionalProfile,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isWideScreen)
                      IconButton(
                        onPressed: () => _handleResumeView(context),
                        icon: const Icon(Icons.file_copy, color: Colors.lightBlueAccent),
                        tooltip: "View Resume",
                      ),
                    IconButton(
                      onPressed: () => _openUrl(AppStrings.linkedinUrl),
                      icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.lightBlueAccent),
                      tooltip: "LinkedIn",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TechnicalHeader(
                        icon: Icons.person_sharp,
                        title: AppStrings.divyeshParmar,
                        subtitle: AppStrings.iosDeveloper,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        AppStrings.email,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!isWideScreen || (!kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android))) ...[
                                    const SizedBox(height: 8),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: 18,
                                          color: Colors.lightBlueAccent,
                                        ),
                                        SizedBox(width: 25),
                                        Text(
                                          AppStrings.phone,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 18,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      SizedBox(width: 25),
                                      Text(
                                        AppStrings.location,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.stars_rounded, color: Colors.lightBlueAccent),
                          SizedBox(width: 10),
                          Text(
                            AppStrings.professionalSummary,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        AppStrings.summaryContent,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(color: Colors.black12),
                      SizedBox(height: 8),
                      ...[
                        HighlightItem(text: "Expert in Swift, UIKit, and architectural patterns like MVVM and MVC."),
                        HighlightItem(text: "Proven track record of shipping 4+ high-quality apps to the App Store."),
                        HighlightItem(text: "Specialized in RESTful APIs, Firebase, Core Data, and real-time tracking systems."),
                        HighlightItem(text: "Strong focus on UI/UX, animations, and building reliable, scalable codebases."),
                        HighlightItem(text: "Extensive experience with macOS developer tools and APNs integration."),
                      ]
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TechnicalHeader(
                    icon: Icons.book,
                    title: AppStrings.education,
                    subtitle: AppStrings.universityInfo,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TechnicalHeader(
                        icon: Icons.code,
                        title: AppStrings.technicalSkill,
                        subtitle: AppStrings.mobileDevelopment,
                      ),
                      const SizedBox(height: 20),
                      for (var entry in organizedSkills.entries) ...[
                        Text(
                          entry.key,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var skill in entry.value) ...[
                              _buildSkillChip(skill),
                            ],
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TechnicalHeader(
                        icon: Icons.code,
                        title: AppStrings.project,
                        subtitle: AppStrings.iosMacos,
                      ),
                      const SizedBox(height: 30),
                      ProjectHeader(
                        title: AppStrings.videoEditorTitle,
                        subtitle: AppStrings.videoEditorSubtitle,
                        showButton: true,
                        onTap: () async {
                          _openUrl(AppStrings.videoEditorUrl);
                        },
                      ),
                      const Divider(),
                      ProjectHeader(
                        title: AppStrings.amitalyTitle,
                        subtitle: AppStrings.amitalySubtitle,
                        showButton: true,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.notAvailableMsg),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ProjectHeader(
                        title: AppStrings.rtcRiderTitle,
                        subtitle: AppStrings.videoEditorSubtitle,
                        showButton: true,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.notAvailableMsg),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ProjectHeader(
                        title: AppStrings.pushMeBabyTitle,
                        subtitle: AppStrings.pushMeBabySubtitle,
                        showButton: true,
                        onTap: () async {
                          _openUrl(AppStrings.pushMeBabyUrl);
                        },
                      ),
                      const Divider(),
                      const SizedBox(height: 20),
                      ProjectHeader(
                        title: AppStrings.tribayCustomerTitle,
                        subtitle: AppStrings.videoEditorSubtitle,
                        showButton: true,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.inDevelopmentMsg),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TechnicalHeader(
                      icon: Icons.work_history_rounded,
                      title: AppStrings.experience,
                      subtitle: AppStrings.workHistory,
                    ),
                    const SizedBox(height: 20),
                    MyTimelineItem(
                      content: _buildExperienceContent(
                        type: AppStrings.fullTime,
                        typeColor: Colors.lightBlueAccent,
                        role: AppStrings.jrIosDev,
                        company: AppStrings.trikeMobitech,
                        period: AppStrings.period1,
                        description: AppStrings.desc1,
                        bulletPoints: AppStrings.bullets1,
                      ),
                    ),
                    MyTimelineItem(
                      isLast: false,
                      content: _buildExperienceContent(
                        type: AppStrings.fullTime,
                        typeColor: Colors.lightBlueAccent,
                        role: AppStrings.iosDeveloper,
                        company: AppStrings.magicTech,
                        period: AppStrings.period2,
                        description: AppStrings.desc2,
                        bulletPoints: AppStrings.bullets2,
                      ),
                    ),
                    MyTimelineItem(
                      isLast: true,
                      content: _buildExperienceContent(
                        type: AppStrings.fullTime,
                        typeColor: Colors.lightBlueAccent,
                        role: AppStrings.iosDeveloper,
                        company: AppStrings.softSolutions,
                        period: AppStrings.period3,
                        description: AppStrings.desc3,
                        bulletPoints: AppStrings.bullets3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TechnicalHeader(
                    icon: Icons.language,
                    title: AppStrings.language,
                    subtitle: AppStrings.languagesList,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TechnicalHeader(
                    icon: Icons.badge,
                    title: AppStrings.certification,
                    subtitle: AppStrings.certificationInfo,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildExperienceContent({
    required String company,
    required String role,
    required String period,
    required String type,
    required Color typeColor,
    required String description,
    required List<String> bulletPoints,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: typeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: typeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.lightBlueAccent,
          ),
        ),
        Text(
          company,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.lightBlueAccent,
          ),
        ),
        Text(period, style: const TextStyle(color: Colors.black, fontSize: 14)),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        ...bulletPoints.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_rounded,
                  color: Colors.lightBlueAccent,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HighlightItem extends StatelessWidget {
  final String text;
  const HighlightItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.lightBlueAccent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
