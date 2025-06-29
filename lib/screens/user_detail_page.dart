import 'package:flutter/material.dart';
import '../components/user_detail_card.dart';

class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      user['name'] ?? 'User Details',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        fontFamily: 'Spectral',
                      ),
                      textAlign: TextAlign.center,
                    ),

                    if (user['username'] != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '@${user['username']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorScheme.onSurface,
                          fontFamily: 'Spectral',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: colorScheme.onSurface,
                  fontFamily: 'Spectral',
                ),
              ),

              const SizedBox(height: 8),

              UserDetailCard(
                label: 'User ID',
                value: user['id'].toString(),
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 4),

              if (user['email'] != null) ...[
                UserDetailCard(
                  label: 'Email',
                  value: user['email'],
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 4),
              ],

              if (user['phone'] != null) ...[
                UserDetailCard(
                  label: 'Phone',
                  value: user['phone'],
                  icon: Icons.phone_outlined,
                ),
                const SizedBox(height: 4),
              ],

              if (user['website'] != null) ...[
                UserDetailCard(
                  label: 'Website',
                  value: user['website'],
                  icon: Icons.language_outlined,
                ),
                const SizedBox(height: 4),
              ],

              const SizedBox(height: 20),

              if (user['address'] != null) ...[
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 8),

                UserDetailCard(
                  label: 'Street',
                  value: user['address']['street'] ?? '',
                  icon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 4),

                if (user['address']['suite'] != null) ...[
                  UserDetailCard(
                    label: 'Suite',
                    value: user['address']['suite'],
                    icon: Icons.home_outlined,
                  ),
                  const SizedBox(height: 4),
                ],

                UserDetailCard(
                  label: 'City',
                  value: user['address']['city'] ?? '',
                  icon: Icons.location_city_outlined,
                ),

                const SizedBox(height: 4),

                UserDetailCard(
                  label: 'Zip Code',
                  value: user['address']['zipcode'] ?? '',
                  icon: Icons.pin_drop_outlined,
                ),

                const SizedBox(height: 4),

                if (user['address']['geo'] != null) ...[
                  UserDetailCard(
                    label: 'Coordinates',
                    value:
                        '${user['address']['geo']['lat']}, ${user['address']['geo']['lng']}',
                    icon: Icons.gps_fixed_outlined,
                  ),
                  const SizedBox(height: 4),
                ],

                const SizedBox(height: 20),
              ],

              if (user['company'] != null) ...[
                Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 8),

                UserDetailCard(
                  label: 'Company Name',
                  value: user['company']['name'] ?? '',
                  icon: Icons.business_outlined,
                ),

                const SizedBox(height: 4),

                if (user['company']['catchPhrase'] != null) ...[
                  UserDetailCard(
                    label: 'Catch Phrase',
                    value: user['company']['catchPhrase'],
                    icon: Icons.tag_outlined,
                  ),
                  const SizedBox(height: 4),
                ],

                if (user['company']['bs'] != null) ...[
                  UserDetailCard(
                    label: 'Business',
                    value: user['company']['bs'],
                    icon: Icons.work_outline,
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
