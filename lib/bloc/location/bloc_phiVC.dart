
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_login.dart';
import '../../model/model_tinh.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class Bloc_phiVC extends Bloc<EventBloc, StateBloc> {
  Bloc_phiVC() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is PhiVC) {
      yield Loading();
      try {

        var res = await Api.getAsync(endPoint: ApiPath.phiVanCHuyen+'?region_id='+event.region+'&district_id='+event.district,isToken: false);

        // yield LoadSuccess(
        // );
        if (res['status'] == 1){

        int fee=res['data']['fee'];


          yield LoadSuccess(
            data: fee,
          );
        } else if (res['status'] == 0) {

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

