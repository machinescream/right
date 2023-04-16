import 'package:flutter/widgets.dart';
import 'package:right/right.dart';

class RText extends StatelessWidget implements Right {
  final String text;
  final TextStyle? style;
  final double? textScaleFactor;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;
  final int? maxLines;

  const RText({
    Key? key,
    required this.text,
    this.style,
    this.textScaleFactor,
    this.overflow,
    this.textWidthBasis,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.replaceAll(' ', '\u00A0'),
      textHeightBehavior:
          const TextHeightBehavior(applyHeightToFirstAscent: false),
      style: style,
      textScaleFactor: textScaleFactor,
      overflow: overflow,
      textWidthBasis: textWidthBasis,
      maxLines: maxLines,
    );
  }
}
