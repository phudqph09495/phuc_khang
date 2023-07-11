abstract class EventBloc {}

class LoadMoreEvent extends EventBloc {
  String id;
  int limit, page;
  bool cleanList, loadMore;
  String? sort;

  LoadMoreEvent(
      {this.id = '',
      this.cleanList = false,
      this.limit = 0,
      this.page = 1,
      this.loadMore = false,
      this.sort});
}
class UpdateProfile extends EventBloc{
String? name;
String? email;
String? phone;
String? address;
  String?  region;
  String? district;
  String? birth;
  String? id;
  String? nameS;
  UpdateProfile({this.phone,this.name,this.email,this.address,this.district,this.region,this.birth,this.id,this.nameS});
}
class GetData extends EventBloc {
  int limit, page;
  bool cleanList, loadMore;
  String param;
  String type;
  String year;
  String month;

  GetData({
    this.cleanList = false,
    this.limit = 20,
    this.page = 1,
    this.loadMore = false,
    this.param = '',
    this.type = '',
    this.year = '',
    this.month = '',
  });
}

class GetData2 extends EventBloc {
  String param;
  GetData2({this.param = ''});
}

class PhiVC extends EventBloc {
  String region;
  String district;
  PhiVC({this.region = '', this.district = ''});
}

class LoginApp extends EventBloc {
  String id;
  String password;

  LoginApp({
    required this.id,
    required this.password,
  });
}
class firebase extends EventBloc {

}
class RatePrd extends EventBloc{
  String? product_id;
  int? star;
  String? content;
  RatePrd({this.content,this.star,this.product_id});
}
class DangKy extends EventBloc {
  String phone;
  String password;
  String email;
  String name;
  String address;
  String password_confirmation;

  DangKy({
    required this.address,required this.name,required this.email,
    required this.password_confirmation,
    required this.phone,
    required this.password,
  });
}

class DuyetDon extends EventBloc {
  int? id;
  String? status;
  String param;
  DuyetDon({this.id, this.status, this.param = ''});
}

class GetData3 extends EventBloc {
  String param;
  String type;
  GetData3({this.type='',this.param=''});
}

class Product extends EventBloc {
  String? id;
  int? qty;
  Product({this.id, this.qty});
}

class Delivery_info extends EventBloc {
  String? address;
  String? region_id;
  String? district_id;
  String? name;
  String? phone;
  Delivery_info(
      {this.name, this.address, this.phone, this.district_id, this.region_id});
}


