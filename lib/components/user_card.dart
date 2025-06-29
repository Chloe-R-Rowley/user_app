import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          user['name'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onPrimaryContainer,
            fontFamily: 'Spectral',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
