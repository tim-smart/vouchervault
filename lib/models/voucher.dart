import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'voucher.g.dart';

final uuidgen = Uuid();

@JsonSerializable()
class Voucher extends Equatable {
  Voucher({
    String uuid,
    this.store = '',
    this.description = '',
    this.code = '',
    this.expires,
    this.balance,
  }) : this.uuid = uuid ?? uuidgen.v4();

  final String uuid;
  final String store;
  final String description;
  final String code;
  final DateTime expires;
  Option<DateTime> get expiresOption => optionOf(expires);
  final double balance;
  Option<double> get balanceOption => optionOf(balance);

  @override
  List<Object> get props {
    return [
      uuid,
      store,
      description,
      code,
      expires,
      balance,
    ];
  }

  dynamic toJson() => _$VoucherToJson(this);
  static Voucher fromJson(dynamic json) => _$VoucherFromJson(json);

  Voucher copyWith({
    String uuid,
    String store,
    String description,
    String code,
    Option<DateTime> expires,
    Option<double> balance,
  }) {
    return Voucher(
      uuid: uuid ?? this.uuid,
      store: store ?? this.store,
      description: description ?? this.description,
      code: code ?? this.code,
      expires: (expires ?? expiresOption) | null,
      balance: (balance ?? balanceOption) | null,
    );
  }
}
