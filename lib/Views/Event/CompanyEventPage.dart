import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventParticipateResultModel.dart';
import 'package:worldsoft_maintain/Model/EventModel.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Views/Event/Api/EventClient.dart';
import '../../LocalStoreKey.dart';

class CompanyEventPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _CompanyEventPageState();
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: debug);
}

class _CompanyEventPageState
    extends BaseWidgetAuthenticationState<CompanyEventPage> {
  Size deviceSize;
  EventModel eventModel;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;

  List<EventParticipateResultModel> listApiResult = [];

  _CompanyEventPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  Future<BaseModel<List<EventParticipateResultModel>>> getListCompany(
      String id, int role) async {
    List<EventParticipateResultModel> response;
    try {
      response = await apiClient.getListCompany(id, role);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listApiResult = response;
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
  }

  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      eventModel = ModalRoute.of(context).settings.arguments;
      loading = true;
      setState(() {});
      getListCompany(eventModel.id, 2);
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("DANH SÁCH LIÊN HỆ"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: (listApiResult.isEmpty)
              ? Container()
              : ListView.builder(
                  itemCount: listApiResult.length,
                  itemBuilder: (context, index) {
                    return (listApiResult[index].db.role == 2)
                        ? cardViewCompany(listApiResult[index])
                        : Container();
                  }),
        ),
      ),
    );
  }

  cardViewCompany(EventParticipateResultModel eventParticipateResultModel) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(deviceSize.width * 0.25),
                    child: Container(
                      width: deviceSize.width * 0.25 - 36,
                      height: deviceSize.width * 0.25 - 36,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20.0),
                          // color: Colors.red,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(generateUrl(
                                  eventParticipateResultModel.avatar_link ??
                                      noImgUrl)),
                              fit: BoxFit.cover)),
                      //margin: EdgeInsets.only(left: 16.0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: deviceSize.width * 0.75 - 26,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          eventParticipateResultModel.user_name ?? "",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchCaller(
                                eventParticipateResultModel.dienthoai);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                (eventParticipateResultModel.dienthoai) ?? "",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await OpenMailApp.openMailApp();

                            // If no mail apps found, show error
                            if (!result.didOpen && !result.canOpen) {
                              showNoMailAppsDialog(context);

                              // iOS: if multiple mail apps found, show dialog to select.
                              // There is no native intent/default app system in iOS so
                              // you have to do it yourself.
                            } else if (!result.didOpen && result.canOpen) {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: deviceSize.width * 0.75 - 90,
                                child: Text(
                                  eventParticipateResultModel.email,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // GestureDetector(
                              //     onTap: () {
                              //       Toast.show("Đã sao chép", context,
                              //           duration: Toast.LENGTH_SHORT,
                              //           gravity: Toast.BOTTOM);
                              //       Clipboard.setData(ClipboardData(
                              //           text: eventParticipateResultModel.email));
                              //     },
                              //     child: Icon(Icons.copy)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
