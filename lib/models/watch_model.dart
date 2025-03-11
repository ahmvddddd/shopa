import '../utils/constants/image_strings.dart';

class WatchModel {
  final String watchImage;
  final String watchName;
  final String watchPrice;

  WatchModel({
    required this.watchImage,
    required this.watchName,
    required this.watchPrice,
  });
}

final watches = [
  WatchModel(watchImage: Images.hublot1, watchName: 'Hublot Blach Magic', watchPrice: '110,000'),
  WatchModel(watchImage: Images.hublot2, watchName: 'Hublot Unico Ice Bang', watchPrice: '24,000'),
  WatchModel(watchImage: Images.hublot3, watchName: 'Hublot Chronograph Magic', watchPrice: '12,000'),
  WatchModel(watchImage: Images.hublot4, watchName: 'Hublot Turillion Sorai', watchPrice: '110,000'),
  WatchModel(watchImage: Images.hublot5, watchName: 'Hublot Big Bang', watchPrice: '120,000'),
];