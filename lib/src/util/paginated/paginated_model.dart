import 'package:equatable/equatable.dart';
import 'package:simple_blog/src/util/paginated/paginated.dart';

typedef Constructor<T> = T Function(Map<String, dynamic>);

class Paginated<T> extends Equatable {
  final List<T> docs;
  final PageMetaData metaData;
  Paginated({
    this.docs,
    this.metaData,
  });

  Paginated<T> copyWith({
    List<T> docs,
    PageMetaData metaData,
  }) {
    return Paginated<T>(
      docs: docs ?? this.docs,
      metaData: metaData ?? this.metaData,
    );
  }

  factory Paginated.fromMap(
    Map<String, dynamic> map,
    Constructor<T> constructor,
  ) {
    if (map == null) return null;

    return Paginated<T>(
      docs: List<T>.from(map['docs']?.map((x) => constructor(x))),
      metaData: PageMetaData.fromMap(map['metaData']),
    );
  }

  @override
  String toString() => 'Paginated(docs: $docs, metaData: $metaData)';

  @override
  List<Object> get props => [docs, metaData];
}
