import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:worldsoft_maintain/Views/Common/Home/HomePage.dart';
import 'package:worldsoft_maintain/Views/Common/Login/LoginPage.dart';
import 'package:worldsoft_maintain/routes.dart';
import 'Common/LanguageInit.dart';
import 'Common/Style/theme.dart';
import 'Views/Calendar/CalendarPage.dart';
import 'Views/Common/Home/WaitingConfirm.dart';
import 'Views/Common/Login/ForgetPasswordPage.dart';
import 'Views/Common/Login/RegisterCompany.dart';
import 'Views/Common/Login/RegisterInfoPage.dart';
import 'Views/Common/Login/RegisterPage.dart';
import 'Views/Common/Meeting/MeetingPage.dart';
import 'Views/Common/error/NotImplementPage.dart';
import 'Views/Cooperate/CooperatePage.dart';
import 'Views/Event/CompanyEventDetailPage.dart';
import 'Views/Event/CompanyEventPage.dart';
import 'Views/Event/ContentEventPage.dart';
import 'Views/Event/EventDetailPage.dart';
import 'Views/Event/EventIndexPage.dart';
import 'Views/Event/PostReview.dart';
import 'Views/Event/QAndAPage.dart';
import 'Views/Event/ReviewPage.dart';
import 'Views/Event/TicketPage.dart';
import 'Views/Find/FindPartner.dart';
import 'Views/Find/SearchPartner.dart';
import 'Views/Notification/NotificationIndexPage.dart';
import 'Views/Notification/NotificationDetailPage.dart';
import 'Views/Setting/ChangePasswordPage.dart';
import 'Views/Setting/EditUserInfo.dart';
import 'Views/Setting/SettingPage.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WorldsoftApp();
  }
}

class WorldsoftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''),
        const Locale('en', ''),
      ],
      title: "Circles App",
      theme: AppTheme.theme,
      routes: {
        Routes.home: (context) {
          return HomePage();
        },
        Routes.login: (context) {
          return LoginPage();
        },
        Routes.RegisterPage: (context) {
          return RegisterPage();
        },
        Routes.RegisterInfoPage: (context) {
          return RegisterInfoPage();
        },
        Routes.not_implement: (context) {
          return NotImplementPage();
        },
        Routes.EventIndexPage: (context) {
          return EventIndexPage();
        },
        Routes.EventDetailPage: (context) {
          return EventDetailPage();
        },
        Routes.TicketPage: (context) {
          return TicketPage();
        },
        Routes.ContentEventPage: (context) {
          return ContentEventPage();
        },
        Routes.CompanyEventPage: (context) {
          return CompanyEventPage();
        },
        Routes.CompanyEventDetailPage: (context) {
          return CompanyEventDetailPage();
        },
        Routes.QAndAPage: (context) {
          return QAndAPage();
        },
        Routes.ReviewPage: (context) {
          return ReviewPage();
        },
        Routes.CalendarPage: (context) {
          return CalendarPage();
        },
        Routes.FindPartner: (context) {
          return FindPartner();
        },
        Routes.MeetingPage: (context) {
          return MeetingPage();
        },
        Routes.CooperatePage: (context) {
          return CooperatePage();
        },
        Routes.SettingPage: (context) {
          return SettingPage();
        },
        Routes.NotificationIndexPage: (context) {
          return NotificationIndexPage();
        },
        Routes.EditUserInfo: (context) {
          return EditUserInfo();
        },
        Routes.RegisterCompany: (context) {
          return RegisterCompany();
        },
        Routes.ForgetPasswordPage: (context) {
          return ForgetPasswordPage();
        },
        Routes.ChangePasswordPage: (context) {
          return ChangePasswordPage();
        },
        Routes.WaitingConfirm: (context) {
          return WaitingConfirm();
        },
        Routes.NotificationDetailPage: (context) {
          return NotificationDetailPage();
        },
        Routes.PostReview: (context) {
          return PostReview();
        },
        Routes.SearchPartner: (context) {
          return SearchPartner();
        }
      },
    );
  }
}
