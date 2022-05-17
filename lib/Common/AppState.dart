import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";

// ignore: prefer_double_quotes
part 'AppState.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @nullable
  String get fcmToken;
  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
  factory AppState.init() => AppState((a) => a);

  AppState clear() {
    // keep the temporal fcm token even when clearing state
    // so it can be set again on login.
    //
    // Add here anything else that also needs to be carried over.
    return AppState.init().rebuild((s) => s..fcmToken = fcmToken);
  }
}
