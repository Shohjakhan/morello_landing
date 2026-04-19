import 'package:go_router/go_router.dart';
import '../presentation/pages/main_landing_page.dart';
import '../presentation/pages/problem/problem_page.dart';
import '../presentation/pages/demo/product_demo_page.dart';
import '../presentation/widgets/layout/app_layout.dart';

// Note: Solution, Team, Roadmap, Demo are sections within MainLandingPage
// but they can also be accessed as standalone routes if needed.
// For now, let's keep the landing page at / and problem at /problem.

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              MainLandingPage(key: MainLandingPage.globalKey),
        ),
        GoRoute(
          path: '/problem',
          builder: (context, state) => const ProblemPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/demo',
      builder: (context, state) => const ProductDemoPage(),
    ),
  ],
);
