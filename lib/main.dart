import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/bloc/authentication_bloc.dart';
import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthenticationBloc();
    _router = createRouter(_authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthenticationBloc is placed above MaterialApp.router
    return BlocProvider<AuthenticationBloc>.value(
      value: _authBloc,
      child: MaterialApp.router(
        title: 'Book Club App',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}