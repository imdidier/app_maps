import 'package:go_router/go_router.dart';

import '../../ui/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
