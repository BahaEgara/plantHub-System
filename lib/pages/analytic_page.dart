import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Analytics"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Plant"),
              Tab(text: "Tasks"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("Plant Health Graphs here")),
            Center(child: Text("Task Completion Graphs here")),
          ],
        ),
      ),
    );
  }
}
