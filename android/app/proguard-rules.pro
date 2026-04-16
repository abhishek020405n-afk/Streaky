# ProGuard rules for Streaky
# Keep Flutter SDK classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Keep Hive database
-keep class com.google.protobuf.** { *; }

# Keep Google Mobile Ads SDK
-keep public class com.google.android.gms.ads.** {
    public *;
}

# Keep serialization classes
-keep class **.models.** { *; }
-keep class **.entities.** { *; }

# Keep view constructors for inflation
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
}

# Preserve line numbers for crash reports
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
