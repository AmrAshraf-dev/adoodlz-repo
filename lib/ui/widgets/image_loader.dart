import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String url;
  const ImageLoader({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(url,
        loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Center(
            child: Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                child: const CircularProgressIndicator()),
          );
          break;
        case LoadState.completed:
          return state.completedWidget;
          break;

        default:
          return Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          );
      }
    }, fit: BoxFit.cover);
  }
}
