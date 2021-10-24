// import 'package:adoodlz/blocs/providers/auth_provider.dart';
// import 'package:adoodlz/blocs/providers/gifts_provider.dart';
// import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
// import 'package:adoodlz/ui/widgets/success_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';

// class GetCash extends StatefulWidget {
//   @override
//   _GetCashState createState() => _GetCashState();
// }

// class _GetCashState extends State<GetCash> {
//   bool loading;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loading = false;
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<GiftsProvider>(context, listen: false).getGifts();
//       Provider.of<AuthProvider>(context, listen: false).updateUserData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.3,
//           ),
//           Center(
//             child: Text(
//               AppLocalizations.of(context).yourWallet.toUpperCase(),
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.1,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             child: CustomRaisedButton(
//               onPressed: () async {
//                 /// jjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhhh
//                 if (!loading) {
//                   setState(() {
//                     loading = true;
//                   });
//                   final authProvider =
//                       Provider.of<AuthProvider>(context, listen: false);
//                   final String userId = authProvider.tokenData['id'].toString();
//                   try {
//                     if (authProvider.user.balance >= 500) {
//                       final bool success = await Provider.of<GiftsProvider>(
//                               context,
//                               listen: false)
//                           .useGift("999", userId, authProvider.user.balance);
//                       if (success) {
//                         authProvider.updateUserData();
//                         setState(() {
//                           loading = false;
//                         });

//                         showDialog(
//                             context: context,
//                             builder: (context) =>
//                                 const SuccessDialog(isGift: true));
//                       } else {
//                         showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                                   title: Text(AppLocalizations.of(context)
//                                       .processFailure),
//                                   content: Text(AppLocalizations.of(context)
//                                       .somethingWentWrong),
//                                 ));
//                         setState(() {
//                           loading = false;
//                         });
//                       }
//                     } else {
//                       showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                                 title: Text(AppLocalizations.of(context)
//                                     .processFailure),
//                                 content: Text(AppLocalizations.of(context)
//                                     .insufficientBalance),
//                               ));
//                       setState(() {
//                         loading = false;
//                       });
//                     }
//                   } catch (e) {
//                     showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                               title: Text(
//                                   AppLocalizations.of(context).processFailure),
//                               content: Text(AppLocalizations.of(context)
//                                   .somethingWentWrong),
//                             ));
//                     setState(() {
//                       loading = false;
//                     });
//                   }
//                 }
//                 //Navigator.of(context).pushNamed(Routes.getcash);
//               },
//               // leading: const Icon(LineAwesomeIcons.coins, color: Colors.white),
//               leading: Image.asset(
//                 'assets/images/diamond.png',
//                 color: Colors.white,
//                 width: 20,
//                 height: 20,
//               ),
//               label: AppLocalizations.of(context).getCashHere,
//             ),
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//         ],
//       ),
//     );
//   }
// }
