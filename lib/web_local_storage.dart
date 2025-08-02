@JS('window.localStorage')
library local_storage;

import 'package:js/js.dart';

@JS()
external String? getItem(String key);

@JS()
external void setItem(String key, String value);