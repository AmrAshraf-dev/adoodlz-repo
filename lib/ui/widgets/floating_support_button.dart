import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: Padding(
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
                          iconSize: 48,
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
                          iconSize: 48,
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
                ));
      },
      child: const Icon(Icons.support_agent,color: Colors.white,),
    );
  }
}
