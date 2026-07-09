import 'package:flutter/material.dart';

typedef RouteWidgetBuilder = Widget Function(BuildContext);

final Map<String, RouteWidgetBuilder> appRoutes = {};
