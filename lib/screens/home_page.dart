import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../components/user_card.dart';
import '../bloc/user_bloc.dart';
import '../models/user_model.dart';
import 'user_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<User> _filterUsers(List<User> users, String query) {
    if (query.isEmpty) return users;

    final lowercaseQuery = query.toLowerCase();
    return users.where((user) {
      return user.name.toLowerCase().contains(lowercaseQuery) ||
          (user.username?.toLowerCase().contains(lowercaseQuery) ?? false) ||
          (user.email?.toLowerCase().contains(lowercaseQuery) ?? false) ||
          (user.company?.name?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      floatingActionButton: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BlocProvider.value(
                            value: context.read<UserBloc>(),
                            child: const UserFormPage(),
                          ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

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
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                child: const Icon(Icons.add),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Skeletonizer(
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Users',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Spectral',
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Loading users...',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontFamily: 'Spectral',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final dummyUser = User(
                              id: index + 1,
                              name: 'Loading User ${index + 1}',
                              username: 'user${index + 1}',
                              email: 'user${index + 1}@example.com',
                              phone: '+1-555-0123',
                              website: 'example.com',
                              address: Address(
                                street: '123 Main St',
                                suite: 'Apt 4B',
                                city: 'New York',
                                zipcode: '10001',
                                geo: Geo(lat: '40.7128', lng: '-74.0060'),
                              ),
                              company: Company(
                                name: 'Example Corp',
                                catchPhrase: 'Making the world better',
                                bs: 'harness real-time e-markets',
                              ),
                            );
                            return UserCard(user: dummyUser);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is UserLoaded) {
              final filteredUsers = _filterUsers(state.users, _searchQuery);

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsers());
                },
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          'Users',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Spectral',
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colorScheme.outline.withOpacity(0.2),
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search users...',
                              hintStyle: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontFamily: 'Spectral',
                                fontWeight: FontWeight.w300,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontFamily: 'Spectral',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? '${state.users.length} users found'
                              : '${filteredUsers.length} of ${state.users.length} users found',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontFamily: 'Spectral',
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child:
                              filteredUsers.isEmpty && _searchQuery.isNotEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No users found',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.onSurface,
                                          fontFamily: 'Spectral',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Try adjusting your search terms',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: colorScheme.onSurfaceVariant,
                                          fontFamily: 'Spectral',
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredUsers.length,
                                  itemBuilder: (context, index) {
                                    final user = filteredUsers[index];
                                    return UserCard(user: user);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserError) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(RefreshUsers());
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                            fontFamily: 'Spectral',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface,
                            fontFamily: 'Spectral',
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<UserBloc>().add(RefreshUsers());
                          },
                          icon: const Icon(Icons.refresh),
                          label: Text(
                            'Retry',
                            style: TextStyle(
                              fontFamily: 'Spectral',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
