import 'package:flutter/material.dart';

class FadeInNetworkImage extends StatelessWidget {
  final String urlImage;
  final String stationName;

  const FadeInNetworkImage({
    required this.stationName,
    required this.urlImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const errorImageUrl =
        "https://static.thenounproject.com/png/504708-200.png";

    return Hero(
      tag: stationName,
      child: FadeInImage(
        fit: BoxFit.cover,
        image: NetworkImage(urlImage.isNotEmpty ? urlImage : errorImageUrl),
        placeholder: const AssetImage("assets/loading.gif"),
      ),
    );
  }
}
