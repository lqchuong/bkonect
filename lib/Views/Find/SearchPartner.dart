import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPartner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchPartnerState();
}

class _SearchPartnerState extends State<SearchPartner> {
  Size deviceSize;
  final searchController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: new TextStyle(color: Colors.white, fontSize: 14),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: "Tìm bạn bè, tin nhắn ...",
            hintStyle: TextStyle(color: Colors.white38),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.5),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.qr_code), onPressed: () {})],
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Tính năng đang trong quá trình phát triển"),
      ),
    );
  }
}
