# General Audio
 
**General Audio** Is library for help you record audio in cross platform

[![](https://raw.githubusercontent.com/General-Developer/general_audio/refs/heads/main/assets/demo_background.png)](https://youtu.be/drlqUwJEOg4)

[![](https://raw.githubusercontent.com/globalcorporation/.github/main/.github/logo/powered.png)](https://www.youtube.com/@Global_Corporation)

**Copyright (c) 2024 GLOBAL CORPORATION - GENERAL DEVELOPER**

## 📚️ Docs

1. [Documentation](https://youtube.com/@GENERAL_DEV)
2. [Youtube](https://youtube.com/@GENERAL_DEV)
3. [Telegram Support Group](https://t.me/DEVELOPER_GLOBAL_PUBLIC)
4. [Contact Developer](https://github.com/General-Developer) (check social media or readme profile github)

## 🔖️ Features

1. [x] 📱️ **Cross Platform** support (Device, Edge Severless functions)
2. [x] 📜️ **Standarization** Style Code
3. [x] ⌨️ **Cli** (Terminal for help you use this library or create project)
4. [x] 🔥️ **Api** (If you developer bot / userbot you can use this library without interact cli just add library and use 🚀️)
5. [x] 🧩️ **Customizable Extension** (if you want add extension so you can more speed up on development)
6. [x] ✨️ **Pretty Information** (user friendly for newbie)
 
## ❔️ Fun Fact

**This library 100%** use on every my create project (**App, Server, Bot, Userbot**)
 
## 📈️ Proggres
 
- **10-02-2025**
  Starting **Release Stable** With core Features

## Resources

1. [MODEL](https://huggingface.co/ggerganov/whisper.cpp/tree/main)

### 📥️ Install Library

1. **Dart**

```bash
dart pub add general_audio
```

2. **Flutter**

```bash
flutter pub add general_audio_flutter
```

## 🚀️ Quick Start

Example Quickstart script minimal for insight you or make you use this library because very simple

```dart
import 'package:general_audio/general_audio.dart';
import 'package:io_universe/io_universe.dart';
void main(List<String> args) async {
  print("Start");
  GeneralAudio generalAudio = GeneralAudio(
    sharedLibraryPath: "../general_audio_flutter/linux/libgeneral_audio.so",
  );
  await generalAudio.ensureInitialized();
  final GeneralAudioRecorder generalAudioRecorder = generalAudio.createRecordOrGetRecord(
    outputRecordFilePath: "new_record.wav",
  );
  await generalAudioRecorder.start();
  print(generalAudioRecorder.isRecord);

  stdin.listen((e) async {
    if (generalAudioRecorder.isRecord) {
      await generalAudioRecorder.stop();
    }
    print(generalAudioRecorder.isRecord);
    exit(0);
  });
}
```
 
# A Fact

This library is originally from [SKKbySSK - coast_audio](https://github.com/SKKbySSK/coast_audio) but because the code style is not easy to read so I tried to simplify it and try to support cross platform compile.

I did not try pull request because it is not possible to set someone

**Copyright (c) 2024 GLOBAL CORPORATION - GENERAL DEVELOPER**