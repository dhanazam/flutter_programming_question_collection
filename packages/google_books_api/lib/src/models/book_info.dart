import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'book_info.g.dart';

@JsonSerializable()
class BookInfo extends Equatable {
  const BookInfo({
    this.title = '',
    this.subtitle = '',
    this.authors = const [],
    this.publisher = '',
    this.averageRating = 0,
    this.categories = const [],
    this.contentVersion = '',
    this.description = '',
    required this.imageLinks,
    this.language = '',
    this.maturityRating = '',
    this.pageCount = 0,
    required this.publishedDate,
    this.rawPublishedDate = '',
    this.ratingsCount = 0,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
  });

  final String title;
  final String subtitle;
  final List<String> authors;
  final String publisher;
  final DateTime? publishedDate;
  final String rawPublishedDate;
  final String description;
  final int pageCount;
  final List<String> categories;
  final double averageRating;
  final int ratingsCount;
  final String maturityRating;
  final String contentVersion;
  final Map<String, Uri>? imageLinks;
  final String language;
  final Uri previewLink;
  final Uri infoLink;
  final Uri canonicalVolumeLink;

  BookInfo copyWith({
    String? title,
    String? subtitle,
    List<String>? authors,
    String? publisher,
    DateTime? publishedDate,
    String? rawPublishedDate,
    String? description,
    int? pageCount,
    List<String>? categories,
    double? averageRating,
    int? ratingsCount,
    String? maturityRating,
    String? contentVersion,
    Map<String, Uri>? imageLinks,
    String? language,
    Uri? previewLink,
    Uri? infoLink,
    Uri? canonicalVolumeLink,
  }) {
    return BookInfo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      authors: authors ?? this.authors,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      rawPublishedDate: rawPublishedDate ?? this.rawPublishedDate,
      description: description ?? this.description,
      pageCount: pageCount ?? this.pageCount,
      categories: categories ?? this.categories,
      averageRating: averageRating ?? this.averageRating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      maturityRating: maturityRating ?? this.maturityRating,
      contentVersion: contentVersion ?? this.contentVersion,
      imageLinks: imageLinks ?? this.imageLinks,
      language: language ?? this.language,
      previewLink: previewLink ?? this.previewLink,
      infoLink: infoLink ?? this.infoLink,
      canonicalVolumeLink: canonicalVolumeLink ?? this.canonicalVolumeLink,
    );
  }

  static BookInfo fromJson(Map<String, dynamic> json) =>
      _$BookInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookInfoToJson(this);

  @override
  List<Object?> get props => [
        title,
        subtitle,
        authors,
        publisher,
        publishedDate,
        rawPublishedDate,
        description,
        pageCount,
        categories,
        averageRating,
        ratingsCount,
        maturityRating,
        contentVersion,
        imageLinks,
        language,
        previewLink,
        infoLink,
        canonicalVolumeLink,
      ];
}
