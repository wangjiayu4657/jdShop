import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key, required this.url, this.placeholder}) : super(key: key);

  final String url;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: url,
      placeholder: placeholder ?? "assets/images/placeholder.png",
      fit: BoxFit.cover,
    );
  }
}
