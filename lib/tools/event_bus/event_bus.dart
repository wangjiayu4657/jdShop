import 'package:event_bus/event_bus.dart';
import 'package:jdShop/pages/Login/models/user_model.dart';

EventBus eventBus = EventBus();

//购物车
class CartEventBus {
  String? text;
  CartEventBus({this.text});
}

//登录
class LoginEventBus {
  UserModel? user;
  LoginEventBus({this.user});
}

//退出登录
class LogoutEventBus {

}

//地址
class AddressEventBus {

}
