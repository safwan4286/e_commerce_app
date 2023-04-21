class BannerListModel {
  String? flag;
  String? message;
  List<BannerList>? bannerList;

  BannerListModel({this.flag, this.message, this.bannerList});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
    if (json['banner_list'] != null) {
      bannerList = <BannerList>[];
      json['banner_list'].forEach((v) {
        bannerList!.add(BannerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag'] = flag;
    data['message'] = message;
    if (bannerList != null) {
      data['banner_list'] = bannerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerList {
  String? bannerId;
  String? bannerImage;

  BannerList({this.bannerId, this.bannerImage});

  BannerList.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_image'] = bannerImage;
    return data;
  }
}
