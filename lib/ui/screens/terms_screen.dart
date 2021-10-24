import 'dart:async';
// import 'dart:io';

// import 'package:adoodlz/helpers/ui/app_colors.dart';
// import 'package:adoodlz/ui/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final isArabic = AppLocalizations.of(context).localeName == 'ar';
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    WebViewController _myController;
    return Scaffold(
        body: SafeArea(
      child: WebView(
        initialUrl: 'https://adoodlz.com/privacy-policy',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
          _myController = controller;
        },
        onPageFinished: (String url) {
// evaluateJavascript is a method to customize the UI, here i find searchfield class name and writing a javascript query string.
          _myController.evaluateJavascript(
              "document.getElementsByClassName(\"mkdf-mobile-menu-opener mkdf-mobile-menu-opener-icon-pack\")[0].style.display='none';");
        },
      ),
    )

        // Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           color: textColor,
        //           height: MediaQuery.of(context).size.height / 2,
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //             child: Column(
        //               children: [
        //                 const SizedBox(
        //                   height: 32,
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(
        //                       LineAwesomeIcons.alternate_share,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   height: 38,
        //                 ),
        //                 Image.asset(
        //                   'assets/images/logo.png',
        //                   fit: BoxFit.contain,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: SingleChildScrollView(
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //               child: Column(
        //                 children: [
        //                   const SizedBox(
        //                     height: 48,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         AppLocalizations.of(context).youCanViewIt,
        //                         style: Theme.of(context).textTheme.headline6,
        //                         textAlign: TextAlign.start,
        //                       ),
        //                       const SizedBox(
        //                         width: 8,
        //                       ),
        //                       GestureDetector(
        //                         onTap: () async {
        //                           const url =
        //                               'https://adoodlz.com/privacy-policy';
        //                           if (await canLaunch(url)) {
        //                             await launch(url);
        //                           } else {
        //                             throw 'Could not launch $url';
        //                           }
        //                         },
        //                         child: Text(
        //                           AppLocalizations.of(context).clickingHere,
        //                           style: Theme.of(context)
        //                               .textTheme
        //                               .headline6
        //                               .copyWith(
        //                                   decoration: TextDecoration.underline),
        //                           textAlign: TextAlign.start,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 16,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Positioned(
        //         top: MediaQuery.of(context).size.height / 2 - 38,
        //         left: 8,
        //         right: 8,
        //         child: Card(
        //           elevation: 4,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30.0)),
        //           child: Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 16.0),
        //               child: Text(
        //                 AppLocalizations.of(context)
        //                     .termsAndConditions
        //                     .toUpperCase(),
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .headline6
        //                     .copyWith(fontWeight: FontWeight.w600),
        //                 textAlign: TextAlign.center,
        //               )),
        //         )),
        //     Positioned(
        //       top: 32,
        //       left: 16,
        //       child: IconButton(
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //         icon: Icon(
        //           Platform.isIOS
        //               ? isArabic
        //                   ? Icons.arrow_forward_ios
        //                   : Icons.arrow_back_ios
        //               : isArabic
        //                   ? Icons.arrow_forward
        //                   : Icons.arrow_back,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),

        //   ],
        // ),
        // bottomNavigationBar: const CustomBottomNavBar(),
        );
  }
}
