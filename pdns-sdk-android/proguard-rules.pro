-dontshrink
#-dontoptimize
#-dontpreverify
#-verbose

#--------------------------1.实体类---------------------------------
##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-keep class sun.misc.Unsafe { *; }
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson

# Explicitly preserve all serialization members. The Serializable interface
# is only a marker interface, so it wouldn't save them.
-keepclassmembers class * implements java.io.Serializable {
static final long serialVersionUID;
private static final java.io.ObjectStreamField[] serialPersistentFields;
private void writeObject(java.io.ObjectOutputStream);
 private void readObject(java.io.ObjectInputStream);
 java.lang.Object writeReplace();
java.lang.Object readResolve();
}
-keep public class * implements java.io.Serializable {*;}
-dontwarn com.google.gson.**
-keep class com.google.gson.** {*;}
-keep class okhttp3.**{*;}
-keep class org.chromium.**{*;}
-keep class okio.**{*;}

##---------------End: proguard configuration for Gson  ----------



#--------------------------2.第三方包-------------------------------
#butterknife
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }

#-------------------------3.与js互相调用的类------------------------


#-------------------------4.反射相关的类和方法----------------------


#-------------------------5.基本不用动区域--------------------------
#指定代码的压缩级别
-optimizationpasses 5

#包明不混合大小写
-dontusemixedcaseclassnames

#不去忽略非公共的库类
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers

#混淆时是否记录日志
-verbose

#优化  不优化输入的类文件
-dontoptimize

#预校验
-dontpreverify

# 保留sdk系统自带的一些内容 【例如：-keepattributes *Annotation* 会保留Activity的被@override注释的onCreate、onDestroy方法等】
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

# 记录生成的日志数据,gradle build时在本项根目录输出
# apk 包内所有 class 的内部结构
#-dump proguard/class_files.txt
# 未混淆的类和成员
#-printseeds proguard/seeds.txt
# 列出从 apk 中删除的代码
#-printusage proguard/unused.txt
# 混淆前后的映射
#-printmapping proguard/mapping.txt
# 避免混淆泛型
-keepattributes Signature
# 抛出异常时保留代码行号,保持源文件以及行号
-keepattributes SourceFile,LineNumberTable

#-----------------------------6.默认保留区-----------------------
# 保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

-keepclassmembers public class * extends android.view.View {
 public <init>(android.content.Context);
 public <init>(android.content.Context, android.util.AttributeSet);
 public <init>(android.content.Context, android.util.AttributeSet, int);
 public void set*(***);
}

# 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context,android.util.AttributeSet);
}
# 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context,android.util.AttributeSet,int);
}
# 保持自定义控件类不被混淆
-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);
}

# 保持枚举 enum 类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# 不混淆R文件中的所有静态字段，我们都知道R文件是通过字段来记录每个资源的id的，字段名要是被混淆了，id也就找不着了。
-keepclassmembers class **.R$* {
    public static <fields>;
}

#如果引用了v4或者v7包
-dontwarn android.support.**

# 保持哪些类不被混淆
-keep public class * extends android.app.Appliction
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.preference.Preference
-keep public class * extends android.database.sqlite.SQLiteOpenHelper

-keep class com.alibaba.pdns.net.HttpRequestAysnc { public *; }
-keep class com.alibaba.pdns.DNSResolver { public *; }
-keep class com.alibaba.pdns.model.DomainRttModel { public *; }
-keep class com.alibaba.pdns.DomainInfo { public *; }
-keep class com.alibaba.pdns.sp.SPUtils { public *;}
-keep class com.alibaba.pdns.net.HttpTrustManager { public *;}
-keep class com.alibaba.pdns.net.HttpsHostnameVerifier { public *;}
-keep class com.alibaba.pdns.net.HttpsNotCheckVerifier { public *;}
-keep class com.alibaba.pdns.JsonUitl { *** objectToString(...);}
-keep class com.alibaba.pdns.jni.Jni {*;}

-keepnames class com.alibaba.pdns.model.DomainRttModel {
    private <fields>;
    public <methods>;
}

-keepnames class com.alibaba.pdns.model.DomainRttModel$* {
    private <fields>;
    public <methods>;
}

-keepnames class com.alibaba.pdns.model.ReportDomanInfo {
    private <fields>;
    public <methods>;
}

-keepnames class com.alibaba.pdns.model.ReportDomanInfo* {
    private <fields>;
    public <methods>;
}

-keepclassmembers class * {
    public void run();
}
-keepclassmembers class * {
    public java.lang.Thread newThread(java.lang.Runnable);
}

-keepclassmembers class * {
    public int compare(...);
}

-keepclassmembers class * {
    public void onReceive(android.content.Context, android.content.Intent);
}

-keepclassmembers class * {
    public void onCreate(android.database.sqlite.SQLiteDatabase);
    public void onUpgrade(android.database.sqlite.SQLiteDatabase, int, int);
}

###############################去掉所有打印
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** e(...);
    public static *** i(...);
    public static *** v(...);
    public static *** println(...);
    public static *** w(...);
    public static *** wtf(...);
}
-assumenosideeffects class android.util.Log {
   public static *** d(...);
   public static *** v(...);
}

-assumenosideeffects class android.util.Log {
    public static *** e(...);
    public static *** v(...);
}

-assumenosideeffects class android.util.Log {
    public static *** i(...);
    public static *** v(...);
}

-assumenosideeffects class android.util.Log {
    public static *** w(...);
    public static *** v(...);
}
-assumenosideeffects class java.io.PrintStream {
    public *** println(...);
    public *** print(...);
}

-ignorewarnings
