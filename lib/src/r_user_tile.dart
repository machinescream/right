import 'package:flutter/material.dart';
import 'package:right/right.dart';
import 'package:right/src/r_text.dart';

class RUserTile extends StatelessWidget implements Right {
  final String? imageUrl;
  final String userName;
  final Color userAvatarBorderColor;
  final TextStyle? textStyle;
  final int avatarSize;
  final EdgeInsets avatarPadding;

  const RUserTile({
    super.key,
    this.imageUrl,
    required this.userName,
    this.userAvatarBorderColor = Colors.transparent,
    this.textStyle,
    this.avatarSize = 40,
    this.avatarPadding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: avatarPadding,
          child: SizedBox.square(
            dimension: avatarSize.toDouble(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: userAvatarBorderColor),
                shape: BoxShape.circle,
                image: imageUrl != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl!),
                      )
                    : null,
              ),
              child: imageUrl == null ? const Icon(Icons.person) : null,
            ),
          ),
        ),
        Expanded(
          child: RText(
            text: userName,
            style: textStyle,
            textScaleFactor: 1,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.parent,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
