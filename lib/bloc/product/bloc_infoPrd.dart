import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_login.dart';
import '../../model/model_productMain.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class Bloc_infoPrd extends Bloc<EventBloc, StateBloc> {
  Bloc_infoPrd() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {
        var res = await Api.getAsync(
            endPoint: ApiPath.infoPro + event.param, isToken: true);

        print(res);

        if (res['status'] == 'success') {
          ModelInfoPro modelInfoPro = ModelInfoPro.fromJson(res['data']);

          yield LoadSuccess(data: modelInfoPro);
        } else if (res['status'] == 'error') {
          yield LoadFail(error: res['errors'] ?? "Lỗi kết nối");
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
