import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../tools/share/user_manager.dart';

class ProviderService  {
  static List<SingleChildWidget> providers = [
    // Provider(create: (ctx) => UserManager.instance),
  ];
}