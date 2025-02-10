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
ma_result notch_init_decoder_and_encoder(const char* pInputFilePath, const char* pOutputFilePath, ma_format format, ma_decoder* pDecoder, ma_encoder* pEncoder)
{
    return filtering_init_decoder_and_encoder(pInputFilePath, pOutputFilePath, format, 0, 0, pDecoder, pEncoder);
}


ma_result test_notch2__by_format(const char* pInputFilePath, const char* pOutputFilePath, ma_format format)
{
    ma_result result;
    ma_decoder decoder;
    ma_encoder encoder;
    ma_notch2_config notchConfig;
    ma_notch2 notch;

    printf("    %s\n", pOutputFilePath);

    result = notch_init_decoder_and_encoder(pInputFilePath, pOutputFilePath, format, &decoder, &encoder);
    if (result != MA_SUCCESS) {
        return result;
    }

    notchConfig = ma_notch2_config_init(decoder.outputFormat, decoder.outputChannels, decoder.outputSampleRate, 1, 60);
    result = ma_notch2_init(&notchConfig, NULL, &notch);
    if (result != MA_SUCCESS) {
        ma_decoder_uninit(&decoder);
        ma_encoder_uninit(&encoder);
        return result;
    }

    for (;;) {
        ma_uint8 tempIn[4096];
        ma_uint8 tempOut[4096];
        ma_uint64 tempCapIn  = sizeof(tempIn)  / ma_get_bytes_per_frame(decoder.outputFormat, decoder.outputChannels);
        ma_uint64 tempCapOut = sizeof(tempOut) / ma_get_bytes_per_frame(decoder.outputFormat, decoder.outputChannels);
        ma_uint64 framesToRead;
        ma_uint64 framesJustRead;

        framesToRead = ma_min(tempCapIn, tempCapOut);
        ma_decoder_read_pcm_frames(&decoder, tempIn, framesToRead, &framesJustRead);

        /* Filter */
        ma_notch2_process_pcm_frames(&notch, tempOut, tempIn, framesJustRead);

        /* Write to the WAV file. */
        ma_encoder_write_pcm_frames(&encoder, tempOut, framesJustRead, NULL);

        if (framesJustRead < framesToRead) {
            break;
        }
    }

    ma_decoder_uninit(&decoder);
    ma_encoder_uninit(&encoder);
    return MA_SUCCESS;
}

ma_result test_notch2__f32(const char* pInputFilePath)
{
    return test_notch2__by_format(pInputFilePath, TEST_OUTPUT_DIR"/notch2_f32.wav", ma_format_f32);
}

ma_result test_notch2__s16(const char* pInputFilePath)
{
    return test_notch2__by_format(pInputFilePath, TEST_OUTPUT_DIR"/notch2_s16.wav", ma_format_s16);
}

#if 0
ma_result test_notch4__by_format(const char* pInputFilePath, const char* pOutputFilePath, ma_format format)
{
    ma_result result;
    ma_decoder decoder;
    ma_encoder encoder;
    ma_notch_config notchConfig;
    ma_notch notch;

    printf("    %s\n", pOutputFilePath);

    result = notch_init_decoder_and_encoder(pInputFilePath, pOutputFilePath, format, &decoder, &encoder);
    if (result != MA_SUCCESS) {
        return result;
    }

    notchConfig = ma_notch_config_init(decoder.outputFormat, decoder.outputChannels, decoder.outputSampleRate, 2000, 4);
    result = ma_notch_init(&notchConfig, &notch);
    if (result != MA_SUCCESS) {
        ma_decoder_uninit(&decoder);
        ma_encoder_uninit(&encoder);
        return result;
    }

    for (;;) {
        ma_uint8 tempIn[4096];
        ma_uint8 tempOut[4096];
        ma_uint64 tempCapIn  = sizeof(tempIn)  / ma_get_bytes_per_frame(decoder.outputFormat, decoder.outputChannels);
        ma_uint64 tempCapOut = sizeof(tempOut) / ma_get_bytes_per_frame(decoder.outputFormat, decoder.outputChannels);
        ma_uint64 framesToRead;
        ma_uint64 framesJustRead;

        framesToRead = ma_min(tempCapIn, tempCapOut);
        framesJustRead = ma_decoder_read_pcm_frames(&decoder, tempIn, framesToRead);

        /* Filter */
        ma_notch_process_pcm_frames(&notch, tempOut, tempIn, framesJustRead);

        /* Write to the WAV file. */
        ma_encoder_write_pcm_frames(&encoder, tempOut, framesJustRead);

        if (framesJustRead < framesToRead) {
            break;
        }
    }

    ma_decoder_uninit(&decoder);
    ma_encoder_uninit(&encoder);
    return MA_SUCCESS;
}

ma_result test_notch4__f32(const char* pInputFilePath)
{
    return test_notch4__by_format(pInputFilePath, TEST_OUTPUT_DIR"/notch4_f32.wav", ma_format_f32);
}

ma_result test_notch4__s16(const char* pInputFilePath)
{
    return test_notch4__by_format(pInputFilePath, TEST_OUTPUT_DIR"/notch4_s16.wav", ma_format_s16);
}
#endif

int test_entry__notch(int argc, char** argv)
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;
    const char* pInputFilePath;

    if (argc < 2) {
        printf("No input file.\n");
        return -1;
    }

    pInputFilePath = argv[1];
    

    result = test_notch2__f32(pInputFilePath);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_notch2__s16(pInputFilePath);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

#if 0
    result = test_notch4__f32(pInputFilePath);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    result = test_notch4__s16(pInputFilePath);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }
#endif

    if (hasError) {
        return -1;
    } else {
        return 0;
    }
}
