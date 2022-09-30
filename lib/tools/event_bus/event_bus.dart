import 'package:event_bus/event_bus.dart';
import 'package:jdShop/pages/Login/models/user_model.dart';

EventBus eventBus = EventBus();

class CartEventBus {
  String? text;
  CartEventBus({this.text});
}

class LoginEventBus {
  UserModel? user;
  LoginEventBus({this.user});
}

class LogoutEventBus {

}