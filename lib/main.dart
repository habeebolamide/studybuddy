import 'package:flutter/material.dart';
import './routes/app_router.dart';
import './routes/auth_guard.dart';



final _appRouter = AppRouter(AuthGuard());

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
