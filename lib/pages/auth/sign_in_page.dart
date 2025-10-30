import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text("Sign In", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Let’s sign in with your account", style: theme.textTheme.bodyMedium),

              const SizedBox(height: 32),
              // Email
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (_) {}),
                  const Text("Keep me signed in"),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/reset-password"),
                    child: const Text("Forgot password?"),
                  )
                ],
              ),

              const SizedBox(height: 16),
              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    // TODO: handle sign in
                  },
                  child: const Text("Sign In"),
                ),
              ),

              const SizedBox(height: 24),
              Center(child: Text("Or, sign in with", style: theme.textTheme.bodyMedium)),
              const SizedBox(height: 16),

              // Google Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Image.asset("assets/logogoogle.png", height: 24), // place a Google icon in assets
                  label: const Text("Sign in with Google"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
