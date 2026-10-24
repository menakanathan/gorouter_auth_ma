# gorouter_auth_ma

GoRouter and AuthenticationBloc HW4

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Requirements

- Place an AuthenticationBloc above the MaterialApp.router
- Create GoRouter with the following paths (indentation is for levels
/ (name: home) → Shellroute
/byAuthor  (name: byAuthor)
/detail  (name: byAuthorDetail)
/byTitle (name: byTitle)
/detail (name: byTitleDetail)
/profile (name: profile)
/login (name: login)
- Create a Listenable from the stream of the AuthenticationBloc
- Add a redirect to the GoRouter checking AuthenticationState every time (it can be due to a new path or due to refresh coming from RefreshListenable)
- Redirect
If Authentication is loggedIn and current path is /login → /byAuthor
If Authentication is notLoggedIn and current path is not /login → /login
- Follow the flow in the Figma instructions


## Dependencies

Dependency      Purpose

flutter_bloc    Predictable state management handling authentication events and states

go_router       Declarative URL-based routing framework with route redirection.

