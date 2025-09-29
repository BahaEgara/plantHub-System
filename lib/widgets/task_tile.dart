import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title, subtitle;
  final bool done;

  const TaskTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: done,
      onChanged: (_) {},
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}
