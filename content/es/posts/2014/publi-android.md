---
title: Cómo añadir publicidad a tu aplicación Android
subtitle: Añade publicidad de AdMob a tu aplicación Android muy fácilmente
description: Añade publicidad de AdMob a tu aplicación Android muy fácilmente.

date: 2014-04-01T12:20:00+02:00
categories:
  - Android
  - Programación
tags:
  - admob
  - publicidad
  - publicidad android

image: /images/posts/2014/admob/admob-logo.png
translationKey: android-admob
slug: publi-android
---
{{< notice warning "Aviso de depreciación" >}}
Este tutorial es de **2014** y no es compatible con nuevas versiones del SDK de AdMob. Para una versión más actualizada, visita la [guía](https://developers.google.com/admob/android/quick-start?hl=es) de Google.
{{< /notice >}}

En este tutorial os voy a enseñar cómo añadir publicidad a vuestras aplicaciones Android. El sistema que utilizaré será AdMob, ya que es el mejor en su categoría aunque también hay alternativas, como InMobi, MobFox...

<!--more-->

Lo primero será registrar la aplicación en la [página de AdMob](https://apps.admob.com/). Si ya tenías una cuenta antigua puedes importar los datos, sino añade una nueva aplicación. Si ya tienes publicada la aplicación en la Play Store tan solo tienes que buscarla y se añadirá automática. En el caso contrario la tendrás que añadir manualmente.

{{< img src="/images/posts/2014/admob/panel.png" caption="Aplicaciones en AdMob" >}}

Cuando la hayamos creado pasamos a nuestro proyecto en Android Studio y abrimos el archivo `build.gradle`. Dentro nos vamos al apartado `dependencies` y agregamos la siguiente línea a las que ya están:

```groovy
compile 'com.google.android.gms:play-services:11.0.0'
```

Quedando tal que así:

```groovy
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar', '*.aar'])
    compile 'com.google.android.gms:play-services:11.0.0'
    ...
}
```

Y sincronizamos Gradle pulsando el botón Sync Project: ![Sincronizar proyecto](https://developer.android.com/images/tools/sync-project.png)

Ahora abrimos el archivo AndroidManifest.xml y añadimos las siguientes líneas encima de `</application>`:

```xml
<meta-data android:name="com.google.android.gms.version"
    android:value="@integer/google_play_services_version" />
<activity android:name="com.google.android.gms.ads.AdActivity"
    android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
    android:theme="@android:style/Theme.Translucent" />
```

Antes de la etiqueta `<application>` añadimos los permisos necesarios para mostrar los anuncios:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

Ahora vamos a crear un `LinearLayout` que contendrá nuestro banner, quedando así:

```xml
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_weight="1"
    android:gravity="bottom"
    android:orientation="vertical" >

    <com.google.android.gms.ads.AdView
        android:id="@+id/publicidad"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        ads:adSize="SMART_BANNER"
        ads:adUnitId="@string/admob" >
    </com.google.android.gms.ads.AdView>
</LinearLayout>
```

Con esta configuración el banner aparecerá en el pie de la aplicación. Por ejemplo si lo queremos utilizar en un `DrawerLayout` que utilice `Fragment` y `NavigationView`, el diseño quedaría así:

```xml
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
            android:id="@+id/publicidad"
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

Como se puede comprobar, utilizamos una cadena para definir el `AdUnitId`. Para ello insertamos una nueva cadena en `/values/strings.xml`:

```xml
<string name="admob" translatable="false">ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX</string>
```

El atributo `translatable` hace que la cadena sea la misma para todos los idiomas que tenga nuestra aplicación.

Finalmente, en `onCreate()` de nuetra actividad principal, añadimos el código para que carge la publicidad:

```java
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

public class Actividad extends AppCompatActivity {
    private AdView adView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        adView = (AdView) findViewById(R.id.publicidad);
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

Y eso es todo. Puedes comprobar que funciona viendo las capturas de [PkmnDex](/proyectos/android/pkmndex/).
