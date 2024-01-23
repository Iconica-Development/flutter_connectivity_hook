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

class _UseConnectivity extends Hook<void> {
  const _UseConnectivity({
    this.context,
    this.config,
    this.fallBackScreen,
    this.displayType,
  });

  final BuildContext? context;
  final ConnectivityConfig? config;
  final Widget? fallBackScreen;
  final ConnectivityDisplayType? displayType;

  @override
  _UseConnectivityState createState() => _UseConnectivityState();
}

class _UseConnectivityState extends HookState<void, _UseConnectivity> {
  @override
  void initHook() {
    super.initHook();

    Connectivity.instance.start(
      context: hook.context,
      fallBackScreen: hook.fallBackScreen,
      connectivityDisplayType: hook.displayType,
    );

    if (hook.config != null) {
      Connectivity.instance.setCustomConfig(hook.config!);
    }
  }

  @override
  void build(BuildContext context) {}
}
