import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Egara Bahati"),
          subtitle: Text("Farmer • Nakuru County"),
        ),
        Divider(),
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text("Enable 2FA"),
          subtitle: Text("Secure login with SMS OTP"),
        ),
        ListTile(
          leading: Icon(Icons.devices_other),
          title: Text("Soil Moisture Sensor"),
          subtitle: Text("Signal OK"),
        ),
      ],
    );
  }
}
