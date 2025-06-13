import 'package:auto_route/auto_route.dart';
import 'auth_guard.dart';
import 'package:flutter/material.dart';

import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../screens/components/dashboard.dart';
import '../screens/components/upload.dart';
import '../screens/components/profile.dart';
import '../screens/components/takequiz.dart';
import '../screens/components/viewnotes.dart';
import '../screens/components/notes.dart';
import '../screens/components/allquiz.dart';
import '../layout.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: RegisterRoute.page, path: '/register'),

    AutoRoute(
      page: LayoutRoute.page,
      initial: true,
      children: [
        AutoRoute(page: DashboardRoute.page, guards: [authGuard]),
        AutoRoute(page: StudyNotesRoute.page, guards: [authGuard]),
        AutoRoute(page: ProfileRoute.page, guards: [authGuard]),
      ],
      guards: [authGuard]
    ),
   
    AutoRoute(page: UploadDocsRoute.page, path: '/create', guards: [authGuard]),

    // AutoRoute(page: LayoutRoute.page, path: '/layout', guards: [authGuard]),

    AutoRoute(page: TakeQuizRoute.page, path: '/take-quiz', guards: [authGuard]),

    AutoRoute(page: QuizListRoute.page, path: '/all-quiz', guards: [authGuard]),


    AutoRoute(page: ViewNotesRoute.page,path: '/view-notes',guards: [authGuard]),
    // RedirectRoute(path: '/', redirectTo: '/layout'),
  ];
}
