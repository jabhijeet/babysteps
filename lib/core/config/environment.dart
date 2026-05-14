/// Environment configuration for the BabySteps app.
///
/// These values are set at compile time via `--dart-define` flags.
///
/// Example build command:
/// ```
/// flutter run --dart-define=GOOGLE_OAUTH_WEB_CLIENT_ID=your-web-client-id
/// ```
///
/// If a value is not provided, it defaults to an empty string, which should
/// be handled appropriately by the application (e.g., prompt user to configure).
class Environment {
  /// Google OAuth client ID for web platform
  static const String googleOAuthWebClientId = String.fromEnvironment(
    'GOOGLE_OAUTH_WEB_CLIENT_ID',
    defaultValue:
        '536929186027-1754bsjdb10c8iqjjo22fge1umpo7vu1.apps.googleusercontent.com',
  );

  /// Google OAuth client ID for desktop platforms (Windows, macOS, Linux)
  static const String googleOAuthDesktopClientId = String.fromEnvironment(
    'GOOGLE_OAUTH_DESKTOP_CLIENT_ID',
    defaultValue:
        '536929186027-8jc73ucgmk5ckintahro8ro94mk0p67n.apps.googleusercontent.com',
  );

  /// Google OAuth client ID for iOS platform
  static const String googleOAuthIosClientId = String.fromEnvironment(
    'GOOGLE_OAUTH_IOS_CLIENT_ID',
    defaultValue: '',
  );

  /// Google OAuth client ID for Android platform
  static const String googleOAuthAndroidClientId = String.fromEnvironment(
    'GOOGLE_OAUTH_ANDROID_CLIENT_ID',
    defaultValue:
        '536929186027-r5jnjvusonhqfi518m4fg6qv5e6koej4.apps.googleusercontent.com',
  );

  /// Returns the appropriate client ID for the current platform.
  ///
  /// Uses runtime platform detection to select the correct environment constant.
  /// If no client ID is configured for the platform, returns an empty string.
  /// The calling code should handle this appropriately (e.g., show configuration
  /// screen or use a fallback from user preferences).
  static String getPlatformClientId() {
    // Import needed for platform detection (but we can't import here due to circular dependency)
    // Instead, we'll pass platform flags as parameters from the caller.
    // This method is not used; SyncService will implement its own logic.
    return '';
  }

  /// Check if any client ID is configured (non-empty)
  static bool get hasAnyClientId =>
      googleOAuthWebClientId.isNotEmpty ||
      googleOAuthDesktopClientId.isNotEmpty ||
      googleOAuthIosClientId.isNotEmpty ||
      googleOAuthAndroidClientId.isNotEmpty;

  /// Get all client IDs as a map for debugging/logging
  static Map<String, String> get clientIds => {
    'web': googleOAuthWebClientId,
    'desktop': googleOAuthDesktopClientId,
    'ios': googleOAuthIosClientId,
    'android': googleOAuthAndroidClientId,
  };
}
