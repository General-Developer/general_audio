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

#define VOCLIB_IMPLEMENTATION
#include "ma_vocoder_node.h"

MA_API ma_vocoder_node_config ma_vocoder_node_config_init(ma_uint32 channels, ma_uint32 sampleRate)
{
    ma_vocoder_node_config config;

    MA_ZERO_OBJECT(&config);
    config.nodeConfig     = ma_node_config_init();   /* Input and output channels will be set in ma_vocoder_node_init(). */
    config.channels       = channels;
    config.sampleRate     = sampleRate;
    config.bands          = 16;
    config.filtersPerBand = 6;

    return config;
}


static void ma_vocoder_node_process_pcm_frames(ma_node* pNode, const float** ppFramesIn, ma_uint32* pFrameCountIn, float** ppFramesOut, ma_uint32* pFrameCountOut)
{
    ma_vocoder_node* pVocoderNode = (ma_vocoder_node*)pNode;

    (void)pFrameCountIn;

    voclib_process(&pVocoderNode->voclib, ppFramesIn[0], ppFramesIn[1], ppFramesOut[0], *pFrameCountOut);
}

static ma_node_vtable g_ma_vocoder_node_vtable =
{
    ma_vocoder_node_process_pcm_frames,
    NULL,
    2,  /* 2 input channels. */
    1,  /* 1 output channel. */
    0
};

MA_API ma_result ma_vocoder_node_init(ma_node_graph* pNodeGraph, const ma_vocoder_node_config* pConfig, const ma_allocation_callbacks* pAllocationCallbacks, ma_vocoder_node* pVocoderNode)
{
    ma_result result;
    ma_node_config baseConfig;
    ma_uint32 inputChannels[2];
    ma_uint32 outputChannels[1];

    if (pVocoderNode == NULL) {
        return MA_INVALID_ARGS;
    }

    MA_ZERO_OBJECT(pVocoderNode);

    if (pConfig == NULL) {
        return MA_INVALID_ARGS;
    }

    if (voclib_initialize(&pVocoderNode->voclib, (unsigned char)pConfig->bands, (unsigned char)pConfig->filtersPerBand, (unsigned int)pConfig->sampleRate, (unsigned char)pConfig->channels) == 0) {
        return MA_INVALID_ARGS;
    }

    inputChannels [0] = pConfig->channels;   /* Source/carrier. */
    inputChannels [1] = 1;                   /* Excite/modulator. Must always be single channel. */
    outputChannels[0] = pConfig->channels;   /* Output channels is always the same as the source/carrier. */

    baseConfig = pConfig->nodeConfig;
    baseConfig.vtable          = &g_ma_vocoder_node_vtable;
    baseConfig.pInputChannels  = inputChannels;
    baseConfig.pOutputChannels = outputChannels;

    result = ma_node_init(pNodeGraph, &baseConfig, pAllocationCallbacks, &pVocoderNode->baseNode);
    if (result != MA_SUCCESS) {
        return result;
    }

    return MA_SUCCESS;
}

MA_API void ma_vocoder_node_uninit(ma_vocoder_node* pVocoderNode, const ma_allocation_callbacks* pAllocationCallbacks)
{
    /* The base node must always be initialized first. */
    ma_node_uninit(pVocoderNode, pAllocationCallbacks);
}
