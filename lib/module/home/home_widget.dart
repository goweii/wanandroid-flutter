import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';
import 'package:wanandroid/widget/image_placeholder.dart';

class BannerView extends StatefulWidget {
  const BannerView({
    Key? key,
    required this.banners,
    this.scrollDirection = Axis.horizontal,
    this.viewportFraction = 1.0,
  }) : super(key: key);

  final List<BannerBean> banners;
  final Axis scrollDirection;
  final double viewportFraction;

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      key: UniqueKey(),
      viewportFraction: widget.viewportFraction,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: widget.banners[index].imagePath,
          fit: BoxFit.cover,
          placeholder: (context, url) => const ImagePlaceholder(),
          errorWidget: (context, url, error) => const ImagePlaceholder(),
        );
      },
      itemCount: widget.banners.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          size: 6.0,
          activeSize: 6.0,
          color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
          activeColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      autoplay: true,
      autoplayDelay: 5000,
      autoplayDisableOnInteraction: true,
      onTap: _handleTap,
    );
  }

  _handleTap(int index) {
    var data = widget.banners[index];
    AppRouter.of(context).pushNamed(
      RouteMap.articlePage,
      arguments: ArticleInfo(
        id: data.id,
        cover: data.imagePath,
        link: data.url,
        title: data.title,
        author: null,
      ),
    );
  }
}
