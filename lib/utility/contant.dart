class Constant {
  var kTitle = "Home Page";

  static late Constant _instance;

  static Constant get instance {
    _instance = Constant._init();
    return _instance;
  }

  Constant._init();
}
