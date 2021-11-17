import 'package:adoodlz/blocs/models/gift.dart';
import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/feature/change_passwrod/ui/screens/change_passwprd_screen.dart';
import 'package:adoodlz/feature/tasks/data/models/task_model.dart';
import 'package:adoodlz/feature/tasks/ui/screens/task_detail_screen.dart';
import 'package:adoodlz/feature/tasks/ui/screens/tasks_screen.dart';
import 'package:adoodlz/feature/verifiy_account/ui/page/verifiy_account_page.dart';
import 'package:adoodlz/feature/verifiy_account/ui/page/verify_profile_page.dart';
import 'package:adoodlz/ui/screens/about_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/create_account_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/edit_account_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/forget_password_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/reset_password_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/signin_screen_0.dart';
import 'package:adoodlz/ui/screens/auth_screens/signup_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/signup_screen_new.dart';
import 'package:adoodlz/ui/screens/auth_screens/verify_account_screen.dart';
import 'package:adoodlz/ui/screens/auth_screens/verify_reset_password.dart';
import 'package:adoodlz/ui/screens/auth_screens/verify_user_insidethe_app.dart';
import 'package:adoodlz/ui/screens/gift_details_screen.dart';
import 'package:adoodlz/ui/screens/post_details_screen.dart';
import 'package:adoodlz/ui/screens/setting_screen.dart';
import 'package:adoodlz/ui/screens/terms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adoodlz/ui/screens/home_screen/home_screen.dart';
import 'package:adoodlz/ui/screens/language_selection_screen_0.dart';
import 'package:adoodlz/ui/screens/splash_screen_0.dart';

class Routes {
  static const String splashScreen0 = '/';
  static const String homeScreen = '/home-screen';
  static const String languageSelectionScreen0 = '/language-selection-screen0';
  static const String signinScreen0 = '/sign-in0';
  static const String createAccountScreen = '/create-account';
  static const String verifyAccountScreen = '/verify-account';
  static const String giftDetailsScreen = '/gift-details';
  static const String postDetailsScreen = '/post-details';
  static const String aboutScreen = '/about';
  static const String termsScreen = '/terms';
  static const String signupScreen = '/sign-up';
  static const String editAccountScreen = '/edit-account';
  static const String getcash = '/getcash';
  static const String verifyProfilePage = '/verifyProfilePage';
  static const String verifyResetPasswordPage = '/verifyResetPassword';
  static const String verifyInsideApp = '/verifyInsideApp';

  static const String resetPasswordScreen = '/resetPasswordScreen';

  /// //////////////////
  static const String changePasswordScreen = '/change_password';
  static const String verifyAccountPage = '/verify_account_page';
  static const String signupScreenNew = '/sign-up_new';
  static const String settingScreen = '/settings';
  static const String tasksScreen = '/tasks';
  static const String taskDetailScreen = '/task_detail';
  static const String forgetPasswordScreen = '/forget_password';

  static const all = <String>{
    splashScreen0,
    homeScreen,
    languageSelectionScreen0,
    signinScreen0,
    createAccountScreen,
    verifyAccountScreen,
    giftDetailsScreen,
    postDetailsScreen,
    aboutScreen,
    termsScreen,
    signupScreen,
    editAccountScreen,
    getcash,
    changePasswordScreen,
    verifyProfilePage,
    tasksScreen,
    forgetPasswordScreen,
    verifyResetPasswordPage,
    verifyInsideApp
  };
}

// ignore: avoid_classes_with_only_static_members
class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen0:
        return MaterialPageRoute(builder: (_) => const SplashScreen0());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.languageSelectionScreen0:
        return MaterialPageRoute(
            builder: (_) => const LanguageSelectionScreen0());

      case Routes.signinScreen0:
        return MaterialPageRoute(builder: (_) => const SigninScreen0());

      case Routes.createAccountScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CreateAccountScreen(args['resetPassword'] as bool));
      case Routes.verifyAccountScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerifyAccountScreen(args['number'] as String,
              args['_id'] as String, args['resetPassword'] as bool,
              password: args['password'] as String),
        );

      case Routes.verifyResetPasswordPage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerifyResetPasswordScreen(args['number'] as String,
              args['_id'] as String, args['resetPassword'] as bool,
              password: args['password'] as String),
        );

      case Routes.verifyInsideApp:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerifyUserInsideApp(
            args['number'] as String,
            // args['_id'] as String, args['resetPassword'] as bool,
            // password: args['password'] as String
          ),
        );

      case Routes.giftDetailsScreen:
        final Gift args = settings.arguments as Gift;
        return MaterialPageRoute(
            builder: (_) => GiftDetailsScreen(
                  gift: args,
                ));
      case Routes.postDetailsScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PostDetailsScreen(post: args['post'] as Post));
      case Routes.aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case Routes.termsScreen:
        return MaterialPageRoute(builder: (_) => const TermsScreen());
      case Routes.signupScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignupScreen(args['mobile'] as String,
                args['_id'] as String, args['resetPassword'] as bool));
      case Routes.editAccountScreen:
        return MaterialPageRoute(builder: (_) => const EditAccountScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case Routes.verifyAccountPage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => VerifyAccountPage(args['number'] as String,
                args['_id'] as String, args['resetPassword'] as bool));

      case Routes.verifyProfilePage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => VerifyProfilePage(args['number'] as String,
                args['_id'] as String, args['resetPassword'] as bool));
      case Routes.signupScreenNew:
        return MaterialPageRoute(builder: (_) => SignUpScreenNew());
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.tasksScreen:
        return MaterialPageRoute(builder: (_) => TasksScreen());
      case Routes.taskDetailScreen:
        final TaskModel args = settings.arguments as TaskModel;
        return MaterialPageRoute(
            builder: (_) => TaskDetailScreen(
                  task: args,
                ));
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
