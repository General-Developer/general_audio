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
#include "../test_common/ma_test_common.c"

ma_result filtering_init_decoder_and_encoder(const char* pInputFilePath, const char* pOutputFilePath, ma_format format, ma_uint32 channels, ma_uint32 sampleRate, ma_decoder* pDecoder, ma_encoder* pEncoder)
{
    ma_result result;
    ma_decoder_config decoderConfig;
    ma_encoder_config encoderConfig;

    decoderConfig = ma_decoder_config_init(format, channels, sampleRate);
    result = ma_decoder_init_file(pInputFilePath, &decoderConfig, pDecoder);
    if (result != MA_SUCCESS) {
        return result;
    }

    encoderConfig = ma_encoder_config_init(ma_encoding_format_wav, pDecoder->outputFormat, pDecoder->outputChannels, pDecoder->outputSampleRate);
    result = ma_encoder_init_file(pOutputFilePath, &encoderConfig, pEncoder);
    if (result != MA_SUCCESS) {
        ma_decoder_uninit(pDecoder);
        return result;
    }

    return MA_SUCCESS;
}

#include "ma_test_filtering_dithering.c"
#include "ma_test_filtering_lpf.c"
#include "ma_test_filtering_hpf.c"
#include "ma_test_filtering_bpf.c"
#include "ma_test_filtering_notch.c"
#include "ma_test_filtering_peak.c"
#include "ma_test_filtering_loshelf.c"
#include "ma_test_filtering_hishelf.c"

int main(int argc, char** argv)
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;
    size_t iTest;

    (void)argc;
    (void)argv;

    result = ma_register_test("Dithering", test_entry__dithering);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("Low-Pass Filtering", test_entry__lpf);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("High-Pass Filtering", test_entry__hpf);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("Band-Pass Filtering", test_entry__bpf);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("Notching Filtering", test_entry__notch);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("Peaking EQ Filtering", test_entry__peak);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("Low Shelf Filtering", test_entry__loshelf);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = ma_register_test("High Shelf Filtering", test_entry__hishelf);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }
    

    for (iTest = 0; iTest < g_Tests.count; iTest += 1) {
        printf("=== BEGIN %s ===\n", g_Tests.pTests[iTest].pName);
        result = g_Tests.pTests[iTest].onEntry(argc, argv);
        printf("=== END %s : %s ===\n", g_Tests.pTests[iTest].pName, (result == 0) ? "PASSED" : "FAILED");

        if (result != 0) {
            hasError = MA_TRUE;
        }
    }

    if (hasError) {
        return -1;  /* Something failed. */
    } else {
        return 0;   /* Everything passed. */
    }
}
