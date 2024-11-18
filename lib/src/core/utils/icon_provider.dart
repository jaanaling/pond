enum IconProvider {
  alert(imageName: 'alert.png'),
  error(imageName: 'error.png'),
  fish(imageName: 'fish.png'),
  back(imageName: 'back.png'),
  logo(imageName: 'logo.png'),
  splash(imageName: 'splash.png'),
  decor(imageName: 'decor.png'),
  noPhoto(imageName: "no_photo.png"),

  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
