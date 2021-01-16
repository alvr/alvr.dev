---
title: How to add advertising to your Android app
subtitle: Easily add AdMob advertising to your Android app
description: Easily add AdMob advertising to your Android app.

date: 2014-04-01T12:20:00+02:00
categories:
  - Android
  - Programming
tags:
  - admob
  - advertising
  - android advertising

image: /images/posts/2014/admob/admob-logo.webp
translationKey: android-admob
slug: android-admob
---
{{< notice warning "Deprecated" >}}
This tutorial is from **2014** and is not compatible with new versions of the AdMob SDK. For a more updated version, visit Google's [guide](https://developers.google.com/admob/android/quick-start?hl=en).
{{< /notice >}}

In this tutorial I will teach you how to add advertising to your Android applications. The system I will use will be AdMob, as it is the best in its category but there are also alternatives, such as InMobi, MobFox...

<!--more-->

The first thing to do is to register the application on the [AdMob page](https://apps.admob.com/). If you already had an old account you can import the data, otherwise add a new application. If you already have the application published in the Play Store, just search for it and it will be added automatically. Otherwise, you will have to add it manually.

{{< img src="/images/posts/2014/admob/panel.webp" caption="Applications in AdMob" >}}

When we have created it we go to our project in Android Studio and open the file `build.gradle`. Inside we go to the section `dependencies` and add the next line to those already there:

```groovy:build.gradle
compile 'com.google.android.gms:play-services:11.0.0'
```

Just like this:

```groovy:build.gradle
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar', '*.aar'])
    compile 'com.google.android.gms:play-services:11.0.0'
    ...
}
```

And we synchronize Gradle by pressing the Sync Project button: ![Synchronize Project](https://developer.android.com/images/tools/sync-project.png)

Now we open the AndroidManifest.xml file and add the following lines above `</application>`:

```xml:AndroidManifest.xml
<meta-data android:name="com.google.android.gms.version"
    android:value="@integer/google_play_services_version" />
<activity android:name="com.google.android.gms.ads.AdActivity"
    android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
    android:theme="@android:style/Theme.Translucent" />
```

Before the `<application>` tag we add the necessary permissions to display the ads:

```xml:AndroidManifest.xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

Now we are going to create a 'LinearLayout' that will contain our banner, leaving it like this:

```xml:activity_main.xml
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_weight="1"
    android:gravity="bottom"
    android:orientation="vertical" >

    <com.google.android.gms.ads.AdView
        android:id="@+id/ads"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        ads:adSize="SMART_BANNER"
        ads:adUnitId="@string/admob" >
    </com.google.android.gms.ads.AdView>
</LinearLayout>
```

With this configuration the banner will appear in the footer of the application. For example if we want to use it in a `DrawerLayout` that uses `Fragment` and `NavigationView`, the design would look like this:

```xml:activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.v4.widget.DrawerLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:ads="http://schemas.android.com/apk/res-auto"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:fitsSystemWindows="true"
    tools:context=".MainActivity">

    <FrameLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:id="@+id/main_layout" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:gravity="bottom"
        android:orientation="vertical" >

        <com.google.android.gms.ads.AdView
            android:id="@+id/ads"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            ads:adSize="SMART_BANNER"
            ads:adUnitId="@string/admob" >
        </com.google.android.gms.ads.AdView>
    </LinearLayout>

    <android.support.design.widget.NavigationView
        android:layout_width="wrap_content"
        android:layout_height="match_parent"
        android:layout_gravity="start"
        android:id="@+id/nav_view"
        app:menu="@menu/navbar" />
</android.support.v4.widget.DrawerLayout>
```

As you can see, we use a string to define the 'AdUnitId'. To do this we insert a new string in `/values/strings.xml`:

```xml:strings.xml
<string name="admob" translatable="false">ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX</string>
```

The 'translatable' attribute makes the string the same for all the languages that our application has.

Finally, in `onCreate()` of our main activity, we add the code to load the advertising:

```java:MainActivity.java
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

public class MainActivity extends AppCompatActivity {
    private AdView adView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        adView = (AdView) findViewById(R.id.ads);
        AdRequest adRequest = new AdRequest.Builder().build();
        adView.loadAd(adRequest);
    }

    @Override
    public void onPause() {
        super.onPause();
        adView.pause();
    }

    @Override
    public void onResume() {
        super.onResume();
        adView.resume();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        adView.destroy();
    }
}
```

And that is all. You can check that it works by watching the screenshots in [PkmnDex](/en/projects/android/pkmndex/).
