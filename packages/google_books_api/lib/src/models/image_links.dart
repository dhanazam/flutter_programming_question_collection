import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_links.g.dart';

@JsonSerializable()
class ImageLinks extends Equatable {
  const ImageLinks({
    this.smallThumbnail,
    this.bigThumbnail,
  });

  final String? smallThumbnail;
  final String? bigThumbnail;

  ImageLinks copyWith({
    String? smallThumbnail,
    String? bigThumbnail,
  }) {
    return ImageLinks(
      smallThumbnail: smallThumbnail ?? this.smallThumbnail,
      bigThumbnail: bigThumbnail ?? this.bigThumbnail,
    );
  }

  static ImageLinks fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);

  @override
  List<Object?> get props => [smallThumbnail, bigThumbnail];
  @override
  String toString() {
    return 'ImageLinks(smallThumbnail: $smallThumbnail, bigThumbnail: $bigThumbnail)';
  }
}
