import 'package:flutter/material.dart';
import '../components/user_card.dart';
import 'user_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> users = [
      {
        'id': 1,
        'name': 'Leanne Graham',
        'username': 'Bret',
        'email': 'Sincere@april.biz',
        'address': {
          'street': 'Kulas Light',
          'suite': 'Apt. 556',
          'city': 'Gwenborough',
          'zipcode': '92998-3874',
          'geo': {'lat': '-37.3159', 'lng': '81.1496'},
        },
        'phone': '1-770-736-8031 x56442',
        'website': 'hildegard.org',
        'company': {
          'name': 'Romaguera-Crona',
          'catchPhrase': 'Multi-layered client-server neural-net',
          'bs': 'harness real-time e-markets',
        },
      },
      {
        'id': 2,
        'name': 'Ervin Howell',
        'username': 'Antonette',
        'email': 'Shanna@melissa.tv',
        'address': {
          'street': 'Victor Plains',
          'suite': 'Suite 879',
          'city': 'Wisokyburgh',
          'zipcode': '90566-7771',
          'geo': {'lat': '-43.9509', 'lng': '-34.4618'},
        },
        'phone': '010-692-6593 x09125',
        'website': 'anastasia.net',
        'company': {
          'name': 'Deckow-Crist',
          'catchPhrase': 'Proactive didactic contingency',
          'bs': 'synergize scalable supply-chains',
        },
      },
      {
        'id': 3,
        'name': 'Clementine Bauch',
        'username': 'Samantha',
        'email': 'Nathan@yesenia.net',
        'address': {
          'street': 'Douglas Extension',
          'suite': 'Suite 847',
          'city': 'McKenziehaven',
          'zipcode': '59590-4157',
          'geo': {'lat': '-68.6102', 'lng': '-47.0653'},
        },
        'phone': '1-463-123-4447',
        'website': 'ramiro.info',
        'company': {
          'name': 'Romaguera-Jacobson',
          'catchPhrase': 'Face to face bifurcated interface',
          'bs': 'e-enable strategic applications',
        },
      },
      {
        'id': 4,
        'name': 'Patricia Lebsack',
        'username': 'Karianne',
        'email': 'Julianne.OConner@kory.org',
        'address': {
          'street': 'Hoeger Mall',
          'suite': 'Apt. 692',
          'city': 'South Elvis',
          'zipcode': '53919-4257',
          'geo': {'lat': '29.4572', 'lng': '-164.2990'},
        },
        'phone': '493-170-9623 x156',
        'website': 'kale.biz',
        'company': {
          'name': 'Robel-Corkery',
          'catchPhrase': 'Multi-tiered zero tolerance productivity',
          'bs': 'transition cutting-edge web services',
        },
      },
      {
        'id': 5,
        'name': 'Chelsey Dietrich',
        'username': 'Kamren',
        'email': 'Lucio_Hettinger@annie.ca',
        'address': {
          'street': 'Skiles Walks',
          'suite': 'Suite 351',
          'city': 'Roscoeview',
          'zipcode': '33263',
          'geo': {'lat': '-31.8129', 'lng': '62.5342'},
        },
        'phone': '(254)954-1289',
        'website': 'demarco.info',
        'company': {
          'name': 'Keebler LLC',
          'catchPhrase': 'User-centric fault-tolerant solution',
          'bs': 'revolutionize end-to-end systems',
        },
      },
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      floatingActionButton: FadeTransition(
        opacity: _fadeAnimation,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const UserFormPage(),
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
      ),
      body: SafeArea(
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
                const SizedBox(height: 8),
                Text(
                  '${users.length} users found',
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
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserCard(user: user);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
