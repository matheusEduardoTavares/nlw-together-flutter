import 'dart:convert';

class BoletoModel {
  BoletoModel({
    this.uuid,
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
    this.isPaid = false,
  });

  final String? name;
  final String? dueDate;
  final double? value;
  final String? barcode;
  final String? uuid;
  final bool? isPaid;
  static const key = 'boletos';

  BoletoModel copyWith({
    String? uuid,
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
    bool? isPaid,
  }) {
    return BoletoModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
      'isPaid': isPaid,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      uuid: map['uuid'],
      name: map['name'],
      dueDate: map['dueDate'],
      value: map['value'],
      barcode: map['barcode'],
      isPaid: map['isPaid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) =>
      BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(uuid: $uuid, name: $name, dueDate: $dueDate, value: $value, barcode: $barcode, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoletoModel &&
        other.uuid == uuid &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.value == value &&
        other.barcode == barcode &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^ name.hashCode ^ dueDate.hashCode ^ value.hashCode ^ barcode.hashCode ^ isPaid.hashCode;
  }
}
