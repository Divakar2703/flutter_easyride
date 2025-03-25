# Keep Google Pay classes
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
-keep class com.google.android.gms.wallet.** { *; }
-keep class com.google.android.gms.common.** { *; }

# Keep Razorpay specific classes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
