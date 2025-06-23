<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengumuman extends Model
{
    public function up()
{
    Schema::create('pengumumen', function (Blueprint $table) {
        $table->id();
        $table->string('judul');
        $table->text('isi');
        $table->timestamps();
    });
}

}
