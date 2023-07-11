
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuc_khang/model/model_search.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';


import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocSearch extends Bloc<EventBloc, StateBloc> {
  BlocSearch() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: '${ApiPath.search}${event.param}',);
        print(res);
        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){
     ModelSearch model=ModelSearch.fromJson(res['data']);


          yield LoadSuccess(
              data: model
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
