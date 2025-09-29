import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/tasks_page.dart';
import 'pages/analytic_page.dart';
import 'pages/chatbot_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_screen.dart';
import 'pages/auth_page.dart'; // placeholder for login/register

void main() => runApp(const PlantHubApp());

class PlantHubApp extends StatelessWidget {
  const PlantHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Hub',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      ),
      // 👇 First screen: Onboarding
      initialRoute: "/onboarding",
      routes: {
        "/onboarding": (_) => const OnboardingPage(),
        "/auth": (_) => const AuthPage(),
        "/home": (_) => const Shell(),
      },
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int index = 0;

  final pages = const [
    HomePage(),
    TasksPage(),
    AnalyticsPage(),
    ChatbotPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: pages[index]),

      // Floating Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() => index = i),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.check_circle_outline), label: 'Tasks'),
              NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Analytics'),
              NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chatbot'),
              NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
