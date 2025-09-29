import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String title, value, subtitle;
  final bool highlight;

  const MetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight ? cs.primaryContainer : cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 26,
              color: highlight ? cs.onPrimaryContainer : cs.primary),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      highlight ? cs.onPrimaryContainer : cs.onSurface)),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: highlight ? cs.onPrimaryContainer : cs.onSurface)),
          if (subtitle.isNotEmpty)
            Text(subtitle,
                style: TextStyle(
                    color: highlight
                        ? cs.onPrimaryContainer.withOpacity(0.7)
                        : cs.outline)),
        ],
      ),
    );
  }
}
