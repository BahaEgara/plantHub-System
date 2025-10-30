import 'package:flutter/material.dart';
import 'field_detail_page.dart'; // Ensure this file exists and matches your final version

class FieldsPage extends StatelessWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Each field now has different health status values
    final fields = [
      {
        "title": "Spinach Garden",
        "subtitle": "6 ha • Spinach",
        "value": "Good",
        "image": "assets/Field1.png"
      },
      {
        "title": "Maize Block",
        "subtitle": "8 ha • Maize",
        "value": "Moderate",
        "image": "assets/Field1.png"
      },
      {
        "title": "Tomato Greenhouse",
        "subtitle": "3 ha • Tomatoes",
        "value": "Bad",
        "image": "assets/Field1.png"
      },
      {
        "title": "Grape Fields",
        "subtitle": "11 ha • Grapes",
        "value": "Good",
        "image": "assets/Field1.png"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Fields"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two cards per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: fields.length,
          itemBuilder: (context, index) {
            final field = fields[index];
            return _buildFieldCard(
              context,
              title: field["title"]!,
              subtitle: field["subtitle"]!,
              value: field["value"]!,
              image: field["image"]!,
              cs: cs,
            );
          },
        ),
      ),
    );
  }

  Widget _buildFieldCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String value,
    required String image,
    required ColorScheme cs,
  }) {
    Color statusColor;
    switch (value.toLowerCase()) {
      case "good":
        statusColor = Colors.green;
        break;
      case "moderate":
        statusColor = Colors.orange;
        break;
      case "bad":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FieldDetailPage(
              title: title,
              subtitle: subtitle,
              image: image,
              value: value,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: statusColor.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          value,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Icon(Icons.open_in_new,
                          size: 16, color: Colors.black54),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
