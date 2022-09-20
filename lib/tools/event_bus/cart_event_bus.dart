import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class CartEventBus {
  String? text;
  CartEventBus({this.text});
}