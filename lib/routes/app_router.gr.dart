// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardScreen();
    },
  );
}

/// generated route for
/// [LayoutScreen]
class LayoutRoute extends PageRouteInfo<void> {
  const LayoutRoute({List<PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LayoutScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [QuizListPage]
class QuizListRoute extends PageRouteInfo<void> {
  const QuizListRoute({List<PageRouteInfo>? children})
    : super(QuizListRoute.name, initialChildren: children);

  static const String name = 'QuizListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QuizListPage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [StudyNotesPage]
class StudyNotesRoute extends PageRouteInfo<void> {
  const StudyNotesRoute({List<PageRouteInfo>? children})
    : super(StudyNotesRoute.name, initialChildren: children);

  static const String name = 'StudyNotesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StudyNotesPage();
    },
  );
}

/// generated route for
/// [TakeQuizPage]
class TakeQuizRoute extends PageRouteInfo<TakeQuizRouteArgs> {
  TakeQuizRoute({Key? key, required int quizid, List<PageRouteInfo>? children})
    : super(
        TakeQuizRoute.name,
        args: TakeQuizRouteArgs(key: key, quizid: quizid),
        initialChildren: children,
      );

  static const String name = 'TakeQuizRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TakeQuizRouteArgs>();
      return TakeQuizPage(key: args.key, quizid: args.quizid);
    },
  );
}

class TakeQuizRouteArgs {
  const TakeQuizRouteArgs({this.key, required this.quizid});

  final Key? key;

  final int quizid;

  @override
  String toString() {
    return 'TakeQuizRouteArgs{key: $key, quizid: $quizid}';
  }
}

/// generated route for
/// [UploadDocsScreen]
class UploadDocsRoute extends PageRouteInfo<void> {
  const UploadDocsRoute({List<PageRouteInfo>? children})
    : super(UploadDocsRoute.name, initialChildren: children);

  static const String name = 'UploadDocsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UploadDocsScreen();
    },
  );
}

/// generated route for
/// [ViewNotesScreen]
class ViewNotesRoute extends PageRouteInfo<ViewNotesRouteArgs> {
  ViewNotesRoute({Key? key, required int id, List<PageRouteInfo>? children})
    : super(
        ViewNotesRoute.name,
        args: ViewNotesRouteArgs(key: key, id: id),
        initialChildren: children,
      );

  static const String name = 'ViewNotesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewNotesRouteArgs>();
      return ViewNotesScreen(key: args.key, id: args.id);
    },
  );
}

class ViewNotesRouteArgs {
  const ViewNotesRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'ViewNotesRouteArgs{key: $key, id: $id}';
  }
}
