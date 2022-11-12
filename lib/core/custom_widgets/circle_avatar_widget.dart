import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatar;
  final double size;
  final String? placeHolder;
  final bool isEnabled;
  final double? radius;

  const AvatarWidget(
      {Key? key,
      required this.avatar,
      required this.size,
      this.placeHolder,
      this.isEnabled = true,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // clipBehavior: Clip.none,
      borderRadius: BorderRadius.circular(radius ?? (size / 2)),
      child: CachedNetworkImage(
        imageUrl: avatar ?? "",
        fit: BoxFit.cover,
        width: size,
        height: size,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: isEnabled
                    ? null
                    : ColorFilter.mode(AppColor.black, BlendMode.color)),
          ),
        ),
        placeholder: (context, url) => const Icon(CupertinoIcons.person),
        errorWidget: (context, url, _) => const Icon(CupertinoIcons.person),
      ),
    );
  }
}
