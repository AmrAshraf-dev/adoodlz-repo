// ignore_for_file: sort_child_properties_last

import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/data/remote/apis/hits_api.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adoodlz/helpers/ui/ui_helpers.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class InviteFriendView extends StatefulWidget {
  const InviteFriendView();

  @override
  _InviteFriendViewState createState() => _InviteFriendViewState();
}

class _InviteFriendViewState extends State<InviteFriendView> {
  TextEditingController _controller;
  String text = ""; // empty string to carry what was there before it onChanged
  int maxLength = 4;
  bool loading;
  Post post;

  @override
  void initState() {
    loading = false;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .inviteContacts
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                'assets/images/badge3.png',
                                height: 110,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  child: Consumer<AuthProvider>(
                                    builder: (context, provider, _) => Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 28,
                                          ),
                                          const Text(
                                            'Your code',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            provider.user.id.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/referral_new.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              AppLocalizations.of(context)
                                  .inviteFriendIncentive,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.termsScreen);
                            },
                            child: Text(
                              AppLocalizations.of(context).termsAndConditions,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomRaisedButton(
                            onPressed: () async {
                              Share.share(AppLocalizations.of(context)
                                  .inviteFriendPrompt(Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .id
                                      .toString()));
                              // final userId =
                              //     Provider.of<AuthProvider>(context, listen: false)
                              //         .user
                              //         .id;
                              // Provider.of<PostsProvider>(context, listen: false)
                              //     .sharePostData(widget.post, userId);
                            },
                            label: AppLocalizations.of(context).inviteContacts,
                            lightFont: true,
                          ),
                          UIHelper.verticalSpaceMedium(),
                          Divider(
                            indent: 5.0,
                            endIndent: 5.0,
                            color: const Color(0xFF707070).withOpacity(0.4),
                          ),
                          UIHelper.verticalSpaceMedium(),
                          Consumer<AuthProvider>(
                            builder: (context, provider, _) =>
                                provider.user.affiliaterId == null
                                    ? Text(
                                        AppLocalizations.of(context)
                                            .shareAccountLink,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                      )
                                    : Container(),
                          ),
                          UIHelper.verticalSpaceMedium(),
                          Consumer<AuthProvider>(
                            builder: (context, provider, _) => provider
                                        .user.affiliaterId ==
                                    null
                                ? Row(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 45,
                                          // margin: AppLocalizations.of(context)
                                          //             .localeName ==
                                          //         'ar'
                                          //     ? const EdgeInsets.only(right: 45.0)
                                          //     : const EdgeInsets.only(left: 45.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                AppLocalizations.of(context)
                                                            .localeName ==
                                                        'ar'
                                                    ? const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5),
                                                      )
                                                    : const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(5)),
                                            border: Border.all(
                                                color: const Color(0xFF707070)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 16),
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    4),
                                              ],
                                              maxLines: 1,
                                              controller: _controller,
                                              // onChanged: (String newVal) {
                                              //   if (newVal.length <= maxLength) {
                                              //     text = newVal;
                                              //   } else {
                                              //     _controller.text = text;
                                              //     showDialog(
                                              //         context: context,
                                              //         builder: (context) => AlertDialog(
                                              //               title: Text(
                                              //                   AppLocalizations.of(context)
                                              //                       .processFailure),
                                              //               content: Text(
                                              //                   AppLocalizations.of(context)
                                              //                       .somethingWentWrong),
                                              //             ));
                                              //   }
                                              // },
                                              decoration: InputDecoration(
                                                hintText:
                                                    AppLocalizations.of(context)
                                                        .enterCode,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                        fontSize: 14,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      CustomRaisedButton(
                                        onPressed: () async {
                                          if (!loading) {
                                            setState(() {
                                              loading = true;
                                            });
                                            try {
                                              final authProvider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              debugPrint(authProvider.user
                                                  .toJson()
                                                  .toString());

                                              final affiliaterId =
                                                  _controller.text;
                                              if (affiliaterId ==
                                                  provider.tokenData['id']
                                                      .toString()) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .processFailure),
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .invitePersonCode),
                                                        ));
                                              }

                                              final proccessSuccess =
                                                  await Provider.of<HitsApi>(
                                                          context,
                                                          listen: false)
                                                      .recordHit(null,
                                                          affiliaterId:
                                                              affiliaterId,
                                                          affiliatedId:
                                                              authProvider
                                                                  .tokenData[
                                                                      'id']
                                                                  .toString());
                                              if (proccessSuccess) {
                                                await authProvider
                                                    .updateUserData();
                                                setState(() {});
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .processFailure),
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .somethingWentWrong),
                                                        ));
                                              }

                                              setState(() {
                                                loading = false;
                                              });
                                            } catch (e) {
                                              debugPrint(e.toString());
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
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
                                          }
                                        },
                                        label:
                                            AppLocalizations.of(context).send,
                                        loading: loading,
                                        width: 70,
                                        //height: 47,
                                        borderRadius: AppLocalizations.of(
                                                        context)
                                                    .localeName ==
                                                'ar'
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                bottomLeft: Radius.circular(6))
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(6),
                                                bottomRight:
                                                    Radius.circular(6)),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .pointsAlreadyClaimed,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                          ),
                          UIHelper.verticalSpaceMedium(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // child: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const SizedBox(
        //         height: 40,
        //       ),
        //       Text(
        //         AppLocalizations.of(context).inviteContacts.toUpperCase(),
        //         style: Theme.of(context).textTheme.headline5,
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Center(
        //         child: Image.asset(
        //           'assets/images/referral_new.png',
        //           height: MediaQuery.of(context).size.height * 0.2,
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             Text(AppLocalizations.of(context).inviteFriendIncentive,
        //                 textAlign: TextAlign.center,
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .headline5
        //                     .copyWith(fontWeight: FontWeight.w600)),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 Navigator.of(context).pushNamed(Routes.termsScreen);
        //               },
        //               child: Text(
        //                 AppLocalizations.of(context).termsAndConditions,
        //                 textAlign: TextAlign.center,
        //                 style: Theme.of(context).textTheme.headline6.copyWith(
        //                     decoration: TextDecoration.underline,
        //                     color: Colors.blue),
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 20,
        //             ),
        //             CustomRaisedButton(
        //               onPressed: () async {
        //                 Share.share(AppLocalizations.of(context)
        //                     .inviteFriendPrompt(Provider.of<AuthProvider>(
        //                             context,
        //                             listen: false)
        //                         .user
        //                         .id
        //                         .toString()));
        //                 // final userId =
        //                 //     Provider.of<AuthProvider>(context, listen: false)
        //                 //         .user
        //                 //         .id;
        //                 // Provider.of<PostsProvider>(context, listen: false)
        //                 //     .sharePostData(widget.post, userId);
        //               },
        //               label: AppLocalizations.of(context).inviteContacts,
        //               lightFont: true,
        //             ),
        //             UIHelper.verticalSpaceMedium(),
        //             Divider(
        //               indent: 5.0,
        //               endIndent: 5.0,
        //               color: const Color(0xFF707070).withOpacity(0.4),
        //             ),
        //             UIHelper.verticalSpaceMedium(),
        //             Consumer<AuthProvider>(
        //                 builder: (context, provider, _) => provider
        //                     .user.affiliaterId ==
        //                     null? Text(
        //                 AppLocalizations.of(context).shareAccountLink,
        //                 style: Theme.of(context).textTheme.headline6.copyWith(
        //                     color: Colors.black, fontWeight: FontWeight.w500),
        //               ):Container(),
        //             ),
        //             UIHelper.verticalSpaceMedium(),
        //             Consumer<AuthProvider>(
        //               builder: (context, provider, _) => provider
        //                           .user.affiliaterId ==
        //                       null
        //                   ? Row(
        //                       children: [
        //                         Flexible(
        //                           child: Container(
        //                             height: 45,
        //                             // margin: AppLocalizations.of(context)
        //                             //             .localeName ==
        //                             //         'ar'
        //                             //     ? const EdgeInsets.only(right: 45.0)
        //                             //     : const EdgeInsets.only(left: 45.0),
        //                             decoration: BoxDecoration(
        //                               borderRadius: AppLocalizations.of(context)
        //                                           .localeName ==
        //                                       'ar'
        //                                   ? const BorderRadius.only(
        //                                       bottomRight: Radius.circular(5),
        //                                       topRight: Radius.circular(5),
        //                                     )
        //                                   : const BorderRadius.only(
        //                                       bottomLeft: Radius.circular(5),
        //                                       topLeft: Radius.circular(5)),
        //                               border: Border.all(
        //                                   color: const Color(0xFF707070)),
        //                             ),
        //                             child: Padding(
        //                               padding: const EdgeInsets.symmetric(
        //                                   vertical: 7, horizontal: 16),
        //                               child: TextFormField(
        //                                 inputFormatters: [
        //                                   LengthLimitingTextInputFormatter(4),
        //                                 ],
        //                                 maxLines: 1,
        //                                 controller: _controller,
        //                                 // onChanged: (String newVal) {
        //                                 //   if (newVal.length <= maxLength) {
        //                                 //     text = newVal;
        //                                 //   } else {
        //                                 //     _controller.text = text;
        //                                 //     showDialog(
        //                                 //         context: context,
        //                                 //         builder: (context) => AlertDialog(
        //                                 //               title: Text(
        //                                 //                   AppLocalizations.of(context)
        //                                 //                       .processFailure),
        //                                 //               content: Text(
        //                                 //                   AppLocalizations.of(context)
        //                                 //                       .somethingWentWrong),
        //                                 //             ));
        //                                 //   }
        //                                 // },
        //                                 decoration: InputDecoration(
        //                                   hintText: AppLocalizations.of(context)
        //                                       .enterCode,
        //                                   hintStyle: Theme.of(context)
        //                                       .textTheme
        //                                       .subtitle2
        //                                       .copyWith(
        //                                           fontSize: 14,
        //                                           decoration:
        //                                               TextDecoration.none),
        //                                   border: InputBorder.none,
        //                                   focusedBorder: InputBorder.none,
        //                                   enabledBorder: InputBorder.none,
        //                                   errorBorder: InputBorder.none,
        //                                   disabledBorder: InputBorder.none,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                         CustomRaisedButton(
        //                           onPressed: () async {
        //                             if (!loading) {
        //                               setState(() {
        //                                 loading = true;
        //                               });
        //                               try {
        //                                 final authProvider =
        //                                     Provider.of<AuthProvider>(context,
        //                                         listen: false);
        //                                 debugPrint(authProvider.user
        //                                     .toJson()
        //                                     .toString());
        //
        //                                 final affiliaterId = _controller.text;
        //                                 if (affiliaterId ==
        //                                     provider.tokenData['id']
        //                                         .toString()) {
        //                                   showDialog(
        //                                       context: context,
        //                                       builder: (context) => AlertDialog(
        //                                             title: Text(
        //                                                 AppLocalizations.of(
        //                                                         context)
        //                                                     .processFailure),
        //                                             content: Text(
        //                                                 AppLocalizations.of(
        //                                                         context)
        //                                                     .invitePersonCode
        //                                                 //'ادخل كود الشخص الذي قام بدعوتك'
        //                                                 ),
        //                                           ));
        //                                 }
        //
        //                                 final proccessSuccess =
        //                                     await Provider.of<HitsApi>(context,
        //                                             listen: false)
        //                                         .recordHit(null,
        //                                             affiliaterId: affiliaterId,
        //                                             affiliatedId: authProvider
        //                                                 .tokenData['id']
        //                                                 .toString());
        //                                 if (proccessSuccess) {
        //                                   await authProvider.updateUserData();
        //                                   setState(() {});
        //                                 } else {
        //                                   showDialog(
        //                                       context: context,
        //                                       builder: (context) => AlertDialog(
        //                                             title: Text(
        //                                                 AppLocalizations.of(
        //                                                         context)
        //                                                     .processFailure),
        //                                             content: Text(
        //                                                 AppLocalizations.of(
        //                                                         context)
        //                                                     .somethingWentWrong),
        //                                           ));
        //                                 }
        //
        //                                 setState(() {
        //                                   loading = false;
        //                                 });
        //                               } catch (e) {
        //                                 debugPrint(e.toString());
        //                                 showDialog(
        //                                     context: context,
        //                                     builder: (context) => AlertDialog(
        //                                           title: Text(
        //                                               AppLocalizations.of(
        //                                                       context)
        //                                                   .processFailure),
        //                                           content: Text(
        //                                               AppLocalizations.of(
        //                                                       context)
        //                                                   .somethingWentWrong),
        //                                         ));
        //
        //                                 setState(() {
        //                                   loading = false;
        //                                 });
        //                               }
        //                             }
        //                           },
        //                           label: AppLocalizations.of(context).send,
        //                           loading: loading,
        //                           width: 70,
        //                           //height: 47,
        //                           borderRadius:
        //                               AppLocalizations.of(context).localeName ==
        //                                       'ar'
        //                                   ? const BorderRadius.only(
        //                                       topLeft: Radius.circular(6),
        //                                       bottomLeft: Radius.circular(6))
        //                                   : const BorderRadius.only(
        //                                       topRight: Radius.circular(6),
        //                                       bottomRight: Radius.circular(6)),
        //                         ),
        //                       ],
        //                     )
        //                   : Padding(
        //                       padding: const EdgeInsets.only(top: 16.0),
        //                       child: Text(
        //                         AppLocalizations.of(context)
        //                             .pointsAlreadyClaimed,
        //                         style: Theme.of(context).textTheme.headline6,
        //                       ),
        //                     ),
        //             ),
        //             UIHelper.verticalSpaceMedium(),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
