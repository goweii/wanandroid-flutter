import 'package:json_annotation/json_annotation.dart';

part 'paged_bean.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagedBean<T> {
  int curPage;
  List<T> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  PagedBean({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory PagedBean.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$PagedBeanFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PagedBeanToJson<T>(this, toJsonT);
}
