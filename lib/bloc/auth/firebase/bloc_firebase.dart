// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../config/api.dart';
// import '../../../config/path/api_path.dart';
// import '../../event_bloc.dart';
// import '../../state_bloc.dart';
//
//
//
// class BlocFireBaseMS extends Bloc<EventBloc, StateBloc> {
//   BlocFireBaseMS() : super(StateBloc());
//
//   @override
//   Stream<StateBloc> mapEventToState(EventBloc event) async* {
//     if (event is firebase) {
//       yield Loading();
//       try {
//         Map<String, dynamic> req = Map();
//         String os='';
//         if(Platform.isAndroid){
//           os='android';
//         }else if(Platform.isIOS){
//           os='ios';
//         }
//         String deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
//         req['token']=deviceToken;
//         print(deviceToken);
//         req['os']=os;
//         var res = await Api.postAsync(
//             endPoint: ApiPath.firebase, req: req, isToken: true);
//         print(res);
//         if (res['status'] == 1) {
//
//
//
//           yield LoadSuccess(
//
//           );
//         } else if (res['status'] == 0) {
//           yield LoadFail(error: res['errors']['login'] ?? "Lỗi kết nối");
//         }
//       } on DioError catch (e) {
//         yield LoadFail(error: e.error.error);
//       } catch (e) {
//         print(e);
//         yield LoadFail(error: e.toString());
//       }
//     }
//   }
// }
