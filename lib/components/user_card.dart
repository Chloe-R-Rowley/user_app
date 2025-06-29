import 'package:flutter/material.dart';
import '../screens/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
        );
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
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
              Icon(
                Icons.arrow_forward_ios,
                color: colorScheme.onPrimaryContainer,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
