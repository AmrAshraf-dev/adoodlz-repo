import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:adoodlz/helpers/ui/navigation_provider.dart';
import 'package:adoodlz/ui/widgets/my_custom_icons2_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/target_position.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  void _navigateToPage(int pageIndex) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    final appNavProvider = context.read<AppNavigationProvider>();
    appNavProvider.pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    appNavProvider.navigatorIndex = pageIndex;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getCountry =
        Provider.of<ChangeCountryIpProvider>(context, listen: false);
    //ignore: sized_box_for_whitespace
    return Container(
      height: 80.0,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          selectedIndex: context.watch<AppNavigationProvider>().navigatorIndex,
          onTabChange: (int value) {
            _navigateToPage(value);
          },
          //haptic: true, // haptic feedback
          tabBorderRadius: 20,
          curve: Curves.easeOutExpo, // tab animation curves
          duration: const Duration(milliseconds: 300), // tab animation duration
          gap: 4, // the tab button gap between icon and text
          //color: const Color(0xFFE0DDF5),
          activeColor: const Color(0xFFDE608F), // selected icon and text color
          iconSize: 26, // tab button icon size
          tabBackgroundColor: const Color(0xFFDE608F).withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          tabs: [
            if (getCountry.countryName == 'SA')
              GButton(
                icon: MyCustomIcons2.home_icon,
                text: AppLocalizations.of(context).home,
              ),
            GButton(
              icon: MyCustomIcons2.tasks_icon,
              text: AppLocalizations.of(context).tasks,
            ),
            GButton(
              icon: MyCustomIcons2.invite_friend_icon,
              text: AppLocalizations.of(context).inviteFriend,
            ),
            GButton(
              icon: MyCustomIcons2.wallet_icon,
              text: AppLocalizations.of(context).yourWallet,
            ),
            GButton(
              icon: MyCustomIcons2.profile_icon,
              text: AppLocalizations.of(context).yourProfile,
            )
          ]),
    );
  }

  void initTargets() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widthPerItem = width / 5;
    final widthOffset = widthPerItem / 2;
    final isEnglish = AppLocalizations.of(context).localeName == 'en';

    targets.add(TargetFocus(
      identify: "1",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem - (widthOffset + 5), height - 45)
              : Offset(width - widthOffset, height - 48)),
      color: Colors.purple,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).home,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).homeCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "2",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem * 2 - (widthOffset + 18), height - 48)
              : Offset(widthPerItem * 4 - (widthOffset - 6), height - 48)),
      color: Colors.blue,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).tasks,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).tasksCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "3",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem * 3 - (widthOffset + 52), height - 48)
              : Offset(widthPerItem * 3 - (widthOffset - 33), height - 48)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).inviteFriend,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).inviteFriendsCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "4",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem * 4 - (widthOffset + 50), height - 48)
              : Offset(widthPerItem * 2 - (widthOffset - 46), height - 48)),
      color: const Color(0xFFDE608F),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).yourWallet,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).yourWalletCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "0",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(width - (widthOffset + 95), height - 48)
              : Offset(widthPerItem - (widthOffset - 100), height - 48)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).yourProfile,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).yourProfileCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    // targets.add(TargetFocus(
    //   identify: "0",
    //   radius: 54,
    //   targetPosition: TargetPosition(
    //       const Size(16, 16),
    //       isEnglish
    //           ? Offset(width - (widthOffset + 24), height - 42)
    //           : Offset(widthPerItem - (widthOffset - 105), height - 42)),
    //   contents: [
    //     ContentTarget(
    //         align: AlignContent.top,
    //         child: Column(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 20.0),
    //               child: Text(
    //                 AppLocalizations.of(context).yourProfile,
    //                 style: const TextStyle(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 20.0),
    //               ),
    //             ),
    //             Text(
    //               AppLocalizations.of(context).yourProfileCoach,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           ],
    //         ))
    //   ],
    //   shape: ShapeLightFocus.Circle,
    // ));
  }

  void initTargets2() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widthPerItem = width / 4;
    final widthOffset = widthPerItem / 2;
    final isEnglish = AppLocalizations.of(context).localeName == 'en';

    targets.add(TargetFocus(
      identify: "1",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem - (widthOffset + 1), height - 48)
              : Offset(width - widthOffset - 10, height - 48)),
      color: Colors.blue,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).tasks,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).tasksCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "2",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem * 2 - (widthOffset + 40), height - 48)
              : Offset(widthPerItem * 3 - (widthOffset - 20), height - 48)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).inviteFriend,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).inviteFriendsCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "3",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(widthPerItem * 3 - (widthOffset + 50), height - 48)
              : Offset(widthPerItem * 2 - (widthOffset - 40), height - 48)),
      color: const Color(0xFFDE608F),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).yourWallet,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).yourWalletCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "0",
      radius: 54,
      targetPosition: TargetPosition(
          const Size(16, 16),
          isEnglish
              ? Offset(width - (widthOffset + 95), height - 48)
              : Offset(widthPerItem - (widthOffset - 100), height - 48)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context).yourProfile,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).yourProfileCoach,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    // targets.add(TargetFocus(
    //   identify: "0",
    //   radius: 54,
    //   targetPosition: TargetPosition(
    //       const Size(16, 16),
    //       isEnglish
    //           ? Offset(width - (widthOffset + 24), height - 42)
    //           : Offset(widthPerItem - (widthOffset - 105), height - 42)),
    //   contents: [
    //     ContentTarget(
    //         align: AlignContent.top,
    //         child: Column(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 20.0),
    //               child: Text(
    //                 AppLocalizations.of(context).yourProfile,
    //                 style: const TextStyle(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 20.0),
    //               ),
    //             ),
    //             Text(
    //               AppLocalizations.of(context).yourProfileCoach,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           ],
    //         ))
    //   ],
    //   shape: ShapeLightFocus.Circle,
    // ));
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      alignSkip: Alignment.topRight,
      textSkip: AppLocalizations.of(context).skip,
      targets: targets,
      colorShadow: Colors.red,
      onFinish: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(savedShowCoachKey, false);
      },
      onClickTarget: (target) {
        _navigateToPage(int.parse(target.identify as String));
      },
      onClickSkip: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(savedShowCoachKey, false);
      },
    )..show();
  }

  Future<void> _afterLayout(_) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final getCountry =
        Provider.of<ChangeCountryIpProvider>(context, listen: false);
    if (!prefs.containsKey(savedShowCoachKey) ||
        prefs.getBool(savedShowCoachKey)) {
      getCountry.countryName == "SA" ? initTargets() : initTargets2();
      showTutorial();
    }
  }
}
