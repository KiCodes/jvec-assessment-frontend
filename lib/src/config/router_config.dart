import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/screens/add_contact.dart';
import 'package:jvec_assessment_frontend/src/screens/contact_details.dart';
import 'package:jvec_assessment_frontend/src/screens/home_screen.dart';
import 'package:jvec_assessment_frontend/src/screens/login_screen.dart';
import 'package:jvec_assessment_frontend/src/screens/sign_up_screen.dart';
import 'package:jvec_assessment_frontend/src/screens/splash_screen.dart';


final GoRouter routerConfig = GoRouter(
  initialLocation: RoutesPath.splash,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    GoRoute(
      path: RoutesPath.splash,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
        path: RoutesPath.homeScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: false,
              key: state.pageKey,
              child: const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              });
        }
    ),
    GoRoute(
        path: RoutesPath.loginScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: false,
              key: state.pageKey,
              child: const LoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              });
        }
    ),
    GoRoute(
        path: RoutesPath.signupScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: false,
              key: state.pageKey,
              child: const SignUpScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              });
        }
    ),
    GoRoute(
        path: RoutesPath.addContactsScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: false,
              key: state.pageKey,
              child: const AddContact(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              });
        }
    ),
    GoRoute(
        path: RoutesPath.detailsScreen,
        pageBuilder: (context, state) {
          if (state.extra != null) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                barrierDismissible: false,
                key: state.pageKey,
                child: ContactDetails(firstName: args['firstName'],
                  lastName: args['lastName'], phone: args['phone'], id: args['id'],),
                transitionsBuilder: (context, animation, secondaryAnimation, child){
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                    child: child,
                  );
                });
          } else {
            return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                barrierDismissible: false,
                key: state.pageKey,
                child: const ContactDetails(firstName: '',
                    lastName: '', phone: '', id: '',),
                transitionsBuilder: (context, animation, secondaryAnimation, child){
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                    child: child,
                  );
                });
          }
        }
    ),
  ]
);