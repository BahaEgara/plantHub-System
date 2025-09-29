import 'package:flutter/material.dart';
import '../widgets/metric_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // === Top Row: Greeting + Icons ===
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Hello, Egara Kabaji",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Welcome back 👋",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 28),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/profile.jpg"), 
                  // placeholder — you can replace with NetworkImage later
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),

        // === Weather Card ===
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Weilburg, Germany",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Tue, 10 September 2024"),
                ],
              ),
              const SizedBox(height: 4),
              const Text("09:37 AM"),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Text("Sunny"),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("24°C",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      Text("H:46°  L:52°"),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Text("Spinach Garden 08"),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // === Metrics Grid ===
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.9,
          children: const [
            MetricCard(
                icon: Icons.eco,
                title: "Plant Health",
                value: "94%",
                subtitle: "Good",
                highlight: true),
            MetricCard(
                icon: Icons.air, title: "Wind", value: "2 m/s", subtitle: ""),
            MetricCard(
                icon: Icons.thermostat,
                title: "Temperature",
                value: "19°C",
                subtitle: ""),
            MetricCard(
                icon: Icons.science, title: "pH Level", value: "7.6", subtitle: ""),
            MetricCard(
                icon: Icons.water_drop,
                title: "Humidity",
                value: "82%",
                subtitle: ""),
            MetricCard(
                icon: Icons.grass,
                title: "Soil Moisture",
                value: "65%",
                subtitle: ""),
          ],
        ),
        const SizedBox(height: 20),

        // === Device Section ===
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Device",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Sensor: 4"),
                  Text("Camera: 5"),
                ],
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.sensors, color: Colors.green),
                title: const Text("JLNew H10: Soil Moisture Sensor"),
                subtitle: const Text("Active • Signal OK"),
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 16, color: cs.primary),
              )
            ],
          ),
        )
      ],
    );
  }
}
