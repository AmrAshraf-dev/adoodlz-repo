import 'dart:io';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/ui/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocalizations.of(context).localeName == 'ar';

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            AppLocalizations.of(context).aboutUs,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0,),
          // ignore: sized_box_for_whitespace
          Container(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.asset(
                  'assets/images/aboutUs.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15.0,),
                    Text(
                      AppLocalizations.of(context).aboutApp,
                      style: const TextStyle(
                        height: 2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
