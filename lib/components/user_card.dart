import 'package:flutter/material.dart';
import '../screens/user_detail_page.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                UserDetailPage(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
            transitionDuration: const Duration(milliseconds: 600),
          ),
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
                  user.name,
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
