// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Currencies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Currencies _$CurrenciesFromJson(Map<String, dynamic> json) {
  return _Currencies.fromJson(json);
}

/// @nodoc
mixin _$Currencies {
  String get id => throw _privateConstructorUsedError;
  String get logo_url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  double? get marketCap => throw _privateConstructorUsedError;
  String get rank => throw _privateConstructorUsedError;
  String? get rankDelta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrenciesCopyWith<Currencies> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrenciesCopyWith<$Res> {
  factory $CurrenciesCopyWith(
          Currencies value, $Res Function(Currencies) then) =
      _$CurrenciesCopyWithImpl<$Res, Currencies>;
  @useResult
  $Res call(
      {String id,
      String logo_url,
      String name,
      String price,
      double? marketCap,
      String rank,
      String? rankDelta});
}

/// @nodoc
class _$CurrenciesCopyWithImpl<$Res, $Val extends Currencies>
    implements $CurrenciesCopyWith<$Res> {
  _$CurrenciesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? logo_url = null,
    Object? name = null,
    Object? price = null,
    Object? marketCap = freezed,
    Object? rank = null,
    Object? rankDelta = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      logo_url: null == logo_url
          ? _value.logo_url
          : logo_url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as String,
      rankDelta: freezed == rankDelta
          ? _value.rankDelta
          : rankDelta // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrenciesCopyWith<$Res>
    implements $CurrenciesCopyWith<$Res> {
  factory _$$_CurrenciesCopyWith(
          _$_Currencies value, $Res Function(_$_Currencies) then) =
      __$$_CurrenciesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String logo_url,
      String name,
      String price,
      double? marketCap,
      String rank,
      String? rankDelta});
}

/// @nodoc
class __$$_CurrenciesCopyWithImpl<$Res>
    extends _$CurrenciesCopyWithImpl<$Res, _$_Currencies>
    implements _$$_CurrenciesCopyWith<$Res> {
  __$$_CurrenciesCopyWithImpl(
      _$_Currencies _value, $Res Function(_$_Currencies) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? logo_url = null,
    Object? name = null,
    Object? price = null,
    Object? marketCap = freezed,
    Object? rank = null,
    Object? rankDelta = freezed,
  }) {
    return _then(_$_Currencies(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      logo_url: null == logo_url
          ? _value.logo_url
          : logo_url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as String,
      rankDelta: freezed == rankDelta
          ? _value.rankDelta
          : rankDelta // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Currencies implements _Currencies {
  _$_Currencies(
      {required this.id,
      required this.logo_url,
      required this.name,
      required this.price,
      this.marketCap,
      required this.rank,
      this.rankDelta});

  factory _$_Currencies.fromJson(Map<String, dynamic> json) =>
      _$$_CurrenciesFromJson(json);

  @override
  final String id;
  @override
  final String logo_url;
  @override
  final String name;
  @override
  final String price;
  @override
  final double? marketCap;
  @override
  final String rank;
  @override
  final String? rankDelta;

  @override
  String toString() {
    return 'Currencies(id: $id, logo_url: $logo_url, name: $name, price: $price, marketCap: $marketCap, rank: $rank, rankDelta: $rankDelta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Currencies &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.logo_url, logo_url) ||
                other.logo_url == logo_url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.rankDelta, rankDelta) ||
                other.rankDelta == rankDelta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, logo_url, name, price, marketCap, rank, rankDelta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrenciesCopyWith<_$_Currencies> get copyWith =>
      __$$_CurrenciesCopyWithImpl<_$_Currencies>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrenciesToJson(
      this,
    );
  }
}

abstract class _Currencies implements Currencies {
  factory _Currencies(
      {required final String id,
      required final String logo_url,
      required final String name,
      required final String price,
      final double? marketCap,
      required final String rank,
      final String? rankDelta}) = _$_Currencies;

  factory _Currencies.fromJson(Map<String, dynamic> json) =
      _$_Currencies.fromJson;

  @override
  String get id;
  @override
  String get logo_url;
  @override
  String get name;
  @override
  String get price;
  @override
  double? get marketCap;
  @override
  String get rank;
  @override
  String? get rankDelta;
  @override
  @JsonKey(ignore: true)
  _$$_CurrenciesCopyWith<_$_Currencies> get copyWith =>
      throw _privateConstructorUsedError;
}
