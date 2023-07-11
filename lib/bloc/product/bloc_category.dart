
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_category.dart';
import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocCategory extends Bloc<EventBloc, StateBloc> {
  BlocCategory() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {

        var res = await Api.getAsync(endPoint: ApiPath.category,isToken: false);



        if (res['status'] == 'success'){

          ModelCategory model=ModelCategory.fromJson(res['data']);


          yield LoadSuccess(
              data: model
          );
        } else if (res['status'] == 'failed') {

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

