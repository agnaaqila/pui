<?php

namespace App\Http\Controllers;

use App\Models\Absensi;
use Illuminate\Http\Request;

class AbsensiController extends Controller
{
    public function store(Request $request)
    {
        foreach ($request->absensi as $item) {
            Absensi::updateOrCreate(
                [
                    'santri_id' => $item['santri_id'],
                    'jadwal_id' => $item['jadwal_id'],
                    'tanggal' => date('Y-m-d'),
                ],
                ['status' => $item['status']]
            );
        }

        return response()->json(['message' => 'Absensi disimpan']);
    }

    public function rekapHariIni()
    {
        $tanggal = date('Y-m-d');

        $rekap = \DB::table('absensis')
            ->join('jadwals', 'absensis.jadwal_id', '=', 'jadwals.id')
            ->select('jadwals.kegiatan', 'jadwals.waktu',
                \DB::raw("SUM(CASE WHEN status = 'hadir' THEN 1 ELSE 0 END) as hadir"),
                \DB::raw("SUM(CASE WHEN status = 'izin' THEN 1 ELSE 0 END) as izin"),
                \DB::raw("SUM(CASE WHEN status = 'sakit' THEN 1 ELSE 0 END) as sakit"),
                \DB::raw("SUM(CASE WHEN status = 'alfa' THEN 1 ELSE 0 END) as alfa")
            )
            ->where('tanggal', $tanggal)
            ->groupBy('jadwals.id', 'jadwals.kegiatan', 'jadwals.waktu')
            ->get();

        return response()->json($rekap);
    }

    public function showBySantri($id)
{
    $absensi = Absensi::with('jadwal') // pastikan relasi 'jadwal' ada di model Absensi
        ->where('santri_id', $id)
        ->orderBy('tanggal', 'desc')
        ->get();

    return response()->json($absensi);
}

}
