import 'package:flutter/material.dart';
import 'package:right/src/r_text.dart';

class RUserTile extends StatelessWidget {
  final String? imageUrl;
  final String userName;
  final Color userAvatarBorderColor;
  final TextStyle? titleTextStyle;

  const RUserTile({
    Key? key,
    this.imageUrl,
    required this.userName,
    this.userAvatarBorderColor = Colors.cyan,
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: 34,
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
        const SizedBox(width: 20),
        Expanded(
          child: RText(
            text: userName,
            style: titleTextStyle,
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
