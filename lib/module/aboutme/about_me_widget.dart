import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/com/bean/about_me_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class BlurredImage extends StatelessWidget {
  const BlurredImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 60,
          sigmaY: 60,
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          errorWidget: (context, url, error) => Container(),
          placeholder: (context, url) => Container(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AboutMeInfo extends StatelessWidget {
  const AboutMeInfo({
    Key? key,
    required this.aboutMeBean,
  }) : super(key: key);

  final AboutMeBean? aboutMeBean;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: aboutMeBean?.avatar ?? '',
            errorWidget: (context, url, error) => Container(),
            placeholder: (context, url) => Container(),
            fit: BoxFit.cover,
            width: AppDimens.avatarSize,
            height: AppDimens.avatarSize,
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        Text(
          aboutMeBean?.nickname ?? '',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: Theme.of(context).textTheme.headline6?.fontSize,
              ),
        ),
        const SizedBox(height: AppDimens.marginHalf),
        Text(
          aboutMeBean?.signature ?? '',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
              ),
        ),
      ],
    );
  }
}

class QrCodeItem extends StatelessWidget {
  QrCodeItem({
    required this.url,
  }) : super(key: ValueKey(url));

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.marginSmall),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.radiusNormal),
          child: AspectRatio(
            aspectRatio: 3.0 / 4.0,
            child: CachedNetworkImage(
              imageUrl: url,
              errorWidget: (context, url, error) => Container(),
              placeholder: (context, url) => Container(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
