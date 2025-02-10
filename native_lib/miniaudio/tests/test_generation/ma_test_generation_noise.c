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

ma_result test_noise__by_format_and_type(ma_format format, ma_noise_type type, const char* pFileName)
{
    ma_result result;
    ma_noise_config noiseConfig;
    ma_noise noise;
    ma_encoder_config encoderConfig;
    ma_encoder encoder;
    ma_uint32 iFrame;

    printf("    %s\n", pFileName);

    noiseConfig = ma_noise_config_init(format, 1, type, 0, 0.1);
    result = ma_noise_init(&noiseConfig, NULL, &noise);
    if (result != MA_SUCCESS) {
        return result;
    }

    encoderConfig = ma_encoder_config_init(ma_encoding_format_wav, format, noiseConfig.channels, 48000);
    result = ma_encoder_init_file(pFileName, &encoderConfig, &encoder);
    if (result != MA_SUCCESS) {
        return result;
    }

    /* We'll do a few seconds of data. */
    for (iFrame = 0; iFrame < encoder.config.sampleRate * 10; iFrame += 1) {
        ma_uint8 temp[1024];
        ma_noise_read_pcm_frames(&noise, temp, 1, NULL);
        ma_encoder_write_pcm_frames(&encoder, temp, 1, NULL);
    }

    ma_encoder_uninit(&encoder);
    return MA_SUCCESS;
}

ma_result test_noise__f32()
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;

    result = test_noise__by_format_and_type(ma_format_f32, ma_noise_type_white, TEST_OUTPUT_DIR"/noise_f32_white.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_f32, ma_noise_type_pink, TEST_OUTPUT_DIR"/noise_f32_pink.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_f32, ma_noise_type_brownian, TEST_OUTPUT_DIR"/noise_f32_brownian.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    if (hasError) {
        return MA_ERROR;
    } else {
        return MA_SUCCESS;
    }
}

ma_result test_noise__s16()
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;

    result = test_noise__by_format_and_type(ma_format_s16, ma_noise_type_white, TEST_OUTPUT_DIR"/output/noise_s16_white.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_s16, ma_noise_type_pink, TEST_OUTPUT_DIR"/output/noise_s16_pink.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_s16, ma_noise_type_brownian, TEST_OUTPUT_DIR"/output/noise_s16_brownian.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    if (hasError) {
        return MA_ERROR;
    } else {
        return MA_SUCCESS;
    }
}

ma_result test_noise__u8()
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;

    result = test_noise__by_format_and_type(ma_format_u8, ma_noise_type_white, TEST_OUTPUT_DIR"/noise_u8_white.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_u8, ma_noise_type_pink, TEST_OUTPUT_DIR"/noise_u8_pink.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__by_format_and_type(ma_format_u8, ma_noise_type_brownian, TEST_OUTPUT_DIR"/noise_u8_brownian.wav");
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    if (hasError) {
        return MA_ERROR;
    } else {
        return MA_SUCCESS;
    }
}

int test_entry__noise(int argc, char** argv)
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;

    (void)argc;
    (void)argv;

    result = test_noise__f32();
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__s16();
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_noise__u8();
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    if (hasError) {
        return -1;
    } else {
        return 0;
    }
}
