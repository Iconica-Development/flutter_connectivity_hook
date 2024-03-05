import 'package:flutter/widgets.dart';
import 'package:flutter_connectivity/flutter_connectivity.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

var useConnectivity = ({
  BuildContext? context,
  ConnectivityConfig? config,
  Widget? fallBackScreen,
  ConnectivityDisplayType? displayType,
}) =>
    use(
      _UseConnectivity(
        context: context,
        config: config,
        fallBackScreen: fallBackScreen,
        displayType: displayType,
      ),
    );

/// A hook that provides connectivity status to the application.
class _UseConnectivity extends Hook<void> {
  const _UseConnectivity({
    this.context,
    this.config,
    this.fallBackScreen,
    this.displayType,
  });

  /// The build context of the widget.
  final BuildContext? context;

  /// The connectivity configuration.
  final ConnectivityConfig? config;

  /// The fallback screen widget to be displayed when there's no connectivity.
  final Widget? fallBackScreen;

  /// The type of connectivity display.
  final ConnectivityDisplayType? displayType;

  @override
  _UseConnectivityState createState() => _UseConnectivityState();
}

/// A private class `_UseConnectivityState` that extends the `HookState` class.
/// This class is used to manage the state of the `_UseConnectivity` hook.
class _UseConnectivityState extends HookState<void, _UseConnectivity> {
  /// This method is called when the hook is first inserted into the tree.
  /// It sets up the initial configuration for the `Connectivity` instance.
  @override
  void initHook() {
    super.initHook();

    /// If the hook has a custom configuration, it is set here.
    if (hook.config != null) {
      Connectivity.instance.setCustomConfig(hook.config!);
    }

    /// Starts the `Connectivity` instance with the provided context,
    /// fallback screen, and display type.
    Connectivity.instance.start(
      context: hook.context,
      fallBackScreen: hook.fallBackScreen,
      connectivityDisplayType: hook.displayType,
    );
  }

  @override
  void build(BuildContext context) {}
}
