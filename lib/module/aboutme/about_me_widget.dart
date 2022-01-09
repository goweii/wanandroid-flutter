import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:wanandroid/api/com/bean/about_me_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

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

class AboutMeAppBar extends StatelessWidget {
  const AboutMeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      title: Text(Strings.of(context).about_me),
      toolbarHeight: themeData.appBarTheme.toolbarHeight,
      titleTextStyle: themeData.appBarTheme.titleTextStyle?.copyWith(
        color: themeData.colorScheme.onSurface,
      ),
      iconTheme: themeData.appBarTheme.iconTheme?.copyWith(
        color: themeData.colorScheme.onSurface,
      ),
      backgroundColor: Colors.transparent,
      systemOverlayStyle: themeData.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
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
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: AppDimens.marginHalf),
        Text(
          aboutMeBean?.signature ?? '',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class QrCodePager extends StatelessWidget {
  const QrCodePager({
    Key? key,
    required this.viewportFraction,
    required this.scrollDirection,
    required this.aboutMeBean,
  }) : super(key: key);

  final double viewportFraction;
  final Axis scrollDirection;
  final AboutMeBean? aboutMeBean;

  @override
  Widget build(BuildContext context) {
    return Swiper.children(
      key: UniqueKey(),
      scrollDirection: scrollDirection,
      viewportFraction: viewportFraction.clamp(0.1, 0.8),
      scale: 0.9,
      children: [
        QrCodeItem(url: aboutMeBean?.wxQrcode ?? ''),
        QrCodeItem(url: aboutMeBean?.zfbQrcode ?? ''),
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
