import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Views/Common/Home/HomePage.dart';

class OnboardingPage extends BaseWidgetAuthentication {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends BaseWidgetAuthenticationState<OnboardingPage> {
  final pageController = PageController(initialPage: 0);
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  Size deviceSize;

  @override
  void initState() {
    super.initState();
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
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    String firstName = (user.firstName != null) ? user.firstName : "";
    String lastName = (user.lastName != null) ? user.lastName : "";
    String fullName = firstName + " " + lastName;
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  height: deviceSize.height * 0.2 - 20,
                  width: deviceSize.height * 0.2 - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              generateUrl(user.avatar_link) ?? noImgUrl),
                          fit: BoxFit.cover)),
                  //margin: EdgeInsets.only(left: 16.0),
                )),
            SizedBox(height: 20),
            Text(
              fullName,
              style: TextStyle(color: Colors.yellow, fontSize: 25),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "BẮT ĐẦU",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
