<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

# Habis belum masuk kedalam databse
// insertnya mana, fungsi kontroler buat masuk kedalam databse
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
