import 'package:flutter/material.dart';

const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);

class MenuItemModel {
  String title;
  String subTitle;
  IconData icon;
  Color iconColor;
  String route;
  dynamic argument;
  MenuItemModel(
      {this.icon,
      this.title,
      this.iconColor,
      this.subTitle,
      this.route,
      this.argument});
}

class MenuItemVertical extends StatelessWidget {
  final MenuItemModel menu;
  MenuItemVertical({this.menu});
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          if (this.menu.route != "" && this.menu.route != null)
            Navigator.pushNamed(context, this.menu.route,
                arguments: this.menu.argument);
        },
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 5.0),
          height: deviceSize.height * 0.10,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD1DCFF),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: menu.iconColor,
                      ),
                      child: Icon(
                        menu.icon,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.0),
                      width: deviceSize.width-135,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            menu.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            softWrap: true,
                            text: TextSpan(
                              style: TextStyle(color: Color(0xffaabbcc)),
                              text: menu.subTitle,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: profile_item_color,
                )
              ],
            ),
          ),
        ));
  }
}
