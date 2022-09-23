extension ObjectMap on Object {
  //将其他类型转为double类型
  double mapToDouble(dynamic val){
    if(val is int){
      return val.toDouble();
    } else if (val is double) {
      return val;
    } else {
      return double.parse(val);
    }
  }

  //将其他类型转为int类型
  int mapToInt(dynamic val) {
    if(val is int){
      return val;
    } else if (val is double) {
      return val.toInt();
    } else {
      return int.parse(val);
    }
  }
}