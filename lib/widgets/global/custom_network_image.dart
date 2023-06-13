import 'package:flutter/cupertino.dart';

/// [CustomNetworkImage] is a [StatelessWidget] that displays an image from a network URL.
///
/// If the image at the provided URL fails to load, a placeholder image is displayed instead.
/// The placeholder image path is provided as a parameter.
///
/// Example usage:
/// ```dart
/// CustomNetworkImage(
///   url: 'http://example.com/image.jpg',
///   placeholder: 'assets/images/placeholder.png',
/// )
/// ```
class CustomNetworkImage extends StatelessWidget {
  /// The URL of the image to be displayed.
  final String url;
  /// The asset path of the placeholder image to be displayed when the image at [url] fails to load.
  final String placeholder;

  /// Creates a [CustomNetworkImage] with the given [url] and [placeholder].
  ///
  /// The [placeholder] parameter defaults to `'assets/images/placeholder.png'` if not provided.
  const CustomNetworkImage({required this.url, this.placeholder = 'assets/images/placeholder.png'});

  /// Describes the part of the user interface represented by this widget.
  ///
  /// Attempts to display an image from the network. If the image fails to load,
  /// it displays a placeholder image from the local assets.
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // If the network image fails to load, return a placeholder image from the assets.
        return Image.asset(placeholder);
      },
    );
  }
}
