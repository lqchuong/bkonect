import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';

class ViewPhotoFromServer extends StatefulWidget {
  ViewPhotoFromServer({this.image});
  final String image;
  @override
  State<StatefulWidget> createState() => new _ViewPhotoFromServerState();
}

class _ViewPhotoFromServerState extends State<ViewPhotoFromServer> {
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
          backgroundColor: Colors.black,
        ),
        body: PhotoView(
          enableRotation: true,
          controller: controller,
          imageProvider:
              CachedNetworkImageProvider(generateUrl(widget.image) ?? noImgUrl),
        ));
  }
}
