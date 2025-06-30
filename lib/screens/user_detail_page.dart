import 'package:flutter/material.dart';
import '../components/user_detail_card.dart';
import '../models/user_model.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth < 768) {
              crossAxisCount = 1;
            } else if (constraints.maxWidth < 1440) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 4;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            fontFamily: 'Spectral',
                          ),
                          textAlign: TextAlign.center,
                        ),

                        if (user.username != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            '@${user.username}',
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

                  // Personal Information Section
                  _buildSectionHeader('Personal Information', colorScheme),
                  const SizedBox(height: 16),

                  LayoutGrid(
                    columnSizes: List.generate(crossAxisCount, (_) => 1.fr),
                    rowSizes: List<TrackSize>.generate(
                      ((user.email != null ? 1 : 0) +
                              (user.phone != null ? 1 : 0) +
                              (user.website != null ? 1 : 0) +
                              1 +
                              crossAxisCount -
                              1) ~/
                          crossAxisCount,
                      (_) => auto,
                    ),
                    columnGap: 16,
                    rowGap: 8,
                    children: [
                      UserDetailCard(
                        label: 'User ID',
                        value: user.id.toString(),
                        icon: Icons.person_outline,
                      ),
                      if (user.email != null)
                        UserDetailCard(
                          label: 'Email',
                          value: user.email!,
                          icon: Icons.email_outlined,
                        ),
                      if (user.phone != null)
                        UserDetailCard(
                          label: 'Phone',
                          value: user.phone!,
                          icon: Icons.phone_outlined,
                        ),
                      if (user.website != null)
                        UserDetailCard(
                          label: 'Website',
                          value: user.website!,
                          icon: Icons.language_outlined,
                        ),
                    ],
                  ),

                  // Address Section
                  if (user.address != null) ...[
                    const SizedBox(height: 32),
                    _buildSectionHeader('Address', colorScheme),
                    const SizedBox(height: 16),

                    LayoutGrid(
                      columnSizes: List.generate(crossAxisCount, (_) => 1.fr),
                      rowSizes: List<TrackSize>.generate(
                        ((user.address!.suite != null ? 1 : 0) +
                                (user.address!.geo != null ? 1 : 0) +
                                3 +
                                crossAxisCount -
                                1) ~/
                            crossAxisCount,
                        (_) => auto,
                      ),
                      columnGap: 16,
                      rowGap: 8,
                      children: [
                        UserDetailCard(
                          label: 'Street',
                          value: user.address!.street ?? '',
                          icon: Icons.location_on_outlined,
                        ),
                        if (user.address!.suite != null)
                          UserDetailCard(
                            label: 'Suite',
                            value: user.address!.suite!,
                            icon: Icons.home_outlined,
                          ),
                        UserDetailCard(
                          label: 'City',
                          value: user.address!.city ?? '',
                          icon: Icons.location_city_outlined,
                        ),
                        UserDetailCard(
                          label: 'Zip Code',
                          value: user.address!.zipcode ?? '',
                          icon: Icons.pin_drop_outlined,
                        ),
                        if (user.address!.geo != null)
                          UserDetailCard(
                            label: 'Coordinates',
                            value:
                                '${user.address!.geo!.lat}, ${user.address!.geo!.lng}',
                            icon: Icons.gps_fixed_outlined,
                          ),
                      ],
                    ),
                  ],

                  // Company Section
                  if (user.company != null) ...[
                    const SizedBox(height: 32),
                    _buildSectionHeader('Company', colorScheme),
                    const SizedBox(height: 16),

                    LayoutGrid(
                      columnSizes: List.generate(crossAxisCount, (_) => 1.fr),
                      rowSizes: List<TrackSize>.generate(
                        ((user.company!.catchPhrase != null ? 1 : 0) +
                                (user.company!.bs != null ? 1 : 0) +
                                1 +
                                crossAxisCount -
                                1) ~/
                            crossAxisCount,
                        (_) => auto,
                      ),
                      columnGap: 16,
                      rowGap: 8,
                      children: [
                        UserDetailCard(
                          label: 'Company Name',
                          value: user.company!.name ?? '',
                          icon: Icons.business_outlined,
                        ),
                        if (user.company!.catchPhrase != null)
                          UserDetailCard(
                            label: 'Catch Phrase',
                            value: user.company!.catchPhrase!,
                            icon: Icons.tag_outlined,
                          ),
                        if (user.company!.bs != null)
                          UserDetailCard(
                            label: 'Business',
                            value: user.company!.bs!,
                            icon: Icons.work_outline,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: colorScheme.onSurface,
          fontFamily: 'Spectral',
        ),
      ),
    );
  }
}
