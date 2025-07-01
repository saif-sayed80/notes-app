import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/theme/theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListTile(
              trailing: Switch(
                activeColor: Theme.of(context).colorScheme.tertiary,
                value: Provider.of<ThemeProvider>(context).isLightMode, 
                onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              ),
              leading: Text(
                'Dark/Light mode',
                style: TextStyle(fontSize: 17)
              ),
            ),
          ),
        ],
      )
    );
  }
}