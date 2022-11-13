# Balloon Pop

Small and simple android game for toddlers.

The goals of this project for me were:
* to touch some new tech stack I never used before and learn something new;
* to combine business with pleasure by developing a game for my little son so he could:
  * learn colors and digits;
  * develop his fine motor skills;
  * match sound effects with his in-game actions;
  * listen nice music.

## Disclaimer

Since this is my very first godot project (1) for android (2) and is very small (3) I made something in pretty straightforward way.

**So, god, please, no, don't ask me for help with project.**
**I will never fucking ever going to get into this hell again.**

At least, I compiled and backed up an apk once just and I don't see any reason to come back here since the project is completed enough  for me.
I reached somehow my goals and it took me a lot of nerves and time not to programm but to compile this game, so I deserve forgiveness.

## Setup and compile

1. Install latest version of godot:  
   https://godotengine.org/download
2. Set up your environment as you need according to these instructions:  
   https://developer.android.com/games/engines/godot/godot-configure
3. Clone this repo and open project in godot
4. Follow these steps to export the game for android:  
   https://developer.android.com/games/engines/godot/godot-export

Those manuals may be a little bit outdated but steps are correct in common.

I prefer to use commands from this manual to create keystores:  
https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html

Also this document may be useful:  
https://docs.godotengine.org/en/stable/development/compiling/compiling_for_android.html

After apk has been built you can drop it on android device to test.

## FAQ

In case of export errors restart godot with `-v` flag and try export again, so that you will see additional messages so you could find out failure reasons.
Godot usually don't print them in its own output window being like "export failed because fuck you dicksucker, that's why".

### Exit Code: 1

If your export stopped with `Exit Code: 1` without error message ensure your `ANDROID_SDK_PATH` variable is set:

```
export ANDROID_SDK_PATH="<correct path here>"
```

### Apksigner error #127

In my case there was error `apksigner: line 97: exec: java: not found`.

Seems like apksigner (when called by godot) just don't give a fuck about where is `java` bin is even if `JAVA_HOME` + `PATH` are correct.

So I had to manually run such command (TACL at vars in it) after export:

```
$ANDROID_SDK_HOME/build-tools/32.0.0/apksigner \
   sign \
   --verbose \
   --ks $HOME/.android/debug.keystore \
   --ks-pass pass:android \
   --ks-key-alias androiddebugkey \
   $EXPORTED_APK_PATH
```

## Credits

I am not an artist nor composer, so I found some assets on the internet to use in this project.
I want to thank authors of used assets and provide some info about them.

### Music

* [School](https://www.chosic.com/download-audio/24280/) by Komiku ([CC0](https://creativecommons.org/publicdomain/zero/1.0/))
* [Chillin’ Poupi](https://www.chosic.com/download-audio/25001/) by Komiku ([CC0](https://creativecommons.org/publicdomain/zero/1.0/))
* [Umlungu](https://www.chosic.com/download-audio/24984/) by John Bartmann ([CC0](https://creativecommons.org/publicdomain/zero/1.0/))
* [Allez! Allez!](https://www.chosic.com/download-audio/28341/) by John Bartmann ([CC0](https://creativecommons.org/publicdomain/zero/1.0/))
* [Move Forward](https://www.chosic.com/download-audio/39320/) by Kevin MacLeod ([CCBY 3.0](https://creativecommons.org/licenses/by/3.0/))
* [Spook](https://www.chosic.com/download-audio/45514/) by PeriTune ([CCBY 4.0](https://creativecommons.org/licenses/by/4.0/))
* [Fast Feel Banana Peel](https://www.chosic.com/download-audio/28655/) by Alexander Nakarada ([CCBY 4.0](https://creativecommons.org/licenses/by/4.0/))

### Fonts

* [Open Sans](https://fonts.google.com/specimen/Open+Sans) by Steve Matteson ([OFL](https://scripts.sil.org/OFL))

### Pictures

* [Background photo](https://unsplash.com/photos/gmZa95LWkF4) by [Mikey Harris](https://unsplash.com/@mikeyharris) ([Unsplash license](https://unsplash.com/license))
* [Balloon popping animation](https://www.gamedeveloperstudio.com/graphics/viewgraphic.php?item=134l668d3b3n083827) by Robert Brooks ([Game developer studio standard license](https://www.gamedeveloperstudio.com/license.php))

## License

[The MIT License](LICENSE.md)
