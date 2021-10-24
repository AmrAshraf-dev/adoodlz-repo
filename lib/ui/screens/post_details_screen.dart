import 'dart:io';
import 'dart:ui';

import 'package:adoodlz/blocs/models/goal.dart';
import 'package:adoodlz/blocs/models/hit.dart';
import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/blocs/models/source.dart';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/data/remote/apis/hits_api.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart';
import 'package:adoodlz/helpers/helper_methods.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/ui/widgets/custom_bottom_navbar.dart';
import 'package:adoodlz/ui/widgets/custom_raised_button.dart';
import 'package:adoodlz/ui/widgets/image_loader.dart';
import 'package:adoodlz/ui/widgets/visit_link_dialog.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_slider/image_slider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:adoodlz/blocs/providers/posts_provider.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({Key key, this.post}) : super(key: key);

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController _tabController;
  Map<String, dynamic> dataUser;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.post.media.length, vsync: this);
    getInfoUser();
  }

  Future<void> sharePost(Goal shareGoal) async {
    final userId = Provider.of<AuthProvider>(context, listen: false).user.id;
    await Provider.of<PostsProvider>(context, listen: false)
        .sharePostData(widget.post, userId);
    if (shareGoal != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final hit = Hit(
          userId: authProvider.tokenData['_id'] as String,
          corpId: widget.post.corpId,
          postId: widget.post.id.toString(),
          goal: shareGoal,
          source: Source(
            ip: dataUser['ip'].toString(),
            country: dataUser['country'].toString(),
            city: dataUser['city'].toString(),
            device: dataUser['device'].toString(),
            os: dataUser['os'].toString(),
            resolution: dataUser['resolution'].toString(),

          ),
          status: "pending");
      final success =
          await Provider.of<HitsApi>(context, listen: false).recordHit(hit);
      if (success) {
        showDialog(
            context: context, builder: (context) => const VisitLinkDialog());
      }
    }
  }

  Future<void> getInfoUser() async {
    final _deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final ipv4 = await Ipify.ipv4();
      final ipData = await Dio().get(ipUrl);
      if (ipData.statusCode == 200) {
        if (Platform.isAndroid) {
          final info = await _deviceInfoPlugin.androidInfo;
          dataUser = {
            'ip': ipv4,
            'country': ipData.data['country'],
            'city': ipData.data['city'],
            'device': '${info.manufacturer} - ${info.model}',
            'os': 'Android ${info.version.release} ',
            'resolution':'${window.physicalSize.width} X ${window.physicalSize.height}',
          };
        } else if (Platform.isIOS) {
          final info = await _deviceInfoPlugin.iosInfo;
          dataUser = {
            'ip': ipv4,
            'country': ipData.data['country'],
            'city': ipData.data['city'],
            'device': '${info.name} ${info.model}',
            'os': info.systemName,
            'resolution':'${window.physicalSize.width} X ${window.physicalSize.height}',
          };
        } else {
          throw UnimplementedError();
        }

        print(dataUser.toString());
      } else {
        throw Exception('Failed to get user country from IP address');
      }
    } catch (err) {
      //handleError
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocalizations.of(context).localeName == 'ar';
    final Goal shareGoal = widget.post.goals
        .firstWhere((goal) => goal.type == 'share', orElse: () => null);

    //print(widget.post.media.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(
                        //fit: StackFit.expand,
                        children: [
                          Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  color: textColor,
                                  child: widget.post.media.length == 1
                                      ? Hero(
                                          tag:
                                              '${widget.post.id}${widget.post.title}',
                                          child: ImageLoader(
                                              url: widget.post.media.first),
                                        )
                                      : ImageSlider(
                                          showTabIndicator: true,
                                          tabIndicatorHeight: 68,
                                          tabIndicatorSelectedColor:
                                              Theme.of(context).accentColor,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          tabController: _tabController,
                                          children: widget.post.media
                                              .map<ImageLoader>(
                                                  (e) => ImageLoader(url: e))
                                              .toList(),
                                        )),
                              const SizedBox(
                                height: 54,
                              ),
                            ],
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height / 2 - 50,
                              left: 8,
                              right: 8,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 24.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.post.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context).tags}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Flexible(
                                            child: Wrap(
                                              spacing: 8,
                                              children: widget.post.tags
                                                  .take(3)
                                                  .map<Chip>((e) => Chip(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      label: Text(e,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .white))))
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context).status}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            color: getStatusColor(
                                                widget.post.status),
                                            size: 12,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(widget.post.status,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300)),
                                          const Spacer(),
                                          if (widget.post.expireAt != null)
                                            Chip(
                                              backgroundColor:
                                                  const Color(0xFFFAFAFA),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        LineAwesomeIcons.clock,
                                                        color: textColor),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                        getTimeTillExpire(widget
                                                            .post.expireAt),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption)
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Positioned(
                            right: 16,
                            top: 32,
                            child: Builder(
                              builder: (context) => IconButton(
                                onPressed: () async {
                                  sharePost(shareGoal);
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.alternate_share,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 32,
                            left: 16,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: Icon(
                                  Platform.isIOS
                                      ? isArabic
                                          ? Icons.arrow_forward_ios
                                          : Icons.arrow_back_ios
                                      : isArabic
                                          ? Icons.arrow_forward
                                          : Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          widget.post.content,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(height: 1.5),
                          textAlign: isRTL(widget.post.content)
                              ? TextAlign.right
                              : TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Builder(
                            builder: (context) => CustomRaisedButton(
                                onPressed: () {
                                  sharePost(shareGoal);
                                },
                                height: 38,
                                leading: const Icon(
                                  LineAwesomeIcons.alternate_share,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                lightFont: true,
                                label: AppLocalizations.of(context).share),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        if (shareGoal != null)
                          Flexible(
                            flex: 4,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LineAwesomeIcons.coins,
                                        color: Theme.of(context).primaryColor,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${shareGoal.pointsIn} ${AppLocalizations.of(context).points}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

Color getStatusColor(String status) {
  if (status.toLowerCase() == 'active') {
    return const Color(0xFF30E53C);
  } else if (status.toLowerCase() == 'pending') {
    return const Color(0xFFE5B530);
  } else {
    return const Color(0xFFE53030);
  }
}
