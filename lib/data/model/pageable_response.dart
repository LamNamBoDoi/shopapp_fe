import 'package:shopapp_v1/data/model/pageable.dart';
import 'package:shopapp_v1/data/model/sort.dart';

class PageableResponse<T> {
  List<T> content;
  bool empty;
  bool first;
  bool last;
  int number;
  int numberOfElements;
  Pageable pageable;
  int size;
  Sort sort;
  int totalElements;
  int totalPages;

  PageableResponse({
    required this.content,
    required this.empty,
    required this.first,
    required this.last,
    required this.number,
    required this.numberOfElements,
    required this.pageable,
    required this.size,
    required this.sort,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageableResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PageableResponse<T>(
      content:
          (json['content'] as List).map((item) => fromJsonT(item)).toList(),
      empty: json['empty'],
      first: json['first'],
      last: json['last'],
      number: json['number'],
      numberOfElements: json['numberOfElements'],
      pageable: Pageable.fromJson(json['pageable']),
      size: json['size'],
      sort: Sort.fromJson(json['sort']),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'content': content.map((item) => toJsonT(item)).toList(),
      'empty': empty,
      'first': first,
      'last': last,
      'number': number,
      'numberOfElements': numberOfElements,
      'pageable': pageable.toJson(),
      'size': size,
      'sort': sort.toJson(),
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
  }
}
