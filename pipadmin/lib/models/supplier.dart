class Supplier {
  String? id;
  String? name;
  String? phone;
  String? type;
  String? avatar;
  String? carType;
  String? carName;
  String? carNumber;
  String? createdAt;

  Supplier(
      {this.id,
        this.name,
        this.phone,
        this.type,
        this.avatar,
        this.carType,
        this.carName,
        this.carNumber,
        this.createdAt
      });

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    type = json['type'];
    avatar = json['avatar'];
    carType = json['car_type'];
    carName = json['car_name'];
    carNumber = json['car_number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['car_type'] = this.carType;
    data['car_name'] = this.carName;
    data['car_number'] = this.carNumber;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class CarType {
  int? id;
  String? carType;
  int? total;

  CarType({this.id, this.carType, this.total});

  CarType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carType = json['car_type'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_type'] = this.carType;
    data['total'] = this.total;
    return data;
  }
}