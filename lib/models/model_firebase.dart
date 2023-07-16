class ModelFirebase {
  String image;
  String turkishName;
  String latinceName;
   String subTitle;
  double popular;
  double potCompatibility;
  double needCare;
  double homeSuitable;

  ModelFirebase({
    required this.image,
    required this.turkishName,
    required this.latinceName,
     required this.subTitle,
    required this.popular,
    required this.potCompatibility,
    required this.needCare,
    required this.homeSuitable,
  });

  factory ModelFirebase.fromJson(Map<String, dynamic> json) {
    return ModelFirebase(
      image: json['image'],
      turkishName: json['turkishName'],
      latinceName: json['latinceName'],
      subTitle: json['subTitle'],
      popular: json['popular'],
      potCompatibility: json['potCompatibility'],
      needCare: json['needCare'],
      homeSuitable: json['homeSuitable'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['turkishName'] = turkishName;
    data['latinceName'] = latinceName;
    data['subTitle'] = subTitle;
    data['popular'] = popular;
    data['potCompatibility'] = potCompatibility;
    data['needCare'] = needCare;
    data['homeSuitable'] = homeSuitable;
    return data;
  }
}
