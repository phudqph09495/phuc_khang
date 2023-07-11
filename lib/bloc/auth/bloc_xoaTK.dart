import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocXoaAcc extends Bloc<EventBloc, StateBloc> {
  BlocXoaAcc() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {
        var res = await Api.postAsync(
          endPoint: ApiPath.deleteAcc,req: {},
        );

        // yield LoadSuccess(
        // );
        if (res['status'] == "success") {
          yield LoadSuccess();
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
