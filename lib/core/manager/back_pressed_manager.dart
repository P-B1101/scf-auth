class BackPressedManager {
  bool Function()? onBackPressed;
  BackPressedManager._();

  factory BackPressedManager.init() => BackPressedManager._();

  void dispose() => onBackPressed = null;
}
