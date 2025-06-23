let dataSantri = [];
let selectedJadwalId = null;

// Load jadwal hari ini
fetch('http://127.0.0.1:8000/api/jadwal')
  .then(res => res.json())
  .then(jadwalList => {
    const jadwalSelect = document.getElementById('jadwal');
    jadwalList.forEach(j => {
      const option = document.createElement('option');
      option.value = j.id;
      option.text = `${j.hari} - ${j.waktu} (${j.kegiatan})`;
      jadwalSelect.appendChild(option);
    });

    if (jadwalList.length > 0) {
      selectedJadwalId = jadwalList[0].id;
      loadSantri();
    }

    jadwalSelect.addEventListener('change', e => {
      selectedJadwalId = e.target.value;
    });
  });

function loadSantri() {
  fetch('http://127.0.0.1:8000/api/santri')
    .then(res => res.json())
    .then(data => {
      dataSantri = data;
      const tbody = document.getElementById('absensiTableBody');
      tbody.innerHTML = '';

      data.forEach(s => {
        tbody.innerHTML += `
          <tr>
            <td>${s.nama}</td>
            <td>${s.nis}</td>
            <td>
              <select id="status-${s.id}">
                <option value="hadir">Hadir</option>
                <option value="izin">Izin</option>
                <option value="sakit">Sakit</option>
                <option value="alfa">Alfa</option>
              </select>
            </td>
          </tr>`;
      });
    });
}

document.getElementById('absensiForm').addEventListener('submit', async function (e) {
  e.preventDefault();

  if (!selectedJadwalId) {
    alert('Silakan pilih jadwal!');
    return;
  }

  const absensiData = dataSantri.map(s => ({
    santri_id: s.id,
    jadwal_id: selectedJadwalId,
    status: document.getElementById(`status-${s.id}`).value,
  }));

  const res = await fetch('http://127.0.0.1:8000/api/absensi', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ absensi: absensiData })
  });

  if (res.ok) {
    alert('Absensi berhasil disimpan');
    loadRekap();
  }
});

// Tampilkan rekap hari ini
function loadRekap() {
  fetch('http://127.0.0.1:8000/api/absensi/today')
    .then(res => res.json())
    .then(data => {
      const container = document.getElementById('rekapContainer');
      container.innerHTML = '<table><tr><th>Kegiatan</th><th>Jam</th><th>Hadir</th><th>Izin</th><th>Sakit</th><th>Alfa</th></tr>' +
        data.map(r => `<tr>
          <td>${r.kegiatan}</td>
          <td>${r.waktu}</td>
          <td>${r.hadir}</td>
          <td>${r.izin}</td>
          <td>${r.sakit}</td>
          <td>${r.alfa}</td>
        </tr>`).join('') + '</table>';
    });
}

loadRekap();
