[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart) 

Implementation of [flutter_connectivity](https://github.com/Iconica-Development/flutter_connectivity_hook) in conjuction with [flutter_hooks](https://pub.dev/packages/flutter_hooks)



Package that can be used to check for an internet connection in your application

Figma Design that defines this component (only accessible for Iconica developers): https://www.figma.com/file/4WkjwynOz5wFeFBRqTHPeP/Iconica-Design-System?type=design&node-id=516%3A1847&mode=design&t=XulkAJNPQ32ARxWh-1
Figma clickable prototype that demonstrates this component (only accessible for Iconica developers): https://www.figma.com/proto/4WkjwynOz5wFeFBRqTHPeP/Iconica-Design-System?type=design&node-id=340-611&viewport=-4958%2C-31%2C0.33&t=XulkAJNPQ32ARxWh-0&scaling=min-zoom&starting-point-node-id=516%3A3402&show-proto-sidebar=1

## Setup

See [example](./example/lib/main.dart) app for a guide

Make sure to also add 
```yaml
flutter_hooks: ...
```
to your pubspec.yaml

## How to use

Using the default handler for Flutter
```dart
  useConnectivity(
    context: context,
    fallBackScreen: const NoInternetScreen(),
  );// Screen to show when no internet has been detected. NoInternetScreen is a screen provided by this package but any can be used.
);
``` 
Make sure to call this somewhere in the app where there is a navigator in your context when using the default handler.

Configuration can be customzied using the following method:
```dart
  useConnectivity(
      context: context,
      fallBackScreen: const NoInternetScreen(),
      config: ConnectivityConfig(
        url: 'www.iconica.nl',
        handler: CustomHandler(),
        checker: CustomInternetChecker(),
      ),
    );
```

CustomHandler and CustomInterChecker are implementations of an abstract class, which look something like:

```dart
class CustomHandler implements ConnectivityHandler {
  @override
  void onConnectionLost() {
    debugPrint('Connection lost');
  }

  @override
  void onConnectionRestored() {
    debugPrint('Connection restored');
  }
}
```

```dart
class CustomInternetChecker implements ConnectivityChecker {
  @override
  Future<bool> checkConnection() async {
    try {
      var result = await InternetAddress.lookup('google.nl');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
```

When using a custom handler, the instance can be started without the context and fallBackScreen parameters
```dart
    useConnectivity(
      config: ConnectivityConfig(
        url: 'www.iconica.nl',
        handler: CustomHandler(),
        checker: CustomInternetChecker(),
      ),
    );
```

For a complete overview of how to use it look at the [example](./example/lib/main.dart) app


## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_connectivity_hook) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

Make sure when updating either [flutter_connectivity](https://github.com/Iconica-Development/flutter_connectivity) or [flutter_connectivity_hook](https://github.com/Iconica-Development/flutter_connectivity_hook) to keep the versioning in sync.

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_connectivity_hook/pulls).

## Author

This flutter_connectivity package for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>