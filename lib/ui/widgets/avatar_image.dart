import 'package:flutter/material.dart';

class AvatarImage extends StatefulWidget {
  const AvatarImage(
      {Key key,
      this.imageUrl,
      @required this.radius,
      @required this.height,
      @required this.width})
      : super(key: key);
  final String imageUrl;
  final double radius;
  final double height;
  final double width;

  @override
  _AvatarImageState createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  Widget child;
  @override
  void initState() {
    child = Container();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageUrl == null || widget.imageUrl.isEmpty
        ? Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/user_profile.png'),
              ),
            ),
          )
        : CircleAvatar(
            radius: widget.radius,
            backgroundColor: const Color(0xFFF7F7F7),
            backgroundImage: NetworkImage(
              widget.imageUrl,
              scale: 1,
            ),
            onBackgroundImageError: (err, trace) {
              debugPrint(err.toString());
              setState(() {
                child = Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/user_profile.png'),
                    ),
                  ),
                );
              });
            },
            child: child,
          );
  }

  @override
  void dispose() {
    child = Container();
    super.dispose();
  }
}
