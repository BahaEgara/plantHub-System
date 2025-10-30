import 'dart:math';
import 'package:flutter/material.dart';

class FieldDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String value; // Health status passed from FieldsPage

  const FieldDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.value,
  });

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int healthScore;
  late String status;

  @override
  void initState() {
    super.initState();

    status = widget.value;
    healthScore = _getHealthScore(status);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: healthScore / 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _controller.forward();
  }

  int _getHealthScore(String status) {
    final random = Random();
    switch (status.toLowerCase()) {
      case "good":
        return 80 + random.nextInt(15);
      case "moderate":
        return 60 + random.nextInt(15);
      case "bad":
        return 40 + random.nextInt(15);
      default:
        return 50;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "good":
        return Colors.green;
      case "moderate":
        return Colors.orange;
      case "bad":
      case "high stress":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _generateSensorData(String status) {
    final random = Random();

    double randomize(double base, double variation) =>
        base + random.nextDouble() * variation;

    // Adjust data range based on plant health
    switch (status.toLowerCase()) {
      case "good":
        return [
          {"icon": Icons.water_drop, "name": "Soil Moisture", "value": "${randomize(70, 5).toStringAsFixed(1)}%", "status": "Good"},
          {"icon": Icons.thermostat, "name": "Ambient Temp", "value": "${randomize(25, 2).toStringAsFixed(1)}°C", "status": "Good"},
          {"icon": Icons.landscape, "name": "Soil Temp", "value": "${randomize(22, 2).toStringAsFixed(1)}°C", "status": "Good"},
          {"icon": Icons.water, "name": "Humidity", "value": "${randomize(75, 5).toStringAsFixed(1)}%", "status": "Good"},
          {"icon": Icons.wb_sunny, "name": "Light Intensity", "value": "${randomize(500, 50).toStringAsFixed(0)} lx", "status": "Good"},
          {"icon": Icons.science, "name": "Soil pH", "value": "${randomize(6.8, 0.3).toStringAsFixed(1)}", "status": "Good"},
          {"icon": Icons.grass, "name": "Nitrogen", "value": "${randomize(40, 5).toStringAsFixed(1)} ppm", "status": "Good"},
          {"icon": Icons.local_florist, "name": "Phosphorus", "value": "${randomize(35, 5).toStringAsFixed(1)} ppm", "status": "Good"},
          {"icon": Icons.eco, "name": "Potassium", "value": "${randomize(60, 5).toStringAsFixed(1)} ppm", "status": "Good"},
          {"icon": Icons.energy_savings_leaf, "name": "Chlorophyll", "value": "${randomize(35, 5).toStringAsFixed(1)} µg/cm²", "status": "Good"},
          {"icon": Icons.electrical_services, "name": "Electrochemical", "value": "${randomize(0.6, 0.1).toStringAsFixed(2)} V", "status": "Good"},
        ];

      case "moderate":
        return [
          {"icon": Icons.water_drop, "name": "Soil Moisture", "value": "${randomize(55, 10).toStringAsFixed(1)}%", "status": "Moderate"},
          {"icon": Icons.thermostat, "name": "Ambient Temp", "value": "${randomize(28, 3).toStringAsFixed(1)}°C", "status": "Moderate"},
          {"icon": Icons.landscape, "name": "Soil Temp", "value": "${randomize(24, 3).toStringAsFixed(1)}°C", "status": "Moderate"},
          {"icon": Icons.water, "name": "Humidity", "value": "${randomize(60, 10).toStringAsFixed(1)}%", "status": "Moderate"},
          {"icon": Icons.wb_sunny, "name": "Light Intensity", "value": "${randomize(700, 100).toStringAsFixed(0)} lx", "status": "Moderate"},
          {"icon": Icons.science, "name": "Soil pH", "value": "${randomize(6.0, 0.5).toStringAsFixed(1)}", "status": "Moderate"},
          {"icon": Icons.grass, "name": "Nitrogen", "value": "${randomize(30, 10).toStringAsFixed(1)} ppm", "status": "Moderate"},
          {"icon": Icons.local_florist, "name": "Phosphorus", "value": "${randomize(25, 5).toStringAsFixed(1)} ppm", "status": "Moderate"},
          {"icon": Icons.eco, "name": "Potassium", "value": "${randomize(45, 10).toStringAsFixed(1)} ppm", "status": "Moderate"},
          {"icon": Icons.energy_savings_leaf, "name": "Chlorophyll", "value": "${randomize(25, 5).toStringAsFixed(1)} µg/cm²", "status": "Moderate"},
          {"icon": Icons.electrical_services, "name": "Electrochemical", "value": "${randomize(0.5, 0.1).toStringAsFixed(2)} V", "status": "Moderate"},
        ];

      case "bad":
      case "high stress":
        return [
          {"icon": Icons.water_drop, "name": "Soil Moisture", "value": "${randomize(35, 8).toStringAsFixed(1)}%", "status": "Bad"},
          {"icon": Icons.thermostat, "name": "Ambient Temp", "value": "${randomize(32, 4).toStringAsFixed(1)}°C", "status": "Bad"},
          {"icon": Icons.landscape, "name": "Soil Temp", "value": "${randomize(28, 3).toStringAsFixed(1)}°C", "status": "Bad"},
          {"icon": Icons.water, "name": "Humidity", "value": "${randomize(45, 10).toStringAsFixed(1)}%", "status": "Bad"},
          {"icon": Icons.wb_sunny, "name": "Light Intensity", "value": "${randomize(900, 150).toStringAsFixed(0)} lx", "status": "Bad"},
          {"icon": Icons.science, "name": "Soil pH", "value": "${randomize(5.3, 0.4).toStringAsFixed(1)}", "status": "Bad"},
          {"icon": Icons.grass, "name": "Nitrogen", "value": "${randomize(20, 5).toStringAsFixed(1)} ppm", "status": "Bad"},
          {"icon": Icons.local_florist, "name": "Phosphorus", "value": "${randomize(18, 5).toStringAsFixed(1)} ppm", "status": "Bad"},
          {"icon": Icons.eco, "name": "Potassium", "value": "${randomize(30, 5).toStringAsFixed(1)} ppm", "status": "Bad"},
          {"icon": Icons.energy_savings_leaf, "name": "Chlorophyll", "value": "${randomize(15, 5).toStringAsFixed(1)} µg/cm²", "status": "Bad"},
          {"icon": Icons.electrical_services, "name": "Electrochemical", "value": "${randomize(0.3, 0.1).toStringAsFixed(2)} V", "status": "Bad"},
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sensorData = _generateSensorData(status);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildTopImage(),
          const SizedBox(height: 20),
          _buildHealthIndicator(cs),
          const SizedBox(height: 20),
          _buildSensorGrid(sensorData),
          const SizedBox(height: 20),
          _buildAdvisoryBox(cs),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTopImage() => Stack(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  Colors.black.withOpacity(0.4)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
                Text(widget.subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      );

  Widget _buildHealthIndicator(ColorScheme cs) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              const Text("Overall Plant Health",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) => Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 10,
                        color: _getStatusColor(status),
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                    Text("${(_animation.value * 100).toInt()}%",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(status))),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(status,
                  style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
        ),
      );

  Widget _buildSensorGrid(List<Map<String, dynamic>> sensorData) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sensor Data Overview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: sensorData.length,
              itemBuilder: (context, i) {
                final sensor = sensorData[i];
                final color = _getStatusColor(sensor["status"]);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color.withOpacity(0.4), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(sensor["icon"], color: color, size: 26),
                      const SizedBox(height: 6),
                      Text(sensor["name"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(sensor["value"],
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 11)),
                      const SizedBox(height: 2),
                      Text(sensor["status"],
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w500,
                              fontSize: 11)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );

  Widget _buildAdvisoryBox(ColorScheme cs) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Text(
            status.toLowerCase() == "good"
                ? "✅ The field is healthy. Maintain current irrigation and nutrient schedule."
                : status.toLowerCase() == "moderate"
                    ? "⚠️ Field shows moderate stress. Check soil nutrients and ensure proper irrigation."
                    : "🚨 Field under high stress! Immediate attention required — check moisture, pH, and apply corrective fertilizers.",
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
        ),
      );
}
