import 'dart:async';
import 'dart:io';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/feature/tasks/ui/widgets/tasks_list_widget.dart';
import 'package:adoodlz/feature/tasks/ui/widgets/tasks_widget.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/screens/home_screen/wallet_view_new.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/helpers/ui/navigation_provider.dart';
import 'package:adoodlz/ui/screens/home_screen/invite_friend_view.dart';
import 'package:adoodlz/ui/screens/home_screen/profile_view.dart';
import 'package:adoodlz/ui/screens/home_screen/posts_view_0.dart';
import 'package:adoodlz/ui/widgets/custom_bottom_navbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> _myBackgroundMessageHandler(RemoteMessage message) async {}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  StreamSubscription tokenSubscription;
  StreamSubscription onMessageSubscription;
  // ignore: cancel_subscriptions
  StreamSubscription streamSubscription;
  //DataSnapshot dataSnapshot;
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    _fcm.requestPermission();

    onMessageSubscription = FirebaseMessaging.onMessage.listen((event) {
      _showDialog(event.notification);
    });
    FirebaseMessaging.onBackgroundMessage(_myBackgroundMessageHandler);
    forceUserLogOut();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> getTokenFireBase() async {
    final String test2 = await _fcm.getToken();
    final bool success = await Provider.of<AuthProvider>(context, listen: false)
        .addUserFireBaseToken(test2);
    if (success) {
      // ignore: avoid_print
      print('trueee');
    } else {
      // ignore: avoid_print
      print('falseeeeeee');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // ignore: avoid_print
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        setState(() {
          // ignore: avoid_print
          print('resumed');
          checkVer();
        });
        //print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        // ignore: avoid_print
        print('appLifeCycleState paused');

        break;
      case AppLifecycleState.detached:
        // ignore: avoid_print
        print('appLifeCycleState detached');
        break;
    }
  }

  @override
  void didChangeDependencies() {
    checkVer();
    getTokenFireBase();
    super.didChangeDependencies();
  }

  void checkVer() async {
    // final newVersion = NewVersion(context: context,dismissAction: (){});
    final newVersion = NewVersion(
      dialogText: AppLocalizations.of(context).dialogText,
      dialogTitle: AppLocalizations.of(context).update,
      updateText: AppLocalizations.of(context).updateAvailable,
      dismissText: AppLocalizations.of(context).maybeLater,
      iOSId: 'com.adoodlz.app',
      androidId: 'com.adoodlz.app',
      context: context,
      dismissAction: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );
    newVersion.showAlertIfNecessary();
  }

  Future<void> forceUserLogOut() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false).user;
    final FirebaseDatabase database = FirebaseDatabase();

    databaseReference = database.reference();
    //final databaseReference = FirebaseDatabase.instance.reference();
    bool logged;
    streamSubscription = databaseReference
        .child('users')
        .child('${authProvider.id}')
        .child('enableLog')
        .onValue
        .listen((eventDb) async {
      logged = eventDb.snapshot.value as bool;
      if (logged == null) {
        return;
      } else if (!logged) {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Center(
                    child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        AppLocalizations.of(context).signOut,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0),
                      ),
                    ],
                  ),
                )),
              );
            });

        // ignore: avoid_print
        print('Status Logged $logged');
        await Provider.of<AuthProvider>(context, listen: false).logout();
        Provider.of<AppNavigationProvider>(context, listen: false)
            .navigatorIndex = 0;
        Navigator.of(context).pushReplacementNamed(Routes.signinScreen0);
      } else {
        // ignore: avoid_print
        print('Enable Log');
      }
    });
  }

  Future<void> _showDialog(RemoteNotification notification) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(notification.title),
              content: Text(notification.body),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final getCountry= Provider.of<ChangeCountryIpProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        final appNavProvider = context.read<AppNavigationProvider>();
        if (appNavProvider.navigatorIndex == 0) {
          return true;
        } else {
          appNavProvider.pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
          appNavProvider.navigatorIndex = 0;
          return false;
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: context.select<AppNavigationProvider, PageController>(
                (provider) => provider.pageController),
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              if(getCountry.countryName=='SA')
              const PostsView0(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
                child: TasksWidget(),
              ),
              const InviteFriendView(),
              WalletViewNew(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavBar(),
          // floatingActionButton: Selector<AppNavigationProvider, int>(
          //     selector: (_, provider) => provider.navigatorIndex,
          //     builder: (context, index, _) {
          //       return index != 0
          //           ? FloatingActionButton(
          //               onPressed: () async {
          //                 //await checkForUpdate();
          //                 //  performUpdate();
          //                 //const whatsAppUrl = 'https://api.whatsapp.com/send/?phone=966580495019&text=%D8%A7%D8%B1%D8%BA%D8%A8+%D8%A8%D9%85%D8%B3%D8%A7%D8%B9%D8%AF%D8%A9+%D9%81%D9%8A+%D8%AA%D8%B7%D8%A8%D9%8A%D9%82+%D8%A7%D8%AF%D9%88%D9%88%D8%AF%D9%84%D8%B2&app_absent=0';
          //                 const whatsAppUrl =
          //                     'https://api.whatsapp.com/send/?phone=201274913123&text=%D8%A7%D8%B1%D8%BA%D8%A8+%D8%A8%D9%85%D8%B3%D8%A7%D8%B9%D8%AF%D8%A9+%D9%81%D9%8A+%D8%AA%D8%B7%D8%A8%D9%8A%D9%82+%D8%A7%D8%AF%D9%88%D9%88%D8%AF%D9%84%D8%B2&app_absent=0';
          //                 const tawkUrl = 'https://tawk.to/adoodlz';
          //                 showDialog(
          //                     context: context,
          //                     builder: (context) => Dialog(
          //                           shape: RoundedRectangleBorder(
          //                               borderRadius:
          //                                   BorderRadius.circular(16)),
          //                           elevation: 3,
          //                           child: Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 8.0),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.min,
          //                               children: [
          //                                 const SizedBox(
          //                                   width: 36,
          //                                 ),
          //                                 IconButton(
          //                                   icon: const Icon(
          //                                       FontAwesomeIcons.whatsapp),
          //                                   color: Colors.green,
          //                                   iconSize: 48,
          //                                   onPressed: () async {
          //                                     if (await canLaunch(
          //                                         whatsAppUrl)) {
          //                                       launch(whatsAppUrl);
          //                                     }
          //                                   },
          //                                 ),
          //                                 const Spacer(),
          //                                 IconButton(
          //                                   icon: const Icon(
          //                                       FontAwesomeIcons.commentDots),
          //                                   color: Colors.blue,
          //                                   iconSize: 48,
          //                                   onPressed: () async {
          //                                     if (await canLaunch(tawkUrl)) {
          //                                       launch(tawkUrl);
          //                                     }
          //                                   },
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 36,
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ));
          //               },
          //               child: const Icon(Icons.support_agent),
          //             )
          //           : const SizedBox();
          //     }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startFloat),
    );
  }

  @override
  void dispose() {
    if (tokenSubscription != null) {
      tokenSubscription.cancel();
    }
    onMessageSubscription.cancel();
    streamSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
