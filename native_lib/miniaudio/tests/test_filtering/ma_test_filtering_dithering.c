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

ma_result test_dithering__u8(const char* pInputFilePath)
{
    const char* pOutputFilePath = TEST_OUTPUT_DIR"/dithering_u8.wav";
    ma_result result;
    ma_decoder_config decoderConfig;
    ma_decoder decoder;
    ma_encoder_config encoderConfig;
    ma_encoder encoder;
    
    decoderConfig = ma_decoder_config_init(ma_format_f32, 0, 0);
    result = ma_decoder_init_file(pInputFilePath, &decoderConfig, &decoder);
    if (result != MA_SUCCESS) {
        return result;
    }

    encoderConfig = ma_encoder_config_init(ma_encoding_format_wav, ma_format_u8, decoder.outputChannels, decoder.outputSampleRate);
    result = ma_encoder_init_file(pOutputFilePath, &encoderConfig, &encoder);
    if (result != MA_SUCCESS) {
        ma_decoder_uninit(&decoder);
        return result;
    }

    for (;;) {
        ma_uint8 tempIn[4096];
        ma_uint8 tempOut[4096];
        ma_uint64 tempCapIn  = sizeof(tempIn)  / ma_get_bytes_per_frame(decoder.outputFormat, decoder.outputChannels);
        ma_uint64 tempCapOut = sizeof(tempOut) / ma_get_bytes_per_frame(ma_format_u8, decoder.outputChannels);
        ma_uint64 framesToRead;
        ma_uint64 framesJustRead;

        framesToRead = ma_min(tempCapIn, tempCapOut);
        ma_decoder_read_pcm_frames(&decoder, tempIn, framesToRead, &framesJustRead);

        /* Convert, with dithering. */
        ma_convert_pcm_frames_format(tempOut, ma_format_u8, tempIn, decoder.outputFormat, framesJustRead, decoder.outputChannels, ma_dither_mode_triangle);

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

int test_entry__dithering(int argc, char** argv)
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;
    const char* pInputFilePath;

    if (argc < 2) {
        printf("No input file.\n");
        return -1;
    }

    pInputFilePath = argv[1];
    
    result = test_dithering__u8(pInputFilePath);
    if (result != MA_SUCCESS) {
        hasError = MA_TRUE;
    }

    if (hasError) {
        return -1;
    } else {
        return 0;
    }
}
