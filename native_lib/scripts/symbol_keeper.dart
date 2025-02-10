/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
import 'dart:io';

const template = '''/// THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.
/// You can regenerate this file by running `fvm dart scripts/symbol_keeper.dart`.
import Foundation
import general_audio

@objc public final class CoastAudioSymbolKeeper: NSObject {
  @objc public static func keep() {
    let symbols = [
TEMPLATE,
    ] as [Any]
    
    let _ = symbols.count
  }
}
''';

void main(List<String> args) {
  final ignoredFiles = [
    'dart_types.h',
  ];

  final basepath = args.isNotEmpty ? args[0] : 'src/';
  final srcDirectory = Directory(basepath);
  final headerFiles = srcDirectory.listSync().where((e) => e.path.endsWith('.h')).where((e) => !ignoredFiles.any((i) => e.path.endsWith(i))).toList();
  headerFiles.add(File('miniaudio/extras/miniaudio_split/miniaudio.h'));

  const swiftPath = 'src/SymbolKeeper.swift';
  final swiftFile = File(swiftPath);

  findAndWriteFuncDef(swiftFile, basepath, headerFiles);
  stdout.write(getFuncDef(basepath, headerFiles));
}

void findAndWriteFuncDef(File file, String basepath, List<FileSystemEntity> headerFiles) {
  file.writeAsStringSync(getFuncDef(basepath, headerFiles), flush: true);
}

String getFuncDef(String basepath, List<FileSystemEntity> headerFiles) {
  final symbolLines = <String>[];

  for (final file in headerFiles) {
    final name = file.path.replaceAll(basepath, '');
    symbolLines.add('// $name');
    symbolLines.addAll(getSymbols(file as File).map((e) => '$e,'));
    symbolLines.add('\n');
  }

  symbolLines.removeLast();
  final lastSymbol = symbolLines[symbolLines.length - 1];
  symbolLines[symbolLines.length - 1] = lastSymbol.replaceAll(',', '');

  return template.replaceAll('TEMPLATE', symbolLines.map((e) => '      $e').join('\n'));
}

List<String> getSymbols(File file) {
  final regexp = RegExp(r'.*\s(.*)\(.*\);');
  return file
      .readAsLinesSync()
      .where((line) => !line.startsWith('typedef'))
      .map((line) => regexp.firstMatch(line))
      .map((match) => match?.group(1))
      .where((match) => match != null)
      .cast<String>()
      .where((e) => e.startsWith('ma_') || e.startsWith('ca_') || e.startsWith('general_audio'))
      .where((e) => !e.contains('resource_manager') && !e.contains('node') && !e.contains('engine') && !e.contains('sound'))
      .toList();
}
