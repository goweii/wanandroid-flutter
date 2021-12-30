import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';

class BannerView extends StatefulWidget {
  const BannerView({
    Key? key,
    required this.banners,
  }) : super(key: key);

  final List<BannerBean> banners;

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            widget.banners[index].imagePath,
            fit: BoxFit.cover,
          );
        },
        itemCount: widget.banners.length,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            size: 6.0,
            activeSize: 6.0,
          ),
        ),
        autoplay: true,
        autoplayDelay: 5000,
        autoplayDisableOnInteraction: true,
      ),
    );
  }
}
