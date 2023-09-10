import 'package:productmanage/models/users.dart';
import 'package:productmanage/models/products.dart';

class Configure {
  static const server = "192.168.229.1:3000";
  static Users login = Users();
  static List<String> gender = ["None", "Male", "Female"];
}

class ConfigureTwo {
  static const server = "192.168.31.1:3000";
  static Products inventory = Products();
  static List<String> rating= ["0.0", "0.5", "1.0","1.5", "2.0", "2.5", "3.0", "3.5","4.0", "4.5", "5.0"];
}