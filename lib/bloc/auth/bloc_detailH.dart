import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_detailOrder.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocDetailOrder extends Bloc<EventBloc, StateBloc> {
  BlocDetailOrder() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: ApiPath.detailOrder+event.param,);

        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){

          ModelOrderDetail model=ModelOrderDetail.fromJson(res['data']);


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