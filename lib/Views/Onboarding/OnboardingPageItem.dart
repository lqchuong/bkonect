import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/LanguageInit.dart';
import 'package:worldsoft_maintain/Views/Common/Home/HomePage.dart';

class OnboardingPageItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  const OnboardingPageItem(
      {Key key, @required this.title, this.subtitle, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: deviceSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 20.0),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(
              height: deviceSize.height * 2 / 3 - 20,
            ),
            // Expanded(
            //   child: Container(
            //     width: double.infinity,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Material(
            //         elevation: 4.0,
            //         child: Image.asset(imageUrl),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.0),
            Center(
              child: FlatButton(
                textColor: Colors.white,
                child: Text(Translations.of(context)
                    .text('onboarding.start_text')
                    .toUpperCase()),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
