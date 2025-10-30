import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool twoFactorEnabled = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === Profile Card ===
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Egara Bahati",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Farmer • Nakuru County",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Edit Profile feature coming soon!"),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          // === General Settings ===
          const Text("General Settings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SwitchListTile(
            value: twoFactorEnabled,
            onChanged: (val) {
              setState(() => twoFactorEnabled = val);
            },
            title: const Text("Enable 2FA"),
            subtitle: const Text("Secure login with SMS OTP"),
          ),
          SwitchListTile(
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() => notificationsEnabled = val);
            },
            title: const Text("App Notifications"),
            subtitle: const Text("Get alerts from your farm sensors"),
          ),
          const Divider(height: 32),

          // === Connected Devices ===
          const Text("Connected Devices",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.sensors, color: Colors.green),
            title: const Text("Soil Moisture Sensor"),
            subtitle: const Text("Signal: OK"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.thermostat, color: Colors.orange),
            title: const Text("Temperature Sensor"),
            subtitle: const Text("Signal: Strong"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.water_drop, color: Colors.blue),
            title: const Text("Irrigation System"),
            subtitle: const Text("Active since 09:45 AM"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 32),

          // === Support & Info ===
          const Text("Support & Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help Center"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About App"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Plant Hub",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Egara Bahati",
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
      ),
    );
  }
}
