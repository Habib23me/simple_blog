import 'package:equatable/equatable.dart';

class PageMetaData extends Equatable {
  final int page;
  final int pages;
  int get nextPage => page + 1;
  bool get hasNextPage => page < pages;
  PageMetaData({
    this.page,
    this.pages,
  });

  PageMetaData copyWith({
    int page,
    int pages,
  }) {
    return PageMetaData(
      page: page ?? this.page,
      pages: pages ?? this.pages,
    );
  }

  factory PageMetaData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PageMetaData(
      page: map['page'],
      pages: map['pages'],
    );
  }

  @override
  String toString() => 'PageMetaData(page: $page, pages: $pages)';

  @override
  List<Object> get props => [page, pages];
}
