#!/bin/bash


$ANDROID_SDK_HOME/build-tools/32.0.0/apksigner \
    sign \
    --verbose \
    --ks $HOME/.android/debug.keystore \
    --ks-pass pass:android \
    --ks-key-alias androiddebugkey \
    ./build/debug/balloon_pop.apk
