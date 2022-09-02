import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key,this.imageUrl}) : super(key: key);

  final String? imageUrl;
  static const String placeholder = "assets/images/placeholder.png";

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      image: imageUrl ?? "",
      fit: BoxFit.cover,
    );
  }
}
