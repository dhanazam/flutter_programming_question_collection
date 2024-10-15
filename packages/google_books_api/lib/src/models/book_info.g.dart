// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookInfo _$BookInfoFromJson(Map<String, dynamic> json) => BookInfo(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      publisher: json['publisher'] as String? ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contentVersion: json['contentVersion'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageLinks:
          ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
      language: json['language'] as String? ?? '',
      maturityRating: json['maturityRating'] as String? ?? '',
      pageCount: (json['pageCount'] as num?)?.toInt() ?? 0,
      rawPublishedDate: json['rawPublishedDate'] as String? ?? '',
      ratingsCount: (json['ratingsCount'] as num?)?.toInt() ?? 0,
      previewLink: Uri.parse(json['previewLink'] as String),
      infoLink: Uri.parse(json['infoLink'] as String),
      canonicalVolumeLink: Uri.parse(json['canonicalVolumeLink'] as String),
    );

Map<String, dynamic> _$BookInfoToJson(BookInfo instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'rawPublishedDate': instance.rawPublishedDate,
      'description': instance.description,
      'pageCount': instance.pageCount,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'ratingsCount': instance.ratingsCount,
      'maturityRating': instance.maturityRating,
      'contentVersion': instance.contentVersion,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink.toString(),
      'infoLink': instance.infoLink.toString(),
      'canonicalVolumeLink': instance.canonicalVolumeLink.toString(),
    };
