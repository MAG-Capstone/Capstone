import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  final String title = "Settings Screen";

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  bool isNotificationsEnabled = true; // Default value for notification switch
  String selectedLanguage = "English"; // Default language selection

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> syncPreferencesToBackend() async {
  final url = Uri.parse('http://localhost:3000/user/preferences');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'notifications': isNotificationsEnabled,
        'language': selectedLanguage,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved successfully!')),
      );
    } else {
      throw Exception('Failed to save preferences to backend.');
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}

  // Load preferences from local storage
  Future<void> loadPreferences() async {
     try {
      final url = Uri.parse('http://localhost:3000/user/preferences'); // Replace with your actual backend URL
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = jsonDecode(response.body);
        setState(() {
          // Update the UI with fetched preferences
          isNotificationsEnabled = data['notifications'] ?? true;
          selectedLanguage = data['language'] ?? "English";
        });
      } else {
        print("Failed to load preferences from backend.");
      }
    } catch (error) {
      print("Error loading preferences: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          // Notifications Switch
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: isNotificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                isNotificationsEnabled = value;
              });
              syncPreferencesToBackend();
            },
            secondary: const Icon(Icons.notifications),
          ),

          // Language Dropdown
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: <String>['English', 'Spanish', 'German']
              .map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
                syncPreferencesToBackend();
              },
            ),
          ),

          // Payment Method (Currently non-functional, just for display)
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment Method"),
            onTap: () {
              // You can add functionality for payment method here
              // For now, we throw an error as per your previous code
              throw UnimplementedError('This feature is not yet implemented.');
            },
          ),
        ],
      ),
    );
  }
}
