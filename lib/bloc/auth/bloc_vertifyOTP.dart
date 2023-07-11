import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocVertifyOTP extends Bloc<EventBloc, StateBloc> {
  BlocVertifyOTP() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();

        var res = await Api.getAsync(
            endPoint: ApiPath.vertifyOTP+'?phone='+event.param+'&otp='+event.type,  isToken: false);
        print(res);
        if (res['status'] == 1) {
          ModelLogin model = ModelLogin.fromJson(res['data']);
          yield LoadSuccess(
            data: model
          );
        } else if (res['status'] == 0) {
          yield LoadFail(error: res['msg'] ?? "Lỗi kết nối");
        }
      } on DioError catch (e) {
        yield LoadFail(error: e.error.error);
      } catch (e) {
        print(e);
        yield LoadFail(error: e.toString());
      }
    }
  }
}
