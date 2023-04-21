import 'package:flutter/material.dart';
import 'package:user_login/models/banner_list_model.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key, required this.bannerListModel});
  final Rx<BannerListModel> bannerListModel;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: bannerListModel.value.bannerList?.length ?? 0,
        itemBuilder: (context, index, realIndex) {
          final item = bannerListModel.value.bannerList?[index];
          return Card(
              margin: const EdgeInsets.all(6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  item?.bannerImage ?? '',
                  fit: BoxFit.fill,
                ),
              ));
        },
        options: CarouselOptions(
            aspectRatio: 16 / 8,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3)));
  }
}
