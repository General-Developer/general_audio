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
import 'internal/generated/bindings.dart';

/// miniaudio result codes.
enum MaResult {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  success(ma_result.MA_SUCCESS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  error(ma_result.MA_ERROR),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  invalidArgs(ma_result.MA_INVALID_ARGS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  invalidOperation(ma_result.MA_INVALID_OPERATION),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  outOfMemory(ma_result.MA_OUT_OF_MEMORY),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  outOfRange(ma_result.MA_OUT_OF_RANGE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  accessDenied(ma_result.MA_ACCESS_DENIED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  doesNotExist(ma_result.MA_DOES_NOT_EXIST),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  alreadyExists(ma_result.MA_ALREADY_EXISTS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  tooManyOpenFiles(ma_result.MA_TOO_MANY_OPEN_FILES),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  invalidFile(ma_result.MA_INVALID_FILE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  tooBig(ma_result.MA_TOO_BIG),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  pathTooLong(ma_result.MA_PATH_TOO_LONG),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  nameTooLong(ma_result.MA_NAME_TOO_LONG),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  notDirectory(ma_result.MA_NOT_DIRECTORY),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  isDirectory(ma_result.MA_IS_DIRECTORY),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  directoryNotEmpty(ma_result.MA_DIRECTORY_NOT_EMPTY),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  atEnd(ma_result.MA_AT_END),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noSpace(ma_result.MA_NO_SPACE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  busy(ma_result.MA_BUSY),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ioError(ma_result.MA_IO_ERROR),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  interrupt(ma_result.MA_INTERRUPT),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  unavailable(ma_result.MA_UNAVAILABLE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  alreadyInUse(ma_result.MA_ALREADY_IN_USE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  badAddress(ma_result.MA_BAD_ADDRESS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  badSeek(ma_result.MA_BAD_SEEK),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  badPipe(ma_result.MA_BAD_PIPE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deadlock(ma_result.MA_DEADLOCK),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  tooManyLinks(ma_result.MA_TOO_MANY_LINKS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  notImplemented(ma_result.MA_NOT_IMPLEMENTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noMessage(ma_result.MA_NO_MESSAGE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  badMessage(ma_result.MA_BAD_MESSAGE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noDataAvailable(ma_result.MA_NO_DATA_AVAILABLE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  invalidData(ma_result.MA_INVALID_DATA),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  timeout(ma_result.MA_TIMEOUT),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noNetwork(ma_result.MA_NO_NETWORK),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  notUnique(ma_result.MA_NOT_UNIQUE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  notSocket(ma_result.MA_NOT_SOCKET),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noAddress(ma_result.MA_NO_ADDRESS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  badProtocol(ma_result.MA_BAD_PROTOCOL),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  protocolUnavail(ma_result.MA_PROTOCOL_UNAVAILABLE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  protocolNotSupported(ma_result.MA_PROTOCOL_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  protocolFamilyNotSupported(ma_result.MA_PROTOCOL_FAMILY_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  addressFamilyNotSupported(ma_result.MA_ADDRESS_FAMILY_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  socketNotSupported(ma_result.MA_SOCKET_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  connectionReset(ma_result.MA_CONNECTION_RESET),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  alreadyConnected(ma_result.MA_ALREADY_CONNECTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  notConnected(ma_result.MA_NOT_CONNECTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  connectionRefused(ma_result.MA_CONNECTION_REFUSED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noHost(ma_result.MA_NO_HOST),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  inProgress(ma_result.MA_IN_PROGRESS),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  cancelled(ma_result.MA_CANCELLED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  memoryAlreadyMapped(ma_result.MA_MEMORY_ALREADY_MAPPED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  crcMismatch(ma_result.MA_CRC_MISMATCH),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  formatNotSupported(ma_result.MA_FORMAT_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deviceTypeNotSupported(ma_result.MA_DEVICE_TYPE_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  shareModeNotSupported(ma_result.MA_SHARE_MODE_NOT_SUPPORTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noBackend(ma_result.MA_NO_BACKEND),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  noDevice(ma_result.MA_NO_DEVICE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  apiNotFound(ma_result.MA_API_NOT_FOUND),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  invalidDeviceConfig(ma_result.MA_INVALID_DEVICE_CONFIG),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  loop(ma_result.MA_LOOP),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  backendNotEnabled(ma_result.MA_BACKEND_NOT_ENABLED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deviceNotInitialized(ma_result.MA_DEVICE_NOT_INITIALIZED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deviceAlreadyInitialized(ma_result.MA_DEVICE_ALREADY_INITIALIZED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deviceNotStarted(ma_result.MA_DEVICE_NOT_STARTED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  deviceNotStopped(ma_result.MA_DEVICE_NOT_STOPPED),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  failedToInitBackend(ma_result.MA_FAILED_TO_INIT_BACKEND),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  failedToOpenBackendDevice(ma_result.MA_FAILED_TO_OPEN_BACKEND_DEVICE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  failedToStartBackendDevice(ma_result.MA_FAILED_TO_START_BACKEND_DEVICE),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  failedToStopBackendDevice(ma_result.MA_FAILED_TO_STOP_BACKEND_DEVICE);

  const MaResult(this.code);
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int code;

  /// Returns `true` if this result is [success].
  bool get isSuccess => this == success;

  /// Throws a [MaException] if this result is not [success].
  void throwIfNeeded() {
    if (!isSuccess) {
      throw MaException(this);
    }
  }
}

/// An exception thrown when a miniaudio operation fails.
class MaException implements Exception {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MaException(this.result);

  /// The result code of the failed operation.
  final MaResult result;

  @override
  String toString() {
    return 'MaException(name: ${result.name}, code: ${result.code})';
  }
}
