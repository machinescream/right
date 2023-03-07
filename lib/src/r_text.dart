import 'package:flutter/widgets.dart';

class RText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? textScaleFactor;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;
  final int? maxLines;

  const RText({
    required this.text,
    Key? key,
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
