import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/helpers/ui/navigation_provider.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/screens/auth_screens/signin_screen_0.dart';
import 'package:adoodlz/ui/widgets/avatar_image.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/my_custom_icons2_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final getCountry =
        Provider.of<ChangeCountryIpProvider>(context, listen: false);

    final authProvider = Provider.of<AuthProvider>(
      context, /*listen: false*/
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 48,
          ),
          Text(
            AppLocalizations.of(context).yourProfile.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 32,
          ),
          Column(
            children: [
              Center(
                child: Consumer<AuthProvider>(
                  builder: (context, provider, _) => AvatarImage(
                    imageUrl: provider.user.image ?? '',
                    height: 100,
                    width: 100,
                    radius: 55,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Consumer<AuthProvider>(
                  builder: (context, provider, _) => Text(
                    provider.user.name.capitalize() ?? '',
                    style: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Consumer<AuthProvider>(
                  builder: (context, provider, _) => Text(
                    provider.user.mobile ?? '',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),

          /// show account verified or not verified //////////
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: authProvider.user.status != 'verified'
                      ? getStatusColor('pending')
                      : getStatusColor('verified'),
                  size: 11,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                    authProvider.user.status != 'verified'
                        ? AppLocalizations.of(context).account_not_verified
                        : AppLocalizations.of(context).account_verified,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 15.0)),
              ],
            ),
          ),
          UIHelper.verticalSpaceMedium(),
          CustomRaisedButton(
            width: 100.0,
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.editAccountScreen);
            },
            label: AppLocalizations.of(context).edit,
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.white),
            leading: const Icon(
              MyCustomIcons2.edit_icon,
              color: Colors.white,
              size: 15,
            ),
          ),
          UIHelper.verticalSpaceLarge(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                if (getCountry.countryName == 'SA')
                  ListTile(
                    onTap: () {
                      final appNavProvider =
                          context.read<AppNavigationProvider>();
                      appNavProvider.pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      appNavProvider.navigatorIndex = 2;
                    },
                    leading: const Icon(MyCustomIcons2.invite_friend_icon,
                        color: Color(0xFFDE608F)),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    dense: true,
                    title: Text(AppLocalizations.of(context).inviteFriend,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w400)),
                  ),
                if (getCountry.countryName == 'EG')
                  ListTile(
                    onTap: () {
                      final appNavProvider =
                          context.read<AppNavigationProvider>();
                      appNavProvider.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      appNavProvider.navigatorIndex = 1;
                    },
                    leading: const Icon(MyCustomIcons2.invite_friend_icon,
                        color: Color(0xFFDE608F)),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    dense: true,
                    title: Text(AppLocalizations.of(context).inviteFriend,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w400)),
                  ),
                const Divider(
                  color: Color(0xFFCCDCDC),
                  thickness: 1.0,
                  endIndent: 20.0,
                  indent: 70,
                  height: 30.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.termsScreen);
                  },
                  leading: const Icon(MyCustomIcons2.terms_icon,
                      color: Color(0xFFDE608F)),
                  dense: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  title: Text(AppLocalizations.of(context).termsAndConditions,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w400)),
                ),
                const Divider(
                  color: Color(0xFFCCDCDC),
                  thickness: 1.0,
                  endIndent: 20.0,
                  indent: 70,
                  height: 30.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.tasksScreen);
                  },
                  leading: const Icon(MyCustomIcons2.tasks_icon,
                      color: Color(0xFFDE608F)),
                  dense: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  title: Text(AppLocalizations.of(context).tasks,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w400)),
                ),
                const Divider(
                  color: Color(0xFFCCDCDC),
                  thickness: 1.0,
                  endIndent: 20.0,
                  indent: 70,
                  height: 30.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.settingScreen);
                  },
                  leading: const Icon(Icons.settings, color: Color(0xFFDE608F)),
                  dense: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  title: Text(AppLocalizations.of(context).settings,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w400)),
                ),
                const Divider(
                  color: Color(0xFFCCDCDC),
                  thickness: 1.0,
                  endIndent: 20.0,
                  indent: 70,
                  height: 30.0,
                ),
                if (authProvider.user.status != 'verified')
                  ListTile(
                    onTap: () async {
                      /// verify inside app again //////
                      try {
                        final id =
                            await Provider.of<AuthApi>(context, listen: false)
                                .sendOtp(authProvider.user.mobile);
                        if (id != null || id.isEmpty) {
                          Navigator.of(context).pushNamed(
                              Routes.verifyAccountScreen,
                              arguments: <String, dynamic>{
                                'number': authProvider.user.mobile,
                                '_id': id,
                                'resetPassword': false,
                              }).then((value) {
                            authProvider.updateUserData();
                          });
                          // Navigator.of(context).pushReplacementNamed(
                          //     Routes.signupScreen,
                          //     arguments: <String, dynamic>{
                          //       'mobile': authProvider.user.mobile,
                          //       '_id': id,
                          //       'resetPassword': false,
                          //     });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .processFailure),
                                    content: Text(AppLocalizations.of(context)
                                        .somethingWentWrong),
                                  ));
                        }
                      } catch (e) {
                        debugPrint((e as DioError).response.data.toString());
                        debugPrint("Error Here Catch");
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(AppLocalizations.of(context)
                                      .processFailure),
                                  content: Text(AppLocalizations.of(context)
                                      .somethingWentWrong),
                                ));
                      }
                    },
                    leading: const Icon(Icons.account_circle,
                        color: Color(0xFFDE608F)),
                    dense: true,
                    title: Text(
                        AppLocalizations.of(context).accountVerification,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w400)),
                  ),
                if (authProvider.user.status != 'verified')
                  const Divider(
                    color: Color(0xFFCCDCDC),
                    thickness: 1.0,
                    endIndent: 20.0,
                    indent: 70,
                    height: 30.0,
                  ),
                ListTile(
                  onTap: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout();
                    Provider.of<AppNavigationProvider>(context, listen: false)
                        .navigatorIndex = 0;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.signinScreen0,
                        (route) => route is SigninScreen0);
                  },
                  leading: const Icon(MyCustomIcons2.logout_icon,
                      color: Color(0xFFDD5757)),
                  dense: true,
                  title: Text(AppLocalizations.of(context).signout,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFDD5757))),
                ),
                UIHelper.verticalSpaceMedium(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color getStatusColor(String status) {
  if (status == 'verified') {
    return const Color(0xFF30E53C);
  } else if (status == 'pending') {
    return const Color(0xFFE53030);
  } else {
    return const Color(0xFFE5B530);
  }
}
