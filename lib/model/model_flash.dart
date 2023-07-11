import 'package:shared_preferences/shared_preferences.dart';

import 'model_productMain.dart';

class ModelFlash {
  List<ModelSanPhamMain>? items;
  Pagination? pagination;

  ModelFlash({this.items, this.pagination});

  ModelFlash.fromJson(Map<String, dynamic> json,String type) {
    if (json['items'] != null) {
      items = <ModelSanPhamMain>[];
      json['items'].forEach((v) {
        items!.add(new ModelSanPhamMain.fromJson(json:v,type:type));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }


}



class Pagination {
  String? total;
  String? perPage;
  String? currentPage;
  int? lastPage;

  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'].toString();
    currentPage = json['current_page'].toString();
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}
