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

#define VERBLIB_IMPLEMENTATION
#include "ma_reverb_node.h"

MA_API ma_reverb_node_config ma_reverb_node_config_init(ma_uint32 channels, ma_uint32 sampleRate)
{
    ma_reverb_node_config config;

    MA_ZERO_OBJECT(&config);
    config.nodeConfig = ma_node_config_init();  /* Input and output channels will be set in ma_reverb_node_init(). */
    config.channels   = channels;
    config.sampleRate = sampleRate;
    config.roomSize   = verblib_initialroom;
    config.damping    = verblib_initialdamp;
    config.width      = verblib_initialwidth;
    config.wetVolume  = verblib_initialwet;
    config.dryVolume  = verblib_initialdry;
    config.mode       = verblib_initialmode;

    return config;
}


static void ma_reverb_node_process_pcm_frames(ma_node* pNode, const float** ppFramesIn, ma_uint32* pFrameCountIn, float** ppFramesOut, ma_uint32* pFrameCountOut)
{
    ma_reverb_node* pReverbNode = (ma_reverb_node*)pNode;

    (void)pFrameCountIn;

    verblib_process(&pReverbNode->reverb, ppFramesIn[0], ppFramesOut[0], *pFrameCountOut);
}

static ma_node_vtable g_ma_reverb_node_vtable =
{
    ma_reverb_node_process_pcm_frames,
    NULL,
    1,  /* 1 input channel. */
    1,  /* 1 output channel. */
    MA_NODE_FLAG_CONTINUOUS_PROCESSING  /* Reverb requires continuous processing to ensure the tail get's processed. */
};

MA_API ma_result ma_reverb_node_init(ma_node_graph* pNodeGraph, const ma_reverb_node_config* pConfig, const ma_allocation_callbacks* pAllocationCallbacks, ma_reverb_node* pReverbNode)
{
    ma_result result;
    ma_node_config baseConfig;

    if (pReverbNode == NULL) {
        return MA_INVALID_ARGS;
    }

    MA_ZERO_OBJECT(pReverbNode);

    if (pConfig == NULL) {
        return MA_INVALID_ARGS;
    }

    if (verblib_initialize(&pReverbNode->reverb, (unsigned long)pConfig->sampleRate, (unsigned int)pConfig->channels) == 0) {
        return MA_INVALID_ARGS;
    }

    baseConfig = pConfig->nodeConfig;
    baseConfig.vtable          = &g_ma_reverb_node_vtable;
    baseConfig.pInputChannels  = &pConfig->channels;
    baseConfig.pOutputChannels = &pConfig->channels;

    result = ma_node_init(pNodeGraph, &baseConfig, pAllocationCallbacks, &pReverbNode->baseNode);
    if (result != MA_SUCCESS) {
        return result;
    }

    return MA_SUCCESS;
}

MA_API void ma_reverb_node_uninit(ma_reverb_node* pReverbNode, const ma_allocation_callbacks* pAllocationCallbacks)
{
    /* The base node is always uninitialized first. */
    ma_node_uninit(pReverbNode, pAllocationCallbacks);
}
