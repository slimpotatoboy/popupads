import 'package:flutter/material.dart';
import 'package:popupads/src/dialog_box.dart';

class PopupAds extends StatelessWidget {
  const PopupAds({
    Key? key,
    required this.images,
    this.fromNetwork = false,
    required this.onClose,
    required this.dotActiveColor,
    required this.dotInactiveColor,
    this.bannerOpen = true,
  }) : super(key: key);

  final List images;
  final bool? fromNetwork;
  final Function onClose;
  final Color dotActiveColor;
  final Color dotInactiveColor;
  final bool bannerOpen;

  @override
  Widget build(BuildContext context) {
    /// opens [Dialog] box
    return DialogBox(
      images: images,
      fromNetwork: fromNetwork!,
      onBannerClose: onClose,
      dotActiveColor: dotActiveColor,
      dotInactiveColor: dotInactiveColor,
      bannerOpen: bannerOpen,
    );
  }
}
