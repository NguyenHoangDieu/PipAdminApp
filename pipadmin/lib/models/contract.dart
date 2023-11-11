class Contract {
  String? supplierId;
  String? supplierName;
  String? supplierPhone;
  String? supplierAvatar;
  String? pickupTime;
  String? serviceName;
  String? carName;
  String? carNumber;
  int? carType;
  String? customerId;
  String? customerName;
  String? customerPhone;
  int? contractStatus;
  int? price;
  String? createdAt;
  String? updatedAt;

  Contract(
      {this.supplierId,
        this.supplierName,
        this.supplierPhone,
        this.supplierAvatar,
        this.pickupTime,
        this.serviceName,
        this.carName,
        this.carNumber,
        this.carType,
        this.customerId,
        this.customerName,
        this.customerPhone,
        this.contractStatus,
        this.price,
        this.createdAt,
        this.updatedAt});

  Contract.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    supplierName = json['supplier_name'];
    supplierPhone = json['supplier_phone'];
    supplierAvatar = json['supplier_avatar'];
    pickupTime = json['pickup_time'];
    serviceName = json['service_name'];
    carName = json['car_name'];
    carNumber = json['car_number'];
    carType = json['car_type'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    contractStatus = json['contract_status'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['supplier_name'] = this.supplierName;
    data['supplier_phone'] = this.supplierPhone;
    data['supplier_avatar'] = this.supplierAvatar;
    data['pickup_time'] = this.pickupTime;
    data['service_name'] = this.serviceName;
    data['car_name'] = this.carName;
    data['car_number'] = this.carNumber;
    data['car_type'] = this.carType;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['contract_status'] = this.contractStatus;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ContractStats {
  int? month;
  int? totalContractByMonth;
  int? priceByMonth;

  ContractStats({this.month, this.totalContractByMonth, this.priceByMonth});

  ContractStats.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalContractByMonth = json['total_contract_by_month'];
    priceByMonth = json['price_by_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['total_contract_by_month'] = this.totalContractByMonth;
    data['price_by_month'] = this.priceByMonth;
    return data;
  }
}