import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ContentOnCalendarModel.dart';
import 'package:worldsoft_maintain/Views/Calendar/Api/CalendarClient.dart';
import 'package:dio/dio.dart';

import '../../LocalStoreKey.dart';

class CalendarPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _CalendarPageState();
}

class _CalendarPageState extends BaseWidgetAuthenticationState<CalendarPage> {
  Size deviceSize;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  List<ContentOnCalendarModel> listApiResult = [];
  List<ContentOnCalendarModel> listEventInday = [];
  List<ContentOnCalendarModel> listChosenShow = [];
  List<String> listEventName = [];
  // final formatDateTime = new DateFormat(formatTimeDateString);
  // final formatDate = new DateFormat(formatDateString);

  final formatTime = new DateFormat(formatHourMinuteString);

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  CalendarClient apiClient;

  _CalendarPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new CalendarClient(dio);
  }

  Future<BaseModel<List<ContentOnCalendarModel>>> getListProgram() async {
    List<ContentOnCalendarModel> response;
    try {
      response = await apiClient.getListProgram();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listApiResult = response;
    listEventInday = listApiResult;
    for (ContentOnCalendarModel temp in listEventInday) {
      temp.db.start_time = new DateTime(temp.db.start_time.year,
          temp.db.start_time.month, temp.db.start_time.day);
    }
    List<DateTime> eventList =
        listEventInday.map((e) => e.db.start_time).toSet().toList();

    for (DateTime temp in eventList) {
      _markedDateMap.add(
          new DateTime(temp.year, temp.month, temp.day),
          new Event(
            date: new DateTime(temp.year, temp.month, temp.day),
            title: "eventName",
            icon: _eventIcon,
          ));
    }
    loading = false;
    setState(() {});

    return BaseModel()..data = response;
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>();
  CalendarCarousel _calendarCarouselNoHeader;

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
  initState() {
    super.initState();
    loading = true;
    setState(() {});
    getListProgram();
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        // events.forEach((event) => print(event.title));
        listChosenShow = listApiResult
            .where((element) =>
                element.db.start_time.year == _currentDate2.year &&
                element.db.start_time.month == _currentDate2.month &&
                element.db.start_time.day == _currentDate2.day)
            .toList();
        listEventName =
            listChosenShow.map((e) => e.ten_su_kien).toSet().toList();
      },

      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.green)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      markedDateMoreShowTotal: true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("LỊCH CỦA TÔI"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Colors.yellow,
                  child: new Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      Expanded(
                          child: Text(
                        _currentMonth,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.green,
                  // height: deviceSize.height * 0.6,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: _calendarCarouselNoHeader,
                ), //
                for (String temp in listEventName) cardViewEventReminder(temp)
              ],
            ),
          ),
        ));
  }

  cardViewEventReminder(String temp) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ExpansionTile(
          title: Text(
            temp,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          children: <Widget>[
            for (ContentOnCalendarModel myContent in listChosenShow)
              cardViewContentReminder(myContent)
          ],
        ));
  }

  cardViewContentReminder(ContentOnCalendarModel contentOnCalendarModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Container(
            width: deviceSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contentOnCalendarModel.db.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: deviceSize.width - 60,
                        child: Html(
                          data: (contentOnCalendarModel.db.description ?? ""),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (formatTime
                                .format(contentOnCalendarModel.db.start_time)
                                .toString() +
                            " - "),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        formatTime
                            .format(contentOnCalendarModel.db.end_time)
                            .toString(),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
