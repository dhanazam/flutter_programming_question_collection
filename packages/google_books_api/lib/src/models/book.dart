import 'package:equatable/equatable.dart';

import 'book_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book extends Equatable {
  const Book({
    required this.id,
    this.etag = '',
    required this.volumeInfo,
    this.selfLink,
  });

  final String id;
  final String? etag;
  final Uri? selfLink;
  final BookInfo volumeInfo;

  Book copyWith({
    String? id,
    String? etag,
    Uri? selfLink,
    BookInfo? info,
  }) {
    return Book(
      id: id ?? this.id,
      etag: etag ?? this.etag,
      selfLink: selfLink ?? this.selfLink,
      volumeInfo: info ?? volumeInfo,
    );
  }

  static Book fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object?> get props => [
        id,
        etag,
        selfLink,
        volumeInfo,
      ];
}
