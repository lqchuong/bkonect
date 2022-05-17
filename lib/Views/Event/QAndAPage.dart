import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventQaResulModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import '../../LocalStoreKey.dart';
import 'Api/EventClient.dart';

class QAndAPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _QAndAPageState();
}

class _QAndAPageState extends BaseWidgetAuthenticationState<QAndAPage> {
  Size deviceSize;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;

  EventResultModel eventResultModel;

  List<EventQaResulModel> listApiResult = [];

  _QAndAPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  Future<BaseModel<List<EventQaResulModel>>> getListQandA(
      String event_id) async {
    List<EventQaResulModel> response;

    try {
      response = await apiClient.getListQandA(event_id);
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
      eventResultModel = ModalRoute.of(context).settings.arguments;
      getListQandA(eventResultModel.db.id);
      loading = true;
      setState(() {});
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Q & A"),
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
            child: Column(
              children: [
                for (var i = 0; i < listApiResult.length; i++)
                  cardViewQuestion(listApiResult[i], i + 1)
              ],
            )));
  }

  cardViewQuestion(EventQaResulModel temp, int index) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: MaterialButton(
                  shape: CircleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.red,
                          style: BorderStyle.none)),
                  child: Text(index.toString()),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                width: deviceSize.width - 140,
                child: Html(
                  data: temp.db.question,
                ),
              ),
            ],
          ),
          children: <Widget>[
            new ListTile(
                title: Html(
              data: temp.db.answer,
            )),
          ],
        ));
  }
}
