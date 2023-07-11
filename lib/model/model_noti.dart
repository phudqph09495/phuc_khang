class ModelNoti {
  List<NotiFiCa>? items;
  Pagination? pagination;

  ModelNoti({this.items, this.pagination});

  ModelNoti.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <NotiFiCa>[];
      json['items'].forEach((v) {
        items!.add(new NotiFiCa.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class NotiFiCa {
  String? id;
  String? title;
  String? description;
  String? createdDate;

  NotiFiCa({this.id, this.title, this.description, this.createdDate});

  NotiFiCa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_date'] = this.createdDate;
    return data;
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
    perPage = json['per_page'];
    currentPage = json['current_page'];
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
