import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ImagesData extends HiveObject {
  @HiveField(0)
  final List<int> imagesData;
  ImagesData({required this.imagesData});
}
