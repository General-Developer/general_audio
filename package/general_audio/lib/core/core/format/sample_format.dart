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
/// Sample format which represents the format of the audio data.
enum SampleFormat {
  /// Unsigned 8bit interger format.
  uint8(1, 255, 0, 128),

  /// Signed 16bit integer format.
  int16(2, 32767, -32768, 0),

  /// Signed 24bit integer format.
  ///
  /// This format is not well supported so you should convert it to other format like [int32] before using it.
  /// `AudioSampleConverterInt24ToInt32` and `AudioFormatConverter` can be used to convert it.
  int24(3, 8388607, -8388608, 0),

  /// Signed 32bit integer format.
  int32(4, 2147483647, -2147483648, 0),

  /// 32bit floating point. Most of nodes supports this format only.
  float32(4, 1.0, -1.0, 0);

  const SampleFormat(this.size, this.max, this.min, this.mid);

  /// Number of bytes of the sample.
  final int size;

  /// Maximum value of the sample.
  final num max;

  /// Minimum value of the sample.
  final num min;

  /// Middle value of the sample.
  final num mid;
}
