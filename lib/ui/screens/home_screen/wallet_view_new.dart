import 'package:adoodlz/blocs/models/gift.dart';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/gifts_provider.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WalletViewNew extends StatefulWidget {
  @override
  _WalletViewNewState createState() => _WalletViewNewState();
}

class _WalletViewNewState extends State<WalletViewNew> {
  final double _cardHeight = 200.0;
  bool loading;

  final ScrollController myScrollWorks = ScrollController();

  final scrollController = ScrollController(initialScrollOffset: 50);
  @override
  void initState() {
    super.initState();
    loading = false;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GiftsProvider>(context, listen: false).getGifts();
      Provider.of<AuthProvider>(context, listen: false).updateUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            AppLocalizations.of(context).yourWallet.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            height: _cardHeight,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: sized_box_for_whitespace
                  Column(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, provider, _) =>
                            CircularStepProgressIndicator(
                          totalSteps: 500,
                          currentStep: provider.user.balance,
                          stepSize: 5,
                          unselectedColor: Colors.grey[200],
                          selectedColor: const Color(0xFFDE608F),
                          padding: 0,
                          width: 100,
                          height: 100,
                          selectedStepSize: 5,
                          child: Center(
                            child: provider.updatingUser
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    provider.user.balance == null
                                        ? '0'
                                        : provider.user.balance.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Text(
                          AppLocalizations.of(context).totalPoints,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Color(0xFFCCDCDC),
                    thickness: 3.0,
                    endIndent: 80.0,
                  ),
                  Column(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, provider, _) =>
                            CircularStepProgressIndicator(
                          totalSteps: 500,
                          stepSize: 5,
                          currentStep: (provider.user.waitBalance != null &&
                                  provider.user.waitBalance >= 0)
                              ? provider.user.waitBalance
                              : 0,
                          unselectedColor: Colors.grey[200],
                          padding: 0,
                          width: 100,
                          height: 100,
                          selectedColor: const Color(0xFFDE608F),
                          selectedStepSize: 5,
                          child: Center(
                            child: provider.updatingUser
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    provider.user.waitBalance == null
                                        ? '0'
                                        : provider.user.waitBalance.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Text(
                          AppLocalizations.of(context).waitingBalance,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Consumer<GiftsProvider>(
                builder: (context, provider, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15.0),
                    child: provider.loading
                        // ignore: avoid_unnecessary_containers
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.2),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : provider.gifts != null
                            // ignore: avoid_unnecessary_containers
                            ? Container(
                                //height: MediaQuery.of(context).size.height * 0.42,
                                height:
                                    AppLocalizations.of(context).localeName ==
                                            'ar'
                                        ? (MediaQuery.of(context).size.height *
                                                0.7) -
                                            _cardHeight
                                        : (MediaQuery.of(context).size.height *
                                                0.69) -
                                            _cardHeight,
                                child: RawScrollbar(
                                  controller: scrollController,
                                  thumbColor:
                                      const Color.fromRGBO(220, 107, 150, 0.45),
                                  isAlwaysShown: true,
                                  thickness: 7,
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Wrap(
                                      runSpacing: 10.0,
                                      spacing: 12,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: provider.gifts
                                          .map<GiftCard>(
                                              (gift) => GiftCard(gift: gift))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GiftCard extends StatelessWidget {
  const GiftCard({Key key, @required this.gift}) : super(key: key);
  final Gift gift;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.giftDetailsScreen, arguments: gift)
            .then((value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<GiftsProvider>(context, listen: false).getGifts();
            Provider.of<AuthProvider>(context, listen: false).updateUserData();
          });
        });
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3 - 20,
            maxHeight: 120),
        child: Stack(
          children: [
            Card(
              elevation: 7,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                // BorderRadius.all(Radius.circular(62)),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        child: SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ImageLoader(url: gift.image)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          //margin: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //const Icon(LineAwesomeIcons.coins, color: textColor),
                              Image.asset(
                                'assets/images/diamond.png',
                                color: Colors.black,
                                width: 20,
                                height: 15,
                              ),
                              //const SizedBox(width: 4),
                              Text(gift.points,
                                  style: Theme.of(context).textTheme.caption),
                              //const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDE608F),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                        //     BorderRadius.all(
                        //   Radius.circular(12.0),
                        // ),
                      ),
                      child: Text(
                        AppLocalizations.of(context).claimNow,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
