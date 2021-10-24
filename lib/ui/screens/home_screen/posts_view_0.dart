import 'package:adoodlz/blocs/models/goal.dart';
import 'package:adoodlz/blocs/models/hit.dart';
import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/blocs/models/source.dart';
import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/posts_provider.dart';
import 'package:adoodlz/data/remote/apis/hits_api.dart';
import 'package:adoodlz/helpers/helper_methods.dart';
import 'package:adoodlz/helpers/ui/app_colors.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:adoodlz/ui/widgets/image_loader.dart';
import 'package:adoodlz/ui/widgets/visit_link_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostsView0 extends StatefulWidget {
  final Post post;
  const PostsView0({Key key, this.post}) : super(key: key);
  @override
  _PostsView0State createState() => _PostsView0State();
}

class _PostsView0State extends State<PostsView0> {
  bool isExpanded = true;
  bool isAllExpanded = false;
  double heightOfContainer = 320;
  bool isGrid = true;
  bool isList = false;
  int selectedIndex = 0;
  TextEditingController _searchController;
  List<Post> _searchPosts;

  Future<void> sharePost(Goal shareGoal) async {
    final userId = Provider.of<AuthProvider>(context, listen: false).user.id;
    await Provider.of<PostsProvider>(context, listen: false)
        .sharePostData(widget.post, userId);
    if (shareGoal != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final hit = Hit(
          userId: authProvider.tokenData['_id'] as String,
          corpId: widget.post.corpId,
          goal: shareGoal,
          source: Source(country: 'Saudi Arabia'),
          status: "pending");
      final success =
          await Provider.of<HitsApi>(context, listen: false).recordHit(hit);
      if (success) {
        showDialog(
            context: context, builder: (context) => const VisitLinkDialog());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostsProvider>(context, listen: false).getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final Goal shareGoal = widget.post.goals
    //     .firstWhere((goal) => goal.type == 'share', orElse: () => null);
    return Container(
      color: Colors.grey[200],
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Consumer<PostsProvider>(
            builder: (_, provider, __) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: isAllExpanded == true
                      ? const Color(0xff00B0D1)
                      : Colors.grey[200],
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(
                          isAllExpanded == true
                              ? Icons.keyboard_arrow_up_sharp
                              : Icons.keyboard_arrow_down_sharp,
                          color: Colors.black54,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            isAllExpanded = !isAllExpanded;
                          });
                        }),
                  ),
                ),
                Stack(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: isAllExpanded == true ? heightOfContainer : 0,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 500,
                                height: 120,
                                //height: isAllExpanded == true ? 200 : 0,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(46)),
                                  color: Color(0xff00B0D1),
                                ),

                                // decoration: const BoxDecoration(
                                //     image: DecorationImage(
                                //   image: AssetImage('assets/images/postsOval.png'),
                                //   fit: BoxFit.cover,
                                // )),
                              ),

                              // ignore: avoid_unnecessary_containers
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.07,
                                      //vertical: height * 0.05
                                    ),
                                    height: 40.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Text(AppLocalizations.of(context).hi,
                                            style: const TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Consumer<AuthProvider>(
                                          builder: (context, provider, _) =>
                                              Text(provider.user.name ?? '',
                                                  style:
                                                      const TextStyle(
                                                          fontSize: 25.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white)),
                                        ),
                                        const Text('!',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: width * 0.08,
                                      left: width * 0.08,
                                      bottom: height * 0.02,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: height * 0.06),
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .welcomeInAdoodlz,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),

                              ///Search Bar
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(
                                    isExpanded == true
                                        ? Icons.keyboard_arrow_up_sharp
                                        : Icons.keyboard_arrow_down_sharp,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                      if (!isExpanded) {
                                        heightOfContainer = 250;
                                      } else {
                                        heightOfContainer = 320;
                                      }
                                    });
                                  }),
                            ),
                          ),

                          // ignore: sized_box_for_whitespace
                          Container(
                            // duration: const Duration(milliseconds: 50),
                            // curve: Curves.easeIn,
                            // width: 400,
                            width: width * 0.9,

                            height: isExpanded == true ? 80 : 0,
                            //padding: EdgeInsets.only(left: 10),

                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) =>
                                  Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: 55,
                                        height: 55,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.pink),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 20,
                                          shadowColor: Colors.grey,
                                          color: Colors.pink,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Image.asset(
                                              'assets/icons/app.png',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context).app,
                                        style:
                                            const TextStyle(color: Colors.pink),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 0,
                          ),
                          //Categories(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                // alignment: Alignment.centerRight,
                                child: IconButton(
                                    icon: Image.asset(
                                      'assets/icons/listview.png',
                                      color: isList == true
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isList = true;
                                      });
                                    }),
                              ),
                              Align(
                                //alignment: Alignment.centerRight,
                                child: IconButton(
                                    icon: Image.asset(
                                      'assets/icons/gridview.png',
                                      color: isList == true
                                          ? Colors.grey
                                          : Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isList = false;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// search baaaaar

                    Positioned(
                      top: 90,
                      right: 0,
                      left: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 58,
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              //color: Colors.white,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/icons/search.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        final String searchText =
                                            value.toLowerCase();
                                        setState(() {
                                          _searchPosts = provider.posts
                                              .where((post) =>
                                                  post.content
                                                      .toLowerCase()
                                                      .contains(searchText) ||
                                                  post.title
                                                      .toLowerCase()
                                                      .contains(searchText))
                                              .toList();
                                        });
                                      } else {
                                        setState(() {
                                          _searchPosts = null;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: width * 0.15,
                                        right: width * 0.15,
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .putSearchWord,
                                      hintStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFC6C3C3),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// 2a5ernaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                // ignore: prefer_if_elements_to_conditional_expressions
                provider.loading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : _searchPosts == null && provider.posts != null
                        ? Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                Provider.of<PostsProvider>(context,
                                        listen: false)
                                    .getPosts();
                              },
                              child: Scrollbar(
                                // thumbColor:
                                //     const Color.fromRGBO(220, 107, 150, 0.45),
                                // isAlwaysShown: true,
                                thickness: 7,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: isList == false
                                      ? GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 0.8,
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8),
                                          itemCount: provider.posts.length,
                                          itemBuilder: (_, index) {
                                            return PostCard(
                                                post: provider.posts[index]);
                                          },
                                        )
                                      : ListView.builder(
                                          itemCount: provider.posts.length,
                                          itemBuilder: (_, index) {
                                            return PostsList(
                                                post: provider.posts[index]);
                                          },
                                        ),
                                ),
                              ),
                            ),
                          )
                        : _searchPosts != null && _searchPosts.isNotEmpty
                            ? Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await Provider.of<PostsProvider>(context,
                                            listen: false)
                                        .getPosts();
                                    if (_searchController.text.isNotEmpty) {
                                      final String searchText =
                                          _searchController.text.toLowerCase();
                                      setState(() {
                                        _searchPosts = provider.posts
                                            .where((post) =>
                                                post.content
                                                    .toLowerCase()
                                                    .contains(searchText) ||
                                                post.title
                                                    .toLowerCase()
                                                    .contains(searchText))
                                            .toList();
                                      });
                                    }
                                  },
                                  child: CupertinoScrollbar(
                                    isAlwaysShown: true,
                                    thickness: 7,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.9,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8),
                                      itemCount: _searchPosts.length,
                                      itemBuilder: (_, index) {
                                        return PostCard(
                                            post: _searchPosts[index]);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                child:
                                    Text(AppLocalizations.of(context).noPosts),
                              )),
                //),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class PostCard extends StatefulWidget {
  const PostCard({
    Key key,
    @required this.post,
  }) : super(key: key);
  final Post post;
  // final SocialShare socialShare;

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Goal shareGoal = widget.post.goals
        .firstWhere((goal) => goal.type == 'share', orElse: () => null);
    final statsTextStyle = Theme.of(context).textTheme.caption;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.postDetailsScreen,
            arguments: {'post': widget.post}).then((value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<PostsProvider>(context, listen: false).getPosts();
          });
        });
      },
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.post.expireAt != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Icon(LineAwesomeIcons.clock, color: textColor),
                      const SizedBox(width: 4),
                      Text(getTimeTillExpire(widget.post.expireAt),
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              // Expanded(
              //child:
              Expanded(
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          height: 120,
                          child: Hero(
                              tag: '${widget.post.id}${widget.post.title}',
                              child:
                                  ImageLoader(url: widget.post.media.first))),
                    ),
                    InkWell(
                      onTap: () {
                        final userId =
                            Provider.of<AuthProvider>(context, listen: false)
                                .user
                                .id;
                        Provider.of<PostsProvider>(context, listen: false)
                            .sharePostData(widget.post, userId);
                        //.socialShare.shareOptions("Hello world");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.share, color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      alignment: Alignment.center,
                      child: Text(widget.post.title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontWeight: FontWeight.normal,
                              height: 1,
                              color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      //alignment: Alignment.topCenter,
                      width: width * 0.35,
                      child: Text(
                        widget.post.content,
                        style: const TextStyle(fontSize: 11),
                        // Theme.of(context)
                        //     .textTheme
                        //     .headline6
                        //     .copyWith(height: 1.5),
                        textAlign: isRTL(widget.post.content)
                            ? TextAlign.right
                            : TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Icon(
                        //     LineAwesomeIcons.smiling_face_with_heart_eyes,
                        //     color: textColor),
                        Image.asset(
                          'assets/icons/coins.png',
                          color: Colors.orange[800],
                          width: 13,
                          height: 13,
                        ),

                        Text(
                          '${shareGoal.pointsIn} ${AppLocalizations.of(context).points}',
                          style: TextStyle(
                              color: Colors.orange[800], fontSize: 11),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.share, color: Colors.orange[800], size: 11),

                        Text(
                          widget.post.shareCount == null
                              ? '0  ${AppLocalizations.of(context).share2}'
                              : '${widget.post.shareCount} ${AppLocalizations.of(context).share2}',
                          style: TextStyle(
                              color: Colors.orange[800], fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    if (widget.post.stats != null)
                      Row(
                        children: [
                          const Icon(LineAwesomeIcons.alternate_share,
                              color: Colors.black, size: 20),
                          Text(widget.post.stats.shares.toString(),
                              style: statsTextStyle),
                          const SizedBox(width: 8),
                          const Icon(LineAwesomeIcons.coins,
                              color: Colors.black, size: 20),
                          Text(widget.post.stats.points.toString(),
                              style: statsTextStyle),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsList extends StatefulWidget {
  const PostsList({
    Key key,
    @required this.post,
  }) : super(key: key);
  final Post post;
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final Goal shareGoal = widget.post.goals
        .firstWhere((goal) => goal.type == 'share', orElse: () => null);
    final statsTextStyle = Theme.of(context).textTheme.caption;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.postDetailsScreen,
            arguments: {'post': widget.post}).then((value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<PostsProvider>(context, listen: false).getPosts();
          });
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          height: 125,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.post.expireAt != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Icon(LineAwesomeIcons.clock, color: textColor),
                      const SizedBox(width: 4),
                      Text(getTimeTillExpire(widget.post.expireAt),
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Container(
                              //width: double.infinity,
                              width: 130,
                              height: 130,
                              child: Hero(
                                tag: '${widget.post.id}${widget.post.title}',
                                child: ImageLoader(
                                  url: widget.post.media.first,
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //height: MediaQuery.of(context).size.height / 26,
                                  // height: MediaQuery.of(context).size.height / 16,
                                  // alignment: Alignment.topCenter,
                                  width: width * 0.4,
                                  child: Text(widget.post.title,
                                      maxLines: 2,
                                      //  textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              height: 1,
                                              color: Colors.black)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height / 8,
                                    // alignment: Alignment.topCenter,
                                    width: width * 0.35,
                                    child: Text(
                                      widget.post.content,
                                      style: const TextStyle(fontSize: 13),
                                      // Theme.of(context)
                                      //     .textTheme
                                      //     .headline6
                                      //     .copyWith(height: 1.5),
                                      textAlign: isRTL(widget.post.content)
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                     Row(children: [
                                       Image.asset(
                                         'assets/icons/coins.png',
                                         color: Colors.orange[800],
                                         width: 20,
                                         height: 20,
                                       ),
                                       const SizedBox(
                                         width: 5,
                                       ),
                                       Text(
                                         '${shareGoal.pointsIn} ${AppLocalizations.of(context).points}',
                                         style:
                                         TextStyle(color: Colors.orange[800]),
                                       ),
                                     ],),

                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Row(children: [
                                        Icon(Icons.share,
                                            color: Colors.orange[800], size: 20),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.post.shareCount == null
                                              ? '0  ${AppLocalizations.of(context).share2}'
                                              : '${widget.post.shareCount} ${AppLocalizations.of(context).share2}',
                                          style:
                                          TextStyle(color: Colors.orange[800]),
                                        ),
                                      ],),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        final userId =
                            Provider.of<AuthProvider>(context, listen: false)
                                .user
                                .id;
                        Provider.of<PostsProvider>(context, listen: false)
                            .sharePostData(widget.post, userId);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.share, color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///Titleeeeeeeeeeeeeeeeeeeeeeeeeeee
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Container(
              //     height: MediaQuery.of(context).size.height / 26,
              //     alignment: Alignment.center,
              //     child: Text(widget.post.title,
              //         maxLines: 2,
              //         textAlign: TextAlign.center,
              //         overflow: TextOverflow.ellipsis,
              //         style: Theme.of(context).textTheme.button.copyWith(
              //             fontWeight: FontWeight.normal,
              //             height: 1,
              //             color: Colors.black)),
              //   ),
              // ),
              ///
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    if (widget.post.stats != null)
                      Row(
                        children: [
                          const Icon(LineAwesomeIcons.alternate_share,
                              color: Colors.black, size: 20),
                          Text(widget.post.stats.shares.toString(),
                              style: statsTextStyle),
                          const SizedBox(width: 8),
                          const Icon(LineAwesomeIcons.coins,
                              color: Colors.black, size: 20),
                          Text(widget.post.stats.points.toString(),
                              style: statsTextStyle),
                        ],
                      ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
// class MyItems {
//   MyItems({this.isExpanded, this.header, this.body});
//   bool isExpanded;
//   String header;
//   String body;
// }

// class Item {
//   Item({
//     this.expandedValue,
//     this.headerValue,
//     this.isExpanded = false,
//   });

//   String expandedValue;
//   String headerValue;
//   bool isExpanded;
// }

// List<Item> generateItems(int numberOfItems) {
//   return List.generate(numberOfItems, (int index) {
//     return Item(
//       headerValue: '$index',
//       expandedValue: '$index',
//     );
//   });
// }
