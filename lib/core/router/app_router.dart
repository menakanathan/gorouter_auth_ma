import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/bloc/authentication_bloc.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/books/views/book_list_screen.dart';
import '../../features/books/views/book_detail_view.dart';
import '../../features/profile/views/profile_view.dart';
import 'app_scaffold_with_nav.dart';
import 'go_router_refresh_stream.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/byAuthor',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final authState = authBloc.state;
      final bool isLoggedIn = authState is AuthenticationLoggedIn;
      final bool isLoggingIn = state.matchedLocation == '/login';

      // 1. If not logged in and not on /login -> redirect to /login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // 2. If logged in and on /login -> redirect to /byAuthor
      if (isLoggedIn && isLoggingIn) {
        return '/byAuthor';
      }

      // No redirection needed
      return null;
    },
    routes: [
      // Top-level unauthenticated Login Route
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),

      // / (name: home) -> ShellRoute
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppScaffoldWithNav(child: child);
        },
        routes: [
          // /byAuthor (name: byAuthor)
          GoRoute(
            path: '/byAuthor',
            name: 'byAuthor',
            builder: (context, state) => const BookListScreen(
              title: 'Sorted by Author',
              detailRouteName: 'byAuthorDetail',
            ),
            routes: [
              // /detail (name: byAuthorDetail)
              GoRoute(
                path: 'detail',
                name: 'byAuthorDetail',
                parentNavigatorKey: _rootNavigatorKey, // Covers bottom navigation bar
                builder: (context, state) => const BookDetailScreen(source: 'By Author'),
              ),
            ],
          ),

          // /byTitle (name: byTitle)
          GoRoute(
            path: '/byTitle',
            name: 'byTitle',
            builder: (context, state) => const BookListScreen(
              title: 'Sorted by Title',
              detailRouteName: 'byTitleDetail',
            ),
            routes: [
              // /detail (name: byTitleDetail)
              GoRoute(
                path: 'detail',
                name: 'byTitleDetail',
                parentNavigatorKey: _rootNavigatorKey, // Covers bottom navigation bar
                builder: (context, state) => const BookDetailScreen(source: 'By Title'),
              ),
            ],
          ),

          // /profile (name: profile)
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}