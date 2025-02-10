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
#define MA_NO_DEVICE_IO
#include "../test_common/ma_test_common.c"

#include "ma_test_generation_noise.c"
#include "ma_test_generation_waveform.c"

int main(int argc, char** argv)
{
    ma_result result;
    ma_bool32 hasError = MA_FALSE;
    size_t iTest;

    (void)argc;
    (void)argv;

    result = ma_register_test("Noise", test_entry__noise);
    if (result != MA_SUCCESS) {
        return result;
    }

    result = ma_register_test("Waveform", test_entry__waveform);
    if (result != MA_SUCCESS) {
        return result;
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
