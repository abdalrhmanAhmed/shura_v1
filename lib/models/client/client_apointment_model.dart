class ClientApointmentModel {
  late String name;
  late String service;
  late String? photo;
  late int status;
  late String day;
  late String from;
  late String to;
  late int orderId;

  ClientApointmentModel.fromJson(Map<String, dynamic> json) {
    name = json['console']['name'];
    photo = json['console']['photo'];

    status = json['status'];
    service = json['service'];

    day = json['Time']['day'];
    from = json['Time']['from'];
    to = json['Time']['to'];
    orderId = json['order_id'];
  }
} //end of model
