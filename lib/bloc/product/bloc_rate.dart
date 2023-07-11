import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocRate extends Bloc<EventBloc, StateBloc> {
  BlocRate() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is RatePrd) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['product_id'] = event.product_id;
        req['star'] = event.star;
        req['content'] = event.content;
        var res = await Api.postAsync(
            endPoint: ApiPath.rate, req: req, isToken: true);
        print(res);
        if (res['status'] == 1) {
          yield LoadSuccess(

          );
        } else if (res['status'] == 0) {
          yield LoadFail(error:  res['errors'] ?? "Lỗi kết nối");
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
