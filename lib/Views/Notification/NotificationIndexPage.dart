import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/NotificationResultModel.dart';
import 'package:worldsoft_maintain/Model/MainPage/NotificationModel.dart';
import 'package:worldsoft_maintain/Views/Notification/Api/NotificationClient.dart';
import 'package:worldsoft_maintain/routes.dart';
import '../../LocalStoreKey.dart';

class NotificationIndexPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _NotificationIndexPage();
}

class _NotificationIndexPage
    extends BaseWidgetAuthenticationState<NotificationIndexPage> {
  Size deviceSize;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  NotificationClient apiClient;
  final formatDate = new DateFormat(formatTimeDateString);

  List<NotificationResultModel> listApiResult = [];

  _NotificationIndexPage() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new NotificationClient(dio);
  }

  Future<BaseModel<List<NotificationResultModel>>> getListNoti() async {
    List<NotificationResultModel> response;

    try {
      response = await apiClient.getListNotification();
      listApiResult = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  Future<BaseModel<dynamic>> updateStatusNoti(String id) async {
    var response;

    try {
      response = await apiClient.updateStatusRead(id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    // await insertToken();
    // var postToken = await homeapi.getListCompanyRecommend();
    if (user != null) {}

    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    loading = true;
    setState(() {});
    getListNoti();
  }

  gotoDetail(NotificationModel model) async {
    if (model.menu == null) {
      Navigator.pushNamed(context, Routes.NotificationDetailPage,
              arguments: model)
          .then((value) => {});
    } else {
      Navigator.pushNamed(context, model.menu,
              arguments: json.decode(model.param))
          .then((value) => {});
    }

    if (model.status_read == 1) {
      model.status_read = 2;

      setState(() {});
    }
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("THÔNG BÁO"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          decoration: BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(
              image: AssetImage("assets/images/background_home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: (listApiResult.isEmpty)
              ? Center(
                  child: Text("Chưa có thông báo nào"),
                )
              : ListView.builder(
                  itemCount: listApiResult.length,
                  itemBuilder: (context, index) {
                    return cardViewNotification(listApiResult[index].db);
                  }),
          // child: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       for (var i = 0; i < listApiResult.length; i++)
          //         cardViewNotification(listApiResult[i].db)
          //     ],
          //   ),
          // )
        ));
  }

  cardViewNotification(NotificationModel temp) {
    return GestureDetector(
      onTap: () {
        updateStatusNoti(temp.id);
        gotoDetail(temp);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          width: deviceSize.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: ,
                  width: deviceSize.width / 8,
                  height: deviceSize.width / 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(deviceSize.width / 8),
                      border: Border.all(color: Color(0xff1FCC65)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              generateUrl(temp.logo) ?? noImgUrl),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: deviceSize.width * 7 / 8 - 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        temp.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (temp.status_read == 1)
                                ? Colors.black
                                : Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        temp.description,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: deviceSize.width * 7 / 8 - 50,
                          child: Text(
                            formatDate
                                .format(temp.date_send.toLocal())
                                .toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
