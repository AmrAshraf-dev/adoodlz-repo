import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VisitLinkDialog extends StatelessWidget {
  const VisitLinkDialog({Key key, this.isGift = false}) : super(key: key);
  final bool isGift;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FontAwesomeIcons.checkCircle, color: Colors.green),
            const SizedBox(
              height: 16,
            ),
            Text(
              isGift
                  ? AppLocalizations.of(context).giftUsageSucces
                  : AppLocalizations.of(context).linkVisit,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
