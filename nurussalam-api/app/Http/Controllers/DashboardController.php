<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Santri;
use App\Models\Absensi;
use App\Models\Pengumuman;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function summary()
    {
        $totalSantri = Santri::count();

        $today = Carbon::today()->toDateString();
        $totalHadir = Absensi::whereDate('tanggal', $today)->where('status', 'hadir')->count();
        $totalAbsen = Absensi::whereDate('tanggal', $today)->count();

        $kehadiran = $totalAbsen > 0 ? round(($totalHadir / $totalAbsen) * 100) : 0;

        $pengumumanAktif = Pengumuman::count(); // Atau sesuaikan jika ada kolom `aktif`

        return response()->json([
            'total_santri' => $totalSantri,
            'kehadiran_hari_ini' => $kehadiran,
            'pengumuman_aktif' => $pengumumanAktif
        ]);
    }
}
