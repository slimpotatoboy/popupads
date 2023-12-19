import 'dart:async';
import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    Key? key,
    required this.images,
    required this.fromNetwork,
    required this.onBannerClose,
    required this.dotActiveColor,
    required this.dotInactiveColor,
    required this.bannerOpen,
  }) : super(key: key);

  final List images;
  final bool fromNetwork;
  final Function onBannerClose;
  final Color dotActiveColor;
  final Color dotInactiveColor;
  final bool bannerOpen;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  // scroll controller
  PageController? controller;
  // current image index
  int currentIndex = 0;
  Timer? timer;

  void incrementCurrent(int position) {
    setState(() {
      if (currentIndex <= widget.images.length - 1) {
        currentIndex = position;
      } else {
        currentIndex = 0;
      }
    });
  }

  void onChange(int? position) {
    if (position != null) {
      incrementCurrent(position);
    }
  }

  void initializeTimer() async {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (currentIndex <= widget.images.length - 2) {
        controller?.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        controller?.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.images.isNotEmpty) {
      controller = PageController(
        initialPage: 0,
      );
      initializeTimer();
    }
    // if (widget.autoSlide) {
    // }
  }

  @override
  void dispose() {
    if (widget.images.isNotEmpty) {
      controller?.dispose();
      timer?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.images.isNotEmpty && widget.bannerOpen
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: Wrap(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 500,
                        height: 350,
                        child: PageView.builder(
                          controller: controller,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.images.length,
                          onPageChanged: (position) => onChange(position),
                          itemBuilder: (context, index) {
                            final item = widget.images[index];
                            // if the image is from the internet
                            if (widget.fromNetwork) {
                              return Image.network(
                                item,
                                width: 500,
                                fit: BoxFit.contain,
                              );
                            } else {
                              // if images is local
                              return Image.asset(
                                item,
                                width: 500,
                                fit: BoxFit.contain,
                              );
                            }
                          },
                        ),
                      ),
                      if (widget.images.length > 1)
                        Positioned(
                          left: 50,
                          bottom: 0,
                          child: _dotProgress(),
                        ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            widget.onBannerClose();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // actions: [],
            ),
          )
        : Container();
  }

  Widget _dotProgress() {
    return Container(
      width: 100,
      height: 8,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.images.length,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _dotItem(index);
        },
      ),
    );
  }

  Widget _dotItem(int index) {
    return Container(
      height: 12,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: currentIndex == index
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: widget.dotActiveColor,
            )
          : BoxDecoration(
              shape: BoxShape.circle,
              color: widget.dotInactiveColor,
            ),
    );
  }
}
