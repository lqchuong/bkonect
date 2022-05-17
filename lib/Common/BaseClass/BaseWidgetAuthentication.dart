import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/MainPage/userdbModel.dart';
import 'package:worldsoft_maintain/Views/Common/Home/HomeClient.dart';
import 'package:worldsoft_maintain/Views/Common/LoadingPage.dart';
import 'package:worldsoft_maintain/Views/Common/ViewMultiPhotoPage.dart';
import 'package:worldsoft_maintain/Views/Common/ViewPhotoFromServer.dart';
import 'package:worldsoft_maintain/Views/Common/ViewPhotoPage.dart';
import 'package:worldsoft_maintain/Views/Common/error/NoInternetPage.dart';
import '../../LocalStoreKey.dart';
import '../Config.dart';
import 'BaseModelApi.dart';
import 'DioClientInit.dart';

class BaseWidgetAuthentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BaseWidgetAuthenticationState();
}

class BaseWidgetAuthenticationState<T extends BaseWidgetAuthentication>
    extends State<T> {
  int counter = 0;
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  userdbModel user;
  ProgressDialog pr;
  bool loading = true;
  bool firstload = true;
  HomeClient homeapi;
  StreamSubscription<ConnectivityResult> subscription;

  checkInternet() async {
    setState(() {
      loading = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        noInternet = false;
      }
    } on Exception catch (_) {
      noInternet = true;
    }
    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    dio = createDioClientAuthentication(storage);
    homeapi = new HomeClient(dio);

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }

  getUser() async {
    try {
      var userraw = storage.getItem(LocalStoreKey.userInfo);

      if (userraw == null) {
        user = await homeapi.getUserInfo();
        storage.setItem(LocalStoreKey.userInfo, user);
      } else {
        user = userdbModel.fromJson(userraw);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
  }

  openImg(String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPhotoPage(image: image),
      ),
    );
  }

  openImgFromServer(String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPhotoFromServer(image: image),
      ),
    );
  }

  void openMultiImg(List<ViewMultiPhotoItem> galleryItems, final int index,
      bool verticalGallery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
  }

  functionfirstLoad() async {
    await getUser();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    return FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == true) {
            if (noInternet == true) return NoInternetPage();
            if (firstload == true) {
              loading = true;
              functionfirstLoad();
              firstload = false;
            }
            if (loading == true) return LoadingPage();

            return buildwidget(context);
          } else {
            return LoadingPage();
          }
        });
  }

  buildwidget(BuildContext context) {
    return Container();
  }

  showError(title, msg) async {
    Alert(
            context: context,
            type: AlertType.error,
            buttons: [
              DialogButton(
                color: Colors.black,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: title,
            desc: msg ?? "")
        .show();
  }

  showSuccess(title, msg) async {
    Alert(
            context: context,
            type: AlertType.success,
            buttons: [
              DialogButton(
                color: Colors.black,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: title,
            desc: msg ?? "")
        .show();
  }

  showWarning(title, msg) async {
    Alert(
            context: context,
            type: AlertType.warning,
            buttons: [
              DialogButton(
                color: Colors.red,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: title,
            desc: msg ?? "")
        .show();
  }

  showAcceptCustomButton(buttonAcceptTitle, title, msg, func) async {
    Alert(
            context: context,
            type: AlertType.warning,
            buttons: [
              DialogButton(
                color: Colors.red,
                child: Text(
                  buttonAcceptTitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  func();
                },
                width: 120,
              ),
              DialogButton(
                color: Colors.blue,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: title,
            desc: msg ?? "")
        .show();
  }
}
