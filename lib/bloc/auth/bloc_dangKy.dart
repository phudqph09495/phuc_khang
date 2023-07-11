import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocDangKy extends Bloc<EventBloc, StateBloc> {
  BlocDangKy() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is DangKy) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['name']=event.name;
        req['email']=event.email;
        req['phone']=event.phone;

req['address']=event.address;
req['password']=event.password;
req['re_password']=event.password_confirmation;

print(req);
        var res = await Api.postAsync(
            endPoint: ApiPath.dangky, req: req, isToken: true);
        print(res);
        if (res['status'] == 'success') {



          yield LoadSuccess(
mess: res['message']
          );
        } else if (res['status'] == 'error') {
          yield LoadFail(error: res['message'] ?? "Lỗi kết nối");
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
