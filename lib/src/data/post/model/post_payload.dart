import 'dart:io';

import 'package:equatable/equatable.dart';

class PostPayload extends Equatable {
  final File image;
  final String caption;
  PostPayload({
    this.image,
    this.caption,
  });

  PostPayload copyWith({
    File image,
    String caption,
  }) {
    return PostPayload(
      image: image ?? this.image,
      caption: caption ?? this.caption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': 'FilePath:${image?.path}',
      'caption': caption,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [image, caption];
}
