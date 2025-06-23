let editId = null;

async function loadSantri() {
    const response = await fetch("http://127.0.0.1:8000/api/santri");
    const data = await response.json();
    const tbody = document.getElementById("santriTableBody");
    tbody.innerHTML = "";

    data.forEach((item, index) => {
        tbody.innerHTML += `
      <tr>
        <td>${index + 1}</td>
        <td>${item.nis}</td>
        <td>${item.nama}</td>
        <td>${item.kelas}</td>
        <td>${item.alamat || "-"}</td>
        <td>
          <button onclick="editSantri(${item.id}, '${item.nis}', '${
            item.nama
        }', '${item.kelas}', '${item.alamat || ""}')">Edit</button>
          <button onclick="deleteSantri(${item.id})">Hapus</button>
        </td>
      </tr>`;
    });
}

document
    .getElementById("santriForm")
    .addEventListener("submit", async function (e) {
        e.preventDefault();

        const santri = {
            nis: document.getElementById("nis").value,
            nama: document.getElementById("nama").value,
            kelas: document.getElementById("kelas").value,
            alamat: document.getElementById("alamat").value,
            password: document.getElementById("password").value,
        };

        const url = editId
            ? `http://127.0.0.1:8000/api/santri/${editId}`
            : "http://127.0.0.1:8000/api/santri";

        const method = editId ? "PUT" : "POST";

        const response = await fetch(url, {
            method,
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(santri),
        });

        if (response.ok) {
            alert(editId ? "Data diubah!" : "Santri ditambahkan!");
            this.reset();
            editId = null;
            loadSantri();
        } else {
            alert("Gagal menyimpan data");
        }
    });

function editSantri(id, nis, nama, kelas, alamat) {
    document.getElementById("nis").value = nis;
    document.getElementById("nama").value = nama;
    document.getElementById("kelas").value = kelas;
    document.getElementById("alamat").value = alamat;

    editId = id;
}

async function deleteSantri(id) {
    if (confirm("Yakin ingin menghapus santri ini?")) {
        const res = await fetch(`http://127.0.0.1:8000/api/santri/${id}`, {
            method: "DELETE",
        });

        if (res.ok) {
            alert("Santri dihapus");
            loadSantri();
        } else {
            alert("Gagal menghapus");
        }
    }
}

loadSantri();
