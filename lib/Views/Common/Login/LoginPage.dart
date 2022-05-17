import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/LanguageInit.dart';
import 'package:worldsoft_maintain/Model/LoginAccessToken.dart';
import 'package:worldsoft_maintain/Views/Onboarding/OnboardingPage.dart';
import '../../../LocalStoreKey.dart';
import '../../../routes.dart';
import '../LoadingPage.dart';
import 'LoginClient.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginStateState createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginPage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  LoginClient apiClient;
  bool checkValidMail = false;

  _LoginStateState() {
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new LoginClient(dio);
  }
  bool _isShowPassword = true;
  final emailController = TextEditingController();
  final textPasswordController = TextEditingController();
  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      checkValidEmail();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    textPasswordController.dispose();
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
                              Image.asset(
                                'assets/images/logo_bka.png',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "BKA CONNECT",
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
                                keyboardType: TextInputType.emailAddress,
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
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: deviceSize.width * 0.8 - 30,
                                    height: 50,
                                    child: TextField(
                                      obscureText: _isShowPassword,
                                      controller: textPasswordController,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock_open),
                                          hintText: "Mật khẩu",
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.8),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: deviceSize.width * 0.2 - 20,
                                    height: 50,
                                    child: GestureDetector(
                                        onTap: () {
                                          changePasswordSercure();
                                        },
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          onPressed: changePasswordSercure,
                                          child: Image.asset(
                                            (_isShowPassword)
                                                ? 'assets/images/password_hide.png'
                                                : 'assets/images/password_show.png',
                                          ),
                                        )),
                                  )
                                ],
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
                                      LoginClicked();
                                    } else {
                                      showWarning(
                                          "ĐĂNG NHẬP", "Email không hợp lệ");
                                    }
                                  },
                                  child: Text("ĐĂNG NHẬP",
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: deviceSize.width,
                                child: Row(
                                  children: [
                                    Container(
                                      width: deviceSize.width * 0.5 - 25,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routes.ForgetPasswordPage);
                                          },
                                          child: Text(
                                            "Quên mật khẩu ?",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "|",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.RegisterPage);
                                      },
                                      child: Container(
                                        width: deviceSize.width * 0.5 - 25,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Đăng ký tài khoản",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
    if (emailController.text.trim().isEmpty ||
        textPasswordController.text.trim().isEmpty) {
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

    var reponse = await login();
    await pr.show();
    pr.hide().then((isHidden) {
      var error = reponse.getException;
      if (error != null) {
        var titlemsg = Translations.of(context).text("error.login_failed");
        var descmsg = Translations.of(context).text("error.wrong_password");
        if (error.getErrorCode() != 400) {
          titlemsg = error.getErrorMessage();
          descmsg = "";
        }
        setState(() {
          loading = false;
        });
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
                title: titlemsg,
                desc: descmsg)
            .show();
      } else {
        storage.setItem(LocalStoreKey.tokenUser, reponse.data.token);
        String token = storage.getItem(LocalStoreKey.tokenUser);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingPage()),
          (Route<dynamic> route) => true,
        );
      }
    });
  }

  Future<BaseModel<LoginAccessToken>> login() async {
    LoginAccessToken response;
    try {
      response = await apiClient.authenticate(
          emailController.text.trim(), textPasswordController.text.trim());
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    return BaseModel()..data = response;
  }
}
