import 'package:flutter_bili_app/provider/theme_provider.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> topProvider = [
  ChangeNotifierProvider(create: (_) => ThemeProvider())
];
