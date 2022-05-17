import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Views/Common/Login/LoginPage.dart';

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = "";

  ServerError.withError(
      DioError error, BuildContext context, ProgressDialog pr) {
    _handleError(error, context, pr);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error, BuildContext _context, ProgressDialog pr) {
    if (error != null) {
      if (error.response != null) {
        _errorCode = error.response.statusCode;
        if (error.response.statusCode == 403) {
          _errorMessage = "Bạn không có quyền truy cập";
        }
        if (error.response.statusCode == 401) {
          // Navigator.pushAndRemoveUntil(
          //   _context,
          // MaterialPageRoute(builder: (context) => LoginPage()),
          // (Route<dynamic> route) => true,
          // );
          Navigator.pushReplacement(_context,
              new MaterialPageRoute(builder: (context) => LoginPage()));
          return;
        }
        if (pr.isShowing()) {
          pr.hide();
        }
        if (error.response.statusCode != 400) {
          print(error.response.data);
          Alert(
            context: _context,
            type: AlertType.error,
            content: Text(
              "Có lỗi xảy ra, vui lòng thử lại!",
              style: TextStyle(color: Colors.black),
            ),
            buttons: [
              DialogButton(
                color: Colors.red,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(_context),
                width: 120,
              )
            ],
            title: _errorMessage,
          ).show();
        }
      }
    }
  }
}
