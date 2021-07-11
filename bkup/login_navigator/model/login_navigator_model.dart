class LoginNavigatorModel {
  static const intro = 'intro';
  static const login = 'login';
  static const saveKeys = 'saveKeys';
  static const restoreKeys = "restoreKeys";
  static const createKeys = 'saveKeys';

  bool canContinue = false;
  bool keysCreated = false;

  var currentScreen = createKeys;
}
