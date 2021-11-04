import 'dart:io';
import 'dart:math' as math;

import 'package:adoodlz/blocs/models/gift.dart';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/gifts_provider.dart';
import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/custom_bottom_navbar.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/image_loader.dart';
import 'package:adoodlz/ui/widgets/success_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GiftDetailsScreen extends StatefulWidget {
  final Gift gift;
  // ignore: avoid_field_initializers_in_const_classes
  //final whatsUrl = "https://wa.me/966580495019?text=verify";
  const GiftDetailsScreen({Key key, this.gift}) : super(key: key);

  @override
  _GiftDetailsScreenState createState() => _GiftDetailsScreenState();
}

class _GiftDetailsScreenState extends State<GiftDetailsScreen> {
  bool loading;
  @override
  void initState() {
    loading = false;
    super.initState();
  }

  void clickableUrl() {
    launch('https://wa.me/966580495019?text=verify');
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocalizations.of(context).localeName == 'ar';

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.43,
                                  // MediaQuery.of(context).size.height / 2.8 +
                                  //     MediaQuery.of(context).viewPadding.top,
                                  width: double.infinity,
                                  child: ImageLoader(url: widget.gift.image)),
                              const SizedBox(
                                height: 55.0,
                              ),
                            ],
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height / 2 - 90,
                              left: 8,
                              right: 8,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Consumer<AuthProvider>(
                                          builder: (context, provider, _) =>
                                              Text(
                                                  provider.user.balance == null
                                                      ? '0'
                                                      : provider.user.balance
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      .copyWith(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            AppLocalizations.of(context).points,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    color:
                                                        const Color(0xFF171717),
                                                    fontSize: 15.0)),
                                        const Spacer(),
                                        Consumer<AuthProvider>(
                                          builder: (context, provider, _) =>
                                              RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: provider.user.balance ==
                                                        null
                                                    ? '0'
                                                    : NumberFormat.simpleCurrency(
                                                            name: '',
                                                            locale:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .localeName)
                                                        .format(provider
                                                                .user.balance /
                                                            10),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    .copyWith(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              ),
                                              TextSpan(
                                                text: ' EGP',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    ),
                                              )
                                            ]),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          // Positioned(
                          //   top: 32,
                          //   right: 16,
                          //   child: IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       LineAwesomeIcons.alternate_share,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            top: 32,
                            left: 16,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                isArabic
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.gift.details,
                          // 'ssssssssssssssssssssssssssssssssssssssssssssssdddddddddddddddddddddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssssssssssssdddddddddddddddddddddddddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssddddddddddddddddddddddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssssssssdddddddddddddddddddddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssssssssssssdddddddddddddddddddddddddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssdddddddddddddddddddddddddddddddddddddddd',
                          //    overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomRaisedButton(
                              onPressed: () async {
                                // int test2=DateTime.now().millisecondsSinceEpoch.toInt();
                                // print(test2);
                                // print(test2%1000);
                                if (!loading) {
                                  setState(() {
                                    loading = true;
                                  });
                                  final authProvider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  final String userId =
                                      authProvider.tokenData['id'].toString();
                                  try {
                                    if (authProvider.user.status == 'pending') {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .processFailure),
                                                actionsPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                actions: [
                                                  CustomRaisedButton(
                                                    onPressed: () async {
                                                      // if (await canLaunch(
                                                      //     "https://wa.me/966580495019?text=verify")) {
                                                      //   await launch(
                                                      //       "https://wa.me/966580495019?text=verify");
                                                      // }
                                                      //                   Navigator.of(context)
                                                      //                       .pushReplacementNamed(
                                                      //                     Routes.verifyAccountPage,
                                                      //                      arguments: <String, dynamic>{
                                                      //   'number': authProvider.user.mobile,
                                                      //   '_id': id,
                                                      //   'resetPassword': false,
                                                      // }
                                                      //);
                                                      try {
                                                        final id = await Provider
                                                                .of<AuthApi>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            //.toString();
                                                            .sendOtp(
                                                                authProvider
                                                                    .user
                                                                    .mobile);
                                                        if (id != null ||
                                                            id.isEmpty) {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  Routes
                                                                      .verifyAccountPage,
                                                                  arguments: <
                                                                      String,
                                                                      dynamic>{
                                                                'number':
                                                                    authProvider
                                                                        .user
                                                                        .mobile,
                                                                '_id': id,
                                                                'resetPassword':
                                                                    false,
                                                              }).then((value) {
                                                            setState(() {});
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
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: Text(
                                                                            AppLocalizations.of(context).processFailure),
                                                                        content:
                                                                            Text(AppLocalizations.of(context).somethingWentWrong),
                                                                      ));
                                                        }
                                                      } catch (e) {
                                                        debugPrint(
                                                            (e as DioError)
                                                                .response
                                                                .data
                                                                .toString());
                                                        debugPrint(
                                                            "Error Here Catch");
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          AppLocalizations.of(context)
                                                                              .processFailure),
                                                                      content: Text(
                                                                          AppLocalizations.of(context)
                                                                              .somethingWentWrong),
                                                                    ));
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)
                                                        .verifyAccountAgain,
                                                    width: 120.0,
                                                    //width: MediaQuery.of(context).size.width,
                                                  ),
                                                ],
                                                content: Text(
                                                    AppLocalizations.of(context)
                                                        .notVerfied2),
                                              ));
                                      setState(() {
                                        loading = false;
                                      });
                                    } else if (authProvider.user.balance >=
                                        int.parse(widget.gift.points)) {
                                      final bool success = await Provider.of<
                                                  GiftsProvider>(context,
                                              listen: false)
                                          .useGift(
                                              widget.gift.id.toString(),
                                              userId,
                                              int.parse(widget.gift.points));
                                      if (success) {
                                        authProvider.updateUserData();
                                        setState(() {
                                          loading = false;
                                        });

                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const SuccessDialog(
                                                  isGift: true,
                                                ));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .processFailure),
                                                  content: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .somethingWentWrong),
                                                ));
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .processFailure),
                                                content: Text(
                                                    AppLocalizations.of(context)
                                                        .insufficientBalance),
                                              ));
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .processFailure),
                                              content: Text(
                                                  AppLocalizations.of(context)
                                                      .somethingWentWrong),
                                            ));
                                    // print('some errrrrors');
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              //MediaQuery.of(context).size.height * 0.5,
                              height: 38,
                              loading: loading,
                              lightFont: true,
                              label:
                                  AppLocalizations.of(context).completeProcess),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        OutlineButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(
                                      LineAwesomeIcons.share,
                                      color: Theme.of(context).primaryColor,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).returnPage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
