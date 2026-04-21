import 'package:divyesh_portfolio/app_strings.dart';
import 'package:divyesh_portfolio/skill_factor.dart';
import 'package:divyesh_portfolio/widgets/technical_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:divyesh_portfolio/profilescreen.dart';
import 'package:divyesh_portfolio/projectskill.dart';
import 'package:divyesh_portfolio/widgets/app_store_project_card.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divyesh Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PersistentTabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.index = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomeContent(
        onViewAll: () => _onItemTapped(1),
        onViewProfile: () => _onItemTapped(3),
        onViewSkills: () => _onItemTapped(2),
      ),
      const ProjectSkillScreen(),
      const SkillFactor(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_work_outlined),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_bag_outlined),
        title: ("Project"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.psychology_outlined),
        title: ("Skill"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 900;

    if (isLargeScreen) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            "Divyesh Porfolio",
            style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
          ),
          actions: [
            _navTextButton("Home", 0),
            _navTextButton("Project", 1),
            _navTextButton("Skill", 2),
            _navTextButton("Profile", 3),
            const SizedBox(width: 40),
          ],
        ),
        body: _buildScreens()[_selectedIndex],
      );
    } else {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        onItemSelected: _onItemTapped,
        navBarStyle: NavBarStyle.style1,
      );
    }
  }

  Widget _navTextButton(String title, int index) {
    bool isActive = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => _onItemTapped(index),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.black54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback? onViewAll;
  final VoidCallback? onViewProfile;
  final VoidCallback? onViewSkills;

  const HomeContent({
    super.key,
    this.onViewAll,
    this.onViewProfile,
    this.onViewSkills,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> skills = ["iOS", "macOS", "Flutter"];
    final List<Map<String, dynamic>> coreTech = [
      {"name": "Swift", "icon": Icons.apple},
      {"name": "macOS", "icon": Icons.layers},
      {"name": "Flutter", "icon": Icons.flutter_dash},
      {"name": "Firebase", "icon": Icons.local_fire_department},
      {"name": "CoreData", "icon": Icons.storage},
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    bool isWide = screenWidth > 900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isWide ? null : AppBar(
        title: const Text("Divyesh Portfolio", style: TextStyle(color: Colors.lightBlueAccent)),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isWide ? 1000 : double.infinity),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.lightBlueAccent,
                              width: 4.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlueAccent.withValues(alpha: 0.5),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage("assets/hello.jpeg"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Divyesh Parmar",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        const Text(
                          "iOS Developer",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: skills.map((skill) => Chip(
                            label: Text(skill, style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.lightBlueAccent,
                          )).toList(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final Uri emailLaunchUri = Uri(scheme: 'mailto', path: AppStrings.email);
                                await launchUrl(emailLaunchUri);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
                              child: const Text("Contact", style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton.icon(
                              onPressed: onViewProfile,
                              icon: const Icon(Icons.insert_drive_file),
                              label: const Text("Resume"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.lightBlueAccent,
                                side: const BorderSide(color: Colors.lightBlueAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildStatCard("3.8+", "Years\nExperience"),
                      const SizedBox(width: 15),
                      _buildStatCard("5+", "Apps\nShipped"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TechnicalHeader(icon: Icons.code_rounded, title: "Skills", subtitle: "Technology"),
                      const SizedBox(height: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: coreTech.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isWide ? 4 : 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 60,
                        ),
                        itemBuilder: (context, index) {
                          final tech = coreTech[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                Icon(tech['icon'], color: Colors.lightBlueAccent),
                                const SizedBox(width: 15),
                                Text(tech['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: onViewSkills,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("View all skills"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const TechnicalHeader(icon: Icons.shopping_bag_outlined, title: "Project", subtitle: "5 Apps Built"),
                      const SizedBox(height: 15),
                      const AppStoreProjectCard(
                        title: "Video Editor Crop and Mute",
                        category: "Multimedia Utility",
                        description: "A high-performance video processing tool focus on video merging.",
                        urlString: "https://apps.apple.com/in/app/video-editor-crop-and-mute/id6447301534",
                        appId: "6447301534",
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: onViewAll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("View all projects"),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
