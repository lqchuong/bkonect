//Dynamic headers

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ContentResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CountNotificationModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/NotifyNumberModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/MainPage/NotificationModel.dart';
import 'package:worldsoft_maintain/Model/MainPage/userdbModel.dart';
part 'HomeClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class HomeClient {
  factory HomeClient(Dio dio, {String baseUrl}) = _HomeClient;

  @GET("/sys_home.ctr/getUserInfo")
  Future<userdbModel> getUserInfo();

  @GET("/sys_event.ctr/count_notification_event")
  Future<NotifyNumberModel> getListNotifyEvent();

  @POST("/sys_home.ctr/count_notification")
  Future<CountNotificationModel> countNotification();

  @POST("/sys_home.ctr/getdetailnotification")
  Future<NotificationModel> getnotification(
    @Field() String id,
  );

  @POST("/sys_home.ctr/registertokennoti")
  Future<NotificationModel> registertokennoti(
    @Field() String token,
  );

  @POST("/sys_user.ctr/getUserInfo")
  Future<RegisterPostApiModel> getUserInformation();

  @POST("/sys_event.ctr/update_status_event")
  Future<List<ContentResultModel>> updateStatusEvent(
    @Field() String event_id,
    @Field() int status,
  );

  @POST("/sys_event.ctr/getEventParticipate")
  Future<List<EventResultModel>> getListEvent(@Field() String check_in_status);
}
