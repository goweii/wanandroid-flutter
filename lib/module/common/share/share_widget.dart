import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/utils/string_utils.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({
    Key? key,
    required this.cover,
    required this.title,
    required this.desc,
    required this.link,
  }) : super(key: key);

  final String? cover;
  final String title;
  final String desc;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (cover != null && cover!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: cover!,
              fit: BoxFit.fill,
            ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.marginNormal),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringUtils.simplifyToSingleLine(title),
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimens.marginSmall),
                      Text(
                        StringUtils.simplifyToSingleLine(desc),
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimens.marginHalf),
                QrImage(
                  data: link,
                  version: QrVersions.auto,
                  padding: const EdgeInsets.all(AppDimens.marginSmall),
                  backgroundColor: Colors.white,
                  size: 85,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCoverSelector extends StatelessWidget {
  const ShareCoverSelector({
    Key? key,
    required this.height,
    required this.imgs,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final double height;
  final List<String> imgs;
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginHalf,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: imgs.length + 1,
          itemBuilder: (context, index) {
            return _CoverItem(
              size: height,
              cover: index == 0 ? '' : imgs[index - 1],
              selected: (this.index >= 0 && this.index < imgs.length)
                  ? this.index == index - 1
                  : index == 0,
              onPressed: () => onTap(index - 1),
            );
          },
        ),
      ),
    );
  }
}

class _CoverItem extends StatelessWidget {
  const _CoverItem({
    Key? key,
    required this.cover,
    required this.size,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  final String cover;
  final double size;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginHalf),
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusNormal)),
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusNormal),
              child: cover.isNotEmpty
                  ? CachedNetworkImage(
                      width: size,
                      height: size,
                      imageUrl: cover,
                      fit: BoxFit.cover,
                    )
                  : _NoCover(size: size),
            ),
            if (selected)
              Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _NoCover extends StatelessWidget {
  const _NoCover({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.close_rounded,
        size: size * 0.6,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      ),
    );
  }
}
