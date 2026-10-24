import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const AppScaffoldWithNav({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/byAuthor')) return 0;
    if (location.startsWith('/byTitle')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFFEADBFC), // Soft purple pill indicator
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFF4C3E74));
            }
            return const IconThemeData(color: Colors.black54);
          }),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFFFAF5FD),
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.goNamed('byAuthor');
                break;
              case 1:
                context.goNamed('byTitle');
                break;
              case 2:
                context.goNamed('profile');
                break;
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'By Author',
            ),
            NavigationDestination(
              icon: Icon(Icons.title),
              selectedIcon: Icon(Icons.title),
              label: 'By Title',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}