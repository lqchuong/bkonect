import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/NotificationResultModel.dart';
part 'NotificationClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class NotificationClient {
  factory NotificationClient(Dio dio, {String baseUrl}) = _NotificationClient;

  @POST("/sys_home.ctr/getNotification")
  Future<List<NotificationResultModel>> getListNotification();

  @POST("/sys_home.ctr/update_status_notification")
  Future<dynamic> updateStatusRead(@Field() String id);
}
