import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:shimmer/shimmer.dart';

class KShimmer extends StatelessWidget {
  const KShimmer({super.key, this.progress});

  final String? progress;

  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.white10,
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: MediaQuery.sizeOf(context).height * 0.3,
        child: Text(progress ?? '', style: ViewUtils.ubuntuStyle(fontSize: 30)),
      ),
    );
  }
}
