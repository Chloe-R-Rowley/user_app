import 'package:flutter/material.dart';

class UserDetailCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isStatus;

  const UserDetailCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.onPrimaryContainer, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onPrimaryContainer,
                      fontFamily: 'Spectral',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isStatus)
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: value == 'Active'
                                ? Colors.green
                                : colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onPrimaryContainer,
                            fontFamily: 'Spectral',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onPrimaryContainer,
                        fontFamily: 'Spectral',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
