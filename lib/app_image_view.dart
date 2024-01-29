library app_image_view;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final double? radius;
  final Function()? onTap;
  final double? leftMargin;
  final double? rightMargin;
  final double? topMargin;
  final double? svgHeight;
  final double? bottomMargin;
  final BoxFit? boxFit;
  final Positioned? positioned;
  final Widget? errorWidget;
  final bool? originalSize;
  final Color? color;
  final bool isCache;

  const AppImage(
      {Key? key,
      required this.path,
      this.height,
      this.width,
      this.radius,
        this.svgHeight,
      this.onTap,
      this.topMargin,
      this.bottomMargin,
      this.leftMargin,
      this.rightMargin,
      this.boxFit,
      this.color,
      this.positioned,
      this.errorWidget,
      this.originalSize,
      this.isCache = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: leftMargin ?? 0,
          right: rightMargin ?? 0,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 0.0),
          child: !path.contains("http")
              ? path.contains(".svg")
                  ?svgHeight!=null? SvgPicture.asset(
            height: svgHeight!,
                          "assets/images/$path",
                          colorFilter: color == null
                              ? null
                              : ColorFilter.mode(color!, BlendMode.srcIn),
                        ):SvgPicture.asset(
            "assets/images/$path",
            colorFilter: color == null
                ? null
                : ColorFilter.mode(color!, BlendMode.srcIn),
          )
                  : Image.asset(
                      "assets/images/$path",
                      width: width ?? height,
                      height: height,
                      fit: boxFit,
                      color: color,
                      colorBlendMode: BlendMode.srcIn,
                    )
              : isCache
                  ?  path.contains(".svg")
              ? SvgPicture.network(
            path,
            height: 100,
            width: 100,
          )
              :CachedNetworkImage(
                      width: width,
                      height: height,
                      fit: boxFit,
                      // memCacheWidth: width?.toInt() ?? 60 * 2,
                      // memCacheHeight: height?.toInt() ?? 60 * 2,
                      imageUrl: path,
                      placeholder: (context, url) => Container(
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          errorWidget ??
                          Container(
                            color: Colors.black12,
                          ),
                    )
                  : Image.network(
                      path,
                      width: width,
                      height: height,
                      fit: boxFit,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (c, v, q) =>
                          errorWidget ??
                          Container(
                            color: Colors.black12,
                          ),
                    ),
        ),
      ),
    );
  }
}
