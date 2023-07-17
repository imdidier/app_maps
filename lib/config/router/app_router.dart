import 'package:go_router/go_router.dart';

import '../../ui/screens/screens.dart';
import '../../ui/views/views.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recovery-password',
      builder: (context, state) => RecoveryPasswordView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterView(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const SingInView(),
    ),
  ],
);
