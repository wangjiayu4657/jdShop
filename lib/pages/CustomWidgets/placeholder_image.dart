import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({
    Key? key,
    required this.url,
    this.placeholder,
    this.padding,
    this.fit
  }) : super(key: key);

  final String? url;
  final String? placeholder;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: url == null ?
      buildPlaceholderImage() :
      FadeInImage.assetNetwork(
        image: url!,
        placeholder: placeholder ?? "assets/images/placeholder.png",
        fit: fit ?? BoxFit.cover,
      ),
    );
  }

  Widget buildPlaceholderImage() {
    return const FadeInImage(
      placeholder: AssetImage("assets/images/placeholder.png"),
      image: AssetImage("assets/images/placeholder.png"),
      fit: BoxFit.contain,
    );
  }

}
