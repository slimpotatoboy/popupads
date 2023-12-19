# Popup Banner for Flutter

Popup banner is a Flutter Widget Package to show banners/ads in your flutter app using modal dialog. Popup Banner helps to show modal images of either local or network images.

## Features

- Show single or multiple asset or network images
- Custom Dot Indicator Colors
- Slidable Images Banner

## Getting started

To use this plugin, add `popupbanner` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels) 🔗.

```yaml
dependencies:
  popupbanner: ^1.0.0
```

## Usage

<img src="https://dipenmaharjan.com.np/png/popup.png" width="200">

```dart
bool isActive = true;

PopupBanner(
    images: [
        'assets/images/slimpotatoboy.png',
        'assets/images/slimpotatoboy2.png'
    ],
    onClose: () {
        setState((){
            isActive =false;
        })
    },
    dotActiveColor: Colors.red,
    dotInactiveColor: Colors.black,
    bannerOpen: isActive,
),
```

## 🚀 Contributors

- [Dipen Maharjan](https://dipenmaharjan.com.np/)

---

**Any new Contributors are welcomed.**

- Feel Free to request any missing features or report issues [here](https://github.com/slimpotatoboy/popupbanner/issues) 🔗.
- Feel Free to contribute [here](https://github.com/slimpotatoboy/popupbanner/pulls) 🔗.
