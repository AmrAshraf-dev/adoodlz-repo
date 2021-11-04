import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportButton extends StatefulWidget {
  @override
  _SupportButtonState createState() => _SupportButtonState();
}

class _SupportButtonState extends State<SupportButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        const whatsAppUrl =
            'https://api.whatsapp.com/send/?phone=201274913123&text=%D8%A7%D8%B1%D8%BA%D8%A8+%D8%A8%D9%85%D8%B3%D8%A7%D8%B9%D8%AF%D8%A9+%D9%81%D9%8A+%D8%AA%D8%B7%D8%A8%D9%8A%D9%82+%D8%A7%D8%AF%D9%88%D9%88%D8%AF%D9%84%D8%B2&app_absent=0';
        const tawkUrl = 'https://tawk.to/adoodlz';
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Container(
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context).haveProblem.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: Text(
                          AppLocalizations.of(context)
                              .problemDescribtion
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 36,
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.whatsapp),
                          color: Colors.green,
                          iconSize: 40,
                          onPressed: () async {
                            if (await canLaunch(whatsAppUrl)) {
                              launch(whatsAppUrl);
                            }
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.commentDots),
                          color: Colors.blue,
                          iconSize: 40,
                          onPressed: () async {
                            if (await canLaunch(tawkUrl)) {
                              launch(tawkUrl);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 36,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const Icon(
        Icons.support_agent_sharp,
        color: Colors.white,
      ),
    );
  }
}
