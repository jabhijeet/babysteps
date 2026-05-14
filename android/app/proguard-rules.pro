# Flutter/Dart obfuscation rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.FlutterActivity { *; }
-keep class io.flutter.embedding.android.FlutterActivity { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.FlutterApplication { *; }

# Keep all Dart classes for Flutter
-keep class io.flutter.plugins.** { *; }

# Sentry Flutter
-keep class io.sentry.** { *; }
-keep interface io.sentry.** { *; }
-keep class com.getsentry.** { *; }
-dontwarn io.sentry.**
-dontwarn com.getsentry.**

# Google Sign In
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Flutter Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Image Picker
-keep class io.flutter.plugins.imagepicker.** { *; }

# Workmanager
-keep class com.enrique.drnq.** { *; }
-keep class dev.fluttercommunity.workmanager.** { *; }

# Background Fetch
-keep class com.transistorsoft.flutter.backgroundfetch.** { *; }

# Drift / SQLite
-keep class com.tencent.mmkv.** { *; }
-dontwarn org.sqlite.**

# Keep all data classes (Drift models, etc.)
-keep class **.database.** { *; }

# Keep JSON serialization classes
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep enum values method
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep classes that are serialized/deserialized with Gson
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod

# Suppress warnings for missing classes
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# Flutter Deferred Components / Play Core dependencies
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
