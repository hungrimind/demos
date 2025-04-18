// url_strategy_web.dart (used on web only)
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}