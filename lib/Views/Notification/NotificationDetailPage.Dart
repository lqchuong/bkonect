import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Model/MainPage/NotificationModel.dart';
import 'package:worldsoft_maintain/Views/Common/LoadingPage.dart';

class NotificationDetailPage extends BaseWidgetAuthentication {
  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState
    extends BaseWidgetAuthenticationState<NotificationDetailPage> {
  NotificationModel model;
  Size deviceSize;

  @override
  void initState() {
    super.initState();
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      model = (ModalRoute.of(context).settings.arguments);
      setState(() {});
    });
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

  launchurl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  @override
  Widget buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    if (model == null) return LoadingPage();

    return Scaffold(
      appBar: AppBar(
        title: Text("THÔNG BÁO"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  model.title,
                  style: TextStyle(fontSize: 25.0),
                ),
                (model.contenthtml != null)
                    ? Html(
                        data: model.contenthtml,
                        //Optional parameters:
                        onLinkTap: (url) {
                          launchurl(url);
                          // open url in a webview
                        },
                        style: {},
                        onImageTap: (src) {
                          openImg(src);
                          // Display the image in large form.
                        },
                      )
                    : Text("")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
