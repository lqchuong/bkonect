import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Model/Error/ErrorModel.dart';
import 'package:worldsoft_maintain/Views/Setting/Api/SettingClient.dart';

class ChangePasswordPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends BaseWidgetAuthenticationState<ChangePasswordPage> {
  Size deviceSize;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Dio dio;
  ProgressDialog pr;
  SettingClient apiClient;
  bool loading = false;
  List<ErrorModel> listError = [];

  _ChangePasswordPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new SettingClient(dio);
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  Future<BaseModel<dynamic>> changePassword(
      String oldPassword, String newPassword) async {
    var response;
    try {
      response = await apiClient.changePassword(oldPassword, newPassword);
    } catch (error, stacktrace) {
      loading = false;
      setState(() {});

      List<dynamic> myListError = error.response.data;
      listError = myListError.map((e) => ErrorModel.fromJson(e)).toList();

      if (listError.where((e) => e.Key == "model.old_password").length > 0) {
        showWarning("ĐỔI MẬT KHẨU", "Mật khẩu hiện tại không đúng");
      }
    }
    loading = false;
    setState(() {});
    if (listError.length == 0) {
      showSuccess("ĐỔI MẬT KHẨU", "Đổi mật khẩu thành công");
    }

    return BaseModel()..data = response;
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            "THAY ĐỔI MẬT KHẨU",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () {
                if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  showError(
                      "ĐỔI MẬT KHẨU", "Xác nhận mật khẩu không trùng khớp");
                } else {
                  loading = true;
                  setState(() {});
                  changePassword(
                      oldPasswordController.text, newPasswordController.text);
                }
              },
              label: Text("ĐỔI MẬT KHẨU"),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild.unfocus();
            }
          },
          child: Container(
            color: Colors.transparent,
            width: deviceSize.width,
            height: deviceSize.height - 160,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Mật khẩu cũ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: oldPasswordController,
                    obscureText: true,
                    style: new TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(16.0),
                      hintStyle: TextStyle(color: Colors.white38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Mật khẩu mới",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    style: new TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(16.0),
                      hintStyle: TextStyle(color: Colors.white38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Xác nhận mật khẩu",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: new TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(16.0),
                      hintStyle: TextStyle(color: Colors.white38),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
