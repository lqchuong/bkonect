import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhotoPage extends StatefulWidget {
  ViewPhotoPage({this.image});
  final String image;
  @override
  State<StatefulWidget> createState() => new _ViewPhotoPageState();
}

class _ViewPhotoPageState extends State<ViewPhotoPage> {
  PhotoViewController controller;
  double scaleCopy;
  @override
  void initState() {
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
  }

  void listener(PhotoViewControllerValue value) {
    setState(() {
      scaleCopy = value.scale;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: PhotoView(
          enableRotation: true,
          controller: controller,
          imageProvider: CachedNetworkImageProvider(widget.image),
        ));
  }
}
