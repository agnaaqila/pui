<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;

// di routes/api.php
Route::post('/admin/login', [AuthController::class, 'loginAdmin']);
// di routes/api.php
Route::post('/login', [AuthController::class, 'loginSantri']);
Route::get('/absensi/santri/{id}', [AbsensiController::class, 'showBySantri']);


use App\Http\Controllers\JadwalController;

Route::get('/jadwal', [JadwalController::class, 'index']);
Route::post('/jadwal', [JadwalController::class, 'store']);
Route::put('/jadwal/{id}', [JadwalController::class, 'update']);
Route::delete('/jadwal/{id}', [JadwalController::class, 'destroy']);

use App\Http\Controllers\SantriController;

Route::get('/santri', [SantriController::class, 'index']);
Route::post('/santri', [SantriController::class, 'store']);
Route::put('/santri/{id}', [SantriController::class, 'update']);
Route::delete('/santri/{id}', [SantriController::class, 'destroy']);

use App\Http\Controllers\AbsensiController;

Route::post('/absensi', [AbsensiController::class, 'store']);
Route::get('/absensi/today', [AbsensiController::class, 'rekapHariIni']);

use App\Http\Controllers\DashboardController;

Route::get('/dashboard/summary', [DashboardController::class, 'summary']);

use App\Http\Controllers\PengumumanController;

Route::get('/pengumuman', [PengumumanController::class, 'index']);
Route::post('/pengumuman', [PengumumanController::class, 'store']);
Route::delete('/pengumuman/{id}', [PengumumanController::class, 'destroy']);
