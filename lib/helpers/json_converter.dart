import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String timestamp) {
    return DateTime.parse(timestamp);
  }

  @override
  String toJson(DateTime date) => date.toIso8601String();
}

class DateTimeOrNullConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeOrNullConverter();

  @override
  DateTime? fromJson(String? timestamp) {
    return timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
  }

  @override
  String? toJson(DateTime? date) => date?.millisecondsSinceEpoch.toString();
}

class IntegerConverter implements JsonConverter<int, String> {
  const IntegerConverter();

  @override
  int fromJson(String quantity) {
    return int.parse(quantity);
  }

  @override
  String toJson(int quantity) => quantity.toString();
}

class IntegerOrNullConverter implements JsonConverter<int?, String?> {
  const IntegerOrNullConverter();

  @override
  int? fromJson(String? quantity) {
    return int.tryParse(quantity ?? "");
  }

  @override
  String? toJson(int? quantity) => quantity?.toString();
}

class BooleanConverter implements JsonConverter<bool, String> {
  const BooleanConverter();

  @override
  bool fromJson(String value) {
    return value == "1" ? true : false;
  }

  @override
  String toJson(bool value) => value ? "1" : "0";
}

class MarkTypeConverter implements JsonConverter<MarkType, String> {
  const MarkTypeConverter();

  @override
  MarkType fromJson(String value) {
    return value.toLowerCase() == "trust" ? MarkType.trust : MarkType.fake;
  }

  @override
  String toJson(MarkType value) => value.name;
}
