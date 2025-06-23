<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Admin;
use Illuminate\Support\Facades\Hash;
use App\Models\Santri;

class AuthController extends Controller
{
public function loginAdmin(Request $request)
{
    $admin = Admin::where('username', $request->username)->first();

    if (!$admin) {
        return response()->json(['message' => 'Username tidak ditemukan'], 401);
    }

    if (!Hash::check($request->password, $admin->password)) {
        return response()->json([
            'message' => 'Password salah',
            'dikirim' => $request->password,
            'hash_db' => $admin->password
        ], 401);
    }

    return response()->json([
        'message' => 'Login berhasil',
        'admin' => [
            'id' => $admin->id,
            'username' => $admin->username,
        ]
    ]);
}

// di AuthController.php
public function loginSantri(Request $request)
{
    $santri = Santri::where('nis', $request->username)->first();

    if (!$santri || !Hash::check($request->password, $santri->password)) {
        return response()->json(['message' => 'Login gagal'], 401);
    }

    return response()->json([
        'message' => 'Login berhasil',
        'santri' => [
            'id' => $santri->id,
            'nama' => $santri->nama,
            'nis' => $santri->nis,
            'kelas' => $santri->kelas
        ]
    ]);
}



}
