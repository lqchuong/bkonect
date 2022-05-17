import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/LanguageInit.dart';
import '../../../LocalStoreKey.dart';
import '../LoadingPage.dart';
import 'LoginClient.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  LoginClient apiClient;
  bool checkValidMail = false;

  _ForgetPasswordPageState() {
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new LoginClient(dio);
  }
  bool _isShowPassword = true;
  final emailController = TextEditingController();
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      checkValidEmail();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  void checkValidEmail() {
    checkValidMail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text.trim());
    setState(() {});
  }

  Size deviceSize;
  bool loading = false;

  void changePasswordSercure() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  Future<BaseModel<dynamic>> forgetPassword(String email) async {
    var response;
    try {
      response = await apiClient.forgetPassword(email);
      showSuccess();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      loading = false;
      setState(() {});
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  showSuccess() async {
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
            title: "THÀNH CÔNG",
            desc: "Vui lòng kiểm tra email của bạn")
        .show();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);

    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          var deviceSize = MediaQuery.of(context).size;
          if (loading == true) return LoadingPage();
          return Scaffold(
            resizeToAvoidBottomPadding: true,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  width: deviceSize.width,
                  height: deviceSize.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: deviceSize.width,
                        height: deviceSize.height * 0.4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: deviceSize.width,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "QUAY LẠI",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                'assets/images/logo_bka.png',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "QUÊN MẬT KHẨU",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: deviceSize.width,
                        height: deviceSize.height * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: checkValidMail
                                          ? Colors.green
                                          : Colors.black26,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.check_circle,
                                      color: checkValidMail
                                          ? Colors.green
                                          : Colors.black26,
                                    ),
                                    hintText: "Email",
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.8),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 16.0)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonTheme(
                                minWidth: deviceSize.width - 20,
                                height: 50.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    checkValidEmail();
                                    if (checkValidMail == true) {
                                      loading = true;
                                      setState(() {});
                                      forgetPassword(emailController.text);
                                    } else {
                                      showWarning("QUÊN MẬT KHẨU",
                                          "Email không hợp lệ");
                                    }
                                  },
                                  child: Text("XÁC NHẬN",
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  showWarning(title, msg) async {
    Alert(
            context: context,
            type: AlertType.warning,
            buttons: [
              DialogButton(
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

  void LoginClicked() async {
    setState(() {
      loading = true;
    });
    if (emailController.text.trim().isEmpty) {
      Alert(
        context: context,
        type: AlertType.error,
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              Translations.of(context).text("common_close.close_text"),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
        title: Translations.of(context).text("error.missing_info"),
      ).show();
      return;
    }
  }
}
