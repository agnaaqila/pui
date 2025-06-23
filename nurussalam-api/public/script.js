// script.js
console.log("Dashboard Admin Nurussalam loaded.");

// Future interactive features (like toggle sidebar or fetch data) can go here.
// Fungsi memuat data dari API
let editId = null;

// Muat semua data jadwal
async function loadJadwal() {
    const response = await fetch("http://127.0.0.1:8000/api/jadwal");
    const data = await response.json();
    const table = document.getElementById("jadwalTableBody");
    table.innerHTML = "";
    data.forEach((item, index) => {
        table.innerHTML += `
      <tr>
        <td>${index + 1}</td>
        <td>${item.hari}</td>
        <td>${item.waktu}</td>
        <td>${item.kegiatan}</td>
        <td>
          <button onclick="editJadwal(${item.id}, '${item.hari}', '${
            item.waktu
        }', '${item.kegiatan}')">Edit</button>
          <button onclick="deleteJadwal(${item.id})">Hapus</button>
        </td>
      </tr>`;
    });
}

// Fungsi menambahkan atau mengupdate jadwal
document
    .getElementById("jadwalForm")
    .addEventListener("submit", async function (e) {
        e.preventDefault();

        const data = {
            hari: document.getElementById("hari").value,
            waktu: document.getElementById("waktu").value,
            kegiatan: document.getElementById("kegiatan").value,
        };

        if (editId) {
            // UPDATE
            const response = await fetch(
                `http://127.0.0.1:8000/api/jadwal/${editId}`,
                {
                    method: "PUT",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(data),
                }
            );

            if (response.ok) {
                alert("Jadwal berhasil diubah!");
            } else {
                alert("Gagal mengubah jadwal!");
            }
            editId = null;
        } else {
            // CREATE
            const response = await fetch("http://127.0.0.1:8000/api/jadwal", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data),
            });

            if (response.ok) {
                alert("Jadwal berhasil ditambahkan!");
            } else {
                alert("Gagal menambahkan jadwal!");
            }
        }

        this.reset();
        loadJadwal();
    });

// Fungsi menghapus jadwal
async function deleteJadwal(id) {
    if (confirm("Yakin ingin menghapus jadwal ini?")) {
        const response = await fetch(`http://127.0.0.1:8000/api/jadwal/${id}`, {
            method: "DELETE",
        });

        if (response.ok) {
            alert("Jadwal dihapus");
            loadJadwal();
        } else {
            alert("Gagal menghapus jadwal");
        }
    }
}

// Fungsi edit jadwal
function editJadwal(id, hari, waktu, kegiatan) {
    document.getElementById("hari").value = hari;
    document.getElementById("waktu").value = waktu;
    document.getElementById("kegiatan").value = kegiatan;
    editId = id;
}
