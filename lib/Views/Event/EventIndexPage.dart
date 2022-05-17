import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Views/Event/Api/EventClient.dart';
import '../../LocalStoreKey.dart';
import '../../routes.dart';

class EventIndexPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _EventIndexPageState();
}

class _EventIndexPageState
    extends BaseWidgetAuthenticationState<EventIndexPage> {
  Size deviceSize;

  List<EventResultModel> listApiResult = [];
  List<EventResultModel> listEventSearch = [];

  final formatDate = new DateFormat(formatDateString);

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;

  TextEditingController _textController = TextEditingController();

  _EventIndexPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  Future<BaseModel<List<EventResultModel>>> getListEvent(
      String check_in_status) async {
    List<EventResultModel> response;

    try {
      response = await apiClient.getListEvent(check_in_status);
      listApiResult = response;
      listEventSearch = List.from(listApiResult);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  Future updateStatusEvent(String id, int status, int index) async {
    try {
      if (status == 3) {
        showSuccess("SỰ KIỆN", "Tham gia sự kiện thành công");
      } else {
        showSuccess("SỰ KIỆN", "Từ chối tham gia sự kiện thành công");
      }
      listApiResult[index].check_in_status = status;
      setState(() {});
      await apiClient.updateStatusEvent(id, status);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
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
    Future.delayed(Duration.zero, () {
      getListEvent("0");
      loading = true;
      setState(() {});
      // getListEvent(check_in_status);
    });
  }

  onItemChanged(String value) {
    setState(() {
      listEventSearch = listApiResult
          .where((string) =>
              string.db.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("TÌM KIẾM"),
        backgroundColor: Colors.blue,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                Container(
                  width: deviceSize.width,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                          hoverColor: Colors.blue,
                          fillColor: Colors.blue[50],
                          focusColor: Colors.red,
                          filled: true,
                          labelText: "Tìm sự kiện",
                          labelStyle: TextStyle(color: Colors.blue),
                          hintText: "Tên sự kiện ...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      onChanged: onItemChanged,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: deviceSize.width,
                  height: deviceSize.height - 190,
                  child: ListView.builder(
                      itemCount: listEventSearch.length,
                      itemBuilder: (context, index) {
                        return cardViewEvent(listEventSearch[index], index);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cardViewEvent(EventResultModel eventResultModel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.EventDetailPage, arguments: {
          "event_id": eventResultModel.db.id,
          // "index": index
        }).then((value) => {setState(() {})});
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          width: deviceSize.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10.0,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: deviceSize.width - 20,
                    height: 150,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20.0),
                        // color: Colors.red,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                (eventResultModel.db.logo != null)
                                    ? generateUrl(eventResultModel.db.logo)
                                    : noImgUrl),
                            fit: BoxFit.cover)),
                    //margin: EdgeInsets.only(left: 16.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  eventResultModel.db.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[900],
                      fontSize: 20),
                ),

                SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: <Widget>[
                //     Image.asset(
                //       'assets/images/hinhthuc.png',
                //       width: 30,
                //       height: 30,
                //     ),
                //     Text(
                //       " Hình thức: ",
                //       style: TextStyle(fontWeight: FontWeight.w900),
                //     ),
                //     (eventResultModel.db.type == 1)
                //         ? Text("Offline")
                //         : Text("Online")
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/diadiem.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: deviceSize.width - 80,
                        child: Text(
                          (eventResultModel.db.location != null)
                              ? eventResultModel.db.location
                              : "Chưa có địa điểm",
                          style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Container(),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/thoigian.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: deviceSize.width - 80,
                      child: Text(
                        formatDate
                                .format(
                                    eventResultModel.db.time_start.toLocal())
                                .toString() +
                            " - " +
                            formatDate
                                .format(eventResultModel.db.time_end.toLocal())
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_right),
                    Text(
                      "Xem chi tiết",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Spacer(),
                    (eventResultModel.trang_thai == 1)
                        ? Text(
                            "Đang diễn ra",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        : (eventResultModel.trang_thai == 2)
                            ? Text(
                                "Đã bị hủy",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : (eventResultModel.trang_thai == 3)
                                ? Text(
                                    "Đã kết thúc",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Sắp tới",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                (eventResultModel.check_in_status == 1 &&
                            eventResultModel.trang_thai == 1 ||
                        eventResultModel.check_in_status == 1 &&
                            eventResultModel.trang_thai == 4)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: deviceSize.width * 0.33,
                            child: RaisedButton(
                              onPressed: () {
                                Alert(
                                        context: context,
                                        type: AlertType.info,
                                        buttons: [
                                          DialogButton(
                                            color: Colors.red,
                                            child: Text(
                                              "Đồng ý",
                                              style: TextStyle(
                                                  color: hexToColor("#005A24"),
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              updateStatusEvent(
                                                  eventResultModel.db.id,
                                                  2,
                                                  index);
                                            },
                                            width: 120,
                                          ),
                                          DialogButton(
                                            color: Colors.blue,
                                            child: Text(
                                              "Đóng",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                        title: "Sự kiện",
                                        desc: "Bạn chắc chắn muốn từ chối " +
                                            eventResultModel.db.title)
                                    .show();
                              },
                              color: hexToColor("#CB0000"),
                              textColor: Colors.white,
                              child: Text(
                                "Từ chối",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: deviceSize.width * 0.33,
                            child: RaisedButton(
                              onPressed: () {
                                Alert(
                                        context: context,
                                        type: AlertType.info,
                                        buttons: [
                                          DialogButton(
                                            color: hexToColor("#005A24"),
                                            child: Text(
                                              "Đồng ý",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              updateStatusEvent(
                                                  eventResultModel.db.id,
                                                  3,
                                                  index);
                                            },
                                            width: 120,
                                          ),
                                          DialogButton(
                                            color: Colors.blue,
                                            child: Text(
                                              "Đóng",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                        title: "Sự kiện",
                                        desc: "Bạn chắc chắn muốn tham gia " +
                                            eventResultModel.db.title)
                                    .show();
                              },
                              color: hexToColor("#005A24"),
                              textColor: Colors.white,
                              child: Text(
                                "Tham gia",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    : (eventResultModel.check_in_status == 3)
                        ? Row(
                            children: [
                              Spacer(),
                              Text(
                                "ĐÃ ĐĂNG KÝ THAM DỰ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          )
                        : (eventResultModel.check_in_status == 4)
                            ? Container(
                                child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "ĐÃ THAM DỰ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ))
                            : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
