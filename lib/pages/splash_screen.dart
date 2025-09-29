import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Smart Farming Made Easy",
      "subtitle": "Monitor your crops in real-time with AI-powered insights.",
      "image": "assets/images/farming.png"
    },
    {
      "title": "Track Soil & Weather",
      "subtitle": "Get accurate soil moisture, pH, and climate data anytime.",
      "image": "assets/images/soil.png"
    },
    {
      "title": "Boost Your Harvest",
      "subtitle": "Automated recommendations help you improve yields.",
      "image": "assets/images/harvest.png"
    },
  ];

  void _skip() {
    Navigator.pushReplacementNamed(context, "/auth");
  }

  void _nextPage() {
    if (_currentIndex == _pages.length - 1) {
      Navigator.pushReplacementNamed(context, "/auth");
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final item = _pages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Image instead of Lottie
                    Expanded(
                      flex: 3,
                      child: Image.asset(item["image"]!, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Subtitle
                    Text(
                      item["subtitle"]!,
                      style: TextStyle(color: cs.outline, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),

          // === Skip button ===
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _skip,
              child: Text(
                "Skip",
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // === Progress Indicator & Continue Button ===
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? cs.primary
                            : cs.primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Continue button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentIndex == _pages.length - 1
                          ? "Get Started"
                          : "Continue",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
