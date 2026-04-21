import 'package:divyesh_portfolio/widgets/technical_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SkillFactor extends StatefulWidget {
  const SkillFactor({super.key});

  @override
  State<SkillFactor> createState() => _SkillFactorState();
}

class _SkillFactorState extends State<SkillFactor> {
  String selectedCategory = "All";

  static final Map<String, List<String>> organizedSkills = {
    "Mobile Development": [
      "Swift 5",
      "UIKit",
      "Multi-Threading",
      "Core Location",
      "Traccar",
      "Third-party SDK Integration",
      "UI/UX Design",
    ],
    "Backend & API": [
      "Firebase",
      "Firebase Crashlytics",
      "RESTful APIs",
      "Alamofire",
      "Google Maps API",
      "Push Notifications",
      "Payment Integration",
    ],
    "Data & Persistence": ["SQLite", "CoreData"],
    "Tools & Environment": [
      "GitHub",
      "SourceTree",
      "CocoaPods",
      "SPM",
      "Xcode",
      "App Store Connect",
    ],
  };

  // Helper to get all skills for the "All" tab
  List<String> get allSkills {
    return organizedSkills.values.expand((list) => list).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> displaylist = selectedCategory == "All"
        ? allSkills
        : organizedSkills[selectedCategory]!;
    
    // Hide navigation title on large screen web view
    bool isWideScreen = MediaQuery.of(context).size.width > 900;
    bool showAppBar = !kIsWeb || !isWideScreen;

    return Scaffold(
      appBar: showAppBar 
        ? AppBar(
            title: const Text(
              "Skill",
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
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
              const TechnicalHeader(
                icon: Icons.psychology_outlined,
                title: "Skills",
                subtitle: "Technology expertise",
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3), // Shadow color
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildFilterChip("All"),
                      for (var category in organizedSkills.keys)
                        _buildFilterChip(category),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(1, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: displaylist
                          .map(
                            (skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                    // Shadow color
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                skill,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3), // Shadow color
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ChoiceChip(
          backgroundColor: Colors.white,
          showCheckmark: false,
          label: Text(category),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              selectedCategory = category;
            });
          },
          selectedColor: Colors.lightBlueAccent,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
