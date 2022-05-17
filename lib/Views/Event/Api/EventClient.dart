import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ContentResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventParticipateResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventQaResulModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/FileResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ImageIntroResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ReviewResultModel.dart';
part 'EventClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class EventClient {
  factory EventClient(Dio dio, {String baseUrl}) = _EventClient;

  @POST("/sys_event.ctr/get_list_tham_du")
  Future<List<EventParticipateResultModel>> getListCompany(
    @Field() String event_id,
    @Field() int role,
  );

  @POST("/sys_event.ctr/get_list_event_program")
  Future<List<ContentResultModel>> getListProgram(@Field() String event_id);

  @POST("/sys_event.ctr/get_list_file")
  Future<List<FileResultModel>> getListFile(@Field() String event_id);

  @POST("/sys_event.ctr/update_status_event")
  Future<List<ContentResultModel>> updateStatusEvent(
    @Field() String event_id,
    @Field() int status,
  );

  @POST("/sys_event.ctr/getQAEvent")
  Future<List<EventQaResulModel>> getListQandA(@Field() String event_id);

  @POST("/sys_event_participate.ctr/get_list_danh_gia")
  Future<List<ReviewResultModel>> getListReview(@Field() String event_id);

  @POST("/sys_event.ctr/get_list_image")
  Future<List<ImageIntroResultModel>> getImagesIntro(@Field() String event_id);

  @POST("/sys_event.ctr/getDetailEvent")
  Future<EventResultModel> getDetailEvent(@Field() String event_id);

  @POST("/sys_event.ctr/getEventParticipate")
  Future<List<EventResultModel>> getListEvent(@Field() String check_in_status);

  @POST("/sys_event_participate.ctr/danh_gia")
  Future<dynamic> postReview(@Field() String event_id, @Field() int review_rate,
      @Field() String review_note);
}
