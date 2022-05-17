import 'package:flutter/material.dart';

class MenuItemHorizontalModel {
  String name;
  IconData icon;
  int number;
  String route;
  dynamic argument;
  MenuItemHorizontalModel(
      {this.icon, this.name, this.number, this.route, this.argument});
}

class MenuItemHorizontal extends StatelessWidget {
  final MenuItemHorizontalModel catg;
  MenuItemHorizontal({this.catg});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (this.catg.route != "" && this.catg.route != null)
                      Navigator.pushNamed(context, this.catg.route,
                          arguments: this.catg.argument);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF6F5F8),
                    ),
                    child: Icon(
                      catg.icon,
                      // size: 20.0,
                    ),
                  ),
                ),
                catg.number > 0
                    ? Positioned(
                        right: -5.0,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF3775FD),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            catg.number.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              catg.name,
              style: TextStyle(
                fontSize: 13.0,
              ),
            )
          ],
        ));
  }
}
