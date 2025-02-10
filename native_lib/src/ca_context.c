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
#include "ca_context.h"

ma_result ca_context_init(const ma_backend backends[], ma_uint32 backendCount, const ma_context_config *pConfig, ca_context *pContext)
{
    pContext->pRef = NULL;

    ma_context *pRef = (ma_context *)ma_malloc(sizeof(ma_context), NULL);
    ma_result result = ma_context_init(backends, backendCount, pConfig, pRef);
    if (result != MA_SUCCESS)
    {
        ma_free(pContext, NULL);
        return result;
    }

    pContext->pRef = pRef;
    return MA_SUCCESS;
}

ma_context *ca_context_get_ref(ca_context *pContext)
{
    return (ma_context *)pContext->pRef;
}

ma_result ca_context_uninit(ca_context *pContext)
{
    if (pContext->pRef == NULL)
    {
        return MA_SUCCESS;
    }

    ma_result result = ma_context_uninit(pContext->pRef);
    ma_free(pContext->pRef, NULL);
    pContext->pRef = NULL;

    return result;
}
