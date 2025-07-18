// --- Utility Functions ---
function saveToLocalStorage(key, data) {
    localStorage.setItem(key, JSON.stringify(data));
}
function loadFromLocalStorage(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : [];
}
// --- Family Table ---
function renderFamilyTable() {
    const tbody = document.querySelector('#family-table tbody');
    tbody.innerHTML = '';
    familyData.forEach((row, idx) => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td><input type="text" value="${row.name}" onchange="updateFamilyRow(${idx}, 'name', this.value)"></td>
            <td><input type="tel" value="${row.phone}" onchange="updateFamilyRow(${idx}, 'phone', this.value)"></td>
            <td><button class="remove-btn" onclick="removeFamilyRow(${idx})">Remove</button></td>
        `;
        tbody.appendChild(tr);
    });
}
function addFamilyRow() {
    familyData.push({ name: '', phone: '' });
    saveToLocalStorage('familyData', familyData);
    renderFamilyTable();
}
function removeFamilyRow(idx) {
    familyData.splice(idx, 1);
    saveToLocalStorage('familyData', familyData);
    renderFamilyTable();
}
function updateFamilyRow(idx, field, value) {
    familyData[idx][field] = value;
    saveToLocalStorage('familyData', familyData);
}
// --- Calendar Meeting ---
let calendarCurrent = new Date();
function renderCalendar() {
    const calendar = document.getElementById('calendar');
    if (!calendar) return;
    calendar.innerHTML = '';
    const year = calendarCurrent.getFullYear();
    const month = calendarCurrent.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const today = new Date();
    // Header
    const header = document.createElement('div');
    header.className = 'calendar-header';
    header.innerHTML = `
        <button onclick="changeCalendarMonth(-1)">&#8592;</button>
        <span>${firstDay.toLocaleString('default', { month: 'long' })} ${year}</span>
        <button onclick="changeCalendarMonth(1)">&#8594;</button>
    `;
    calendar.appendChild(header);
    // Days row
    const daysRow = document.createElement('div');
    daysRow.className = 'calendar-grid';
    ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'].forEach(day => {
        const d = document.createElement('div');
        d.className = 'calendar-day';
        d.textContent = day;
        daysRow.appendChild(d);
    });
    calendar.appendChild(daysRow);
    // Dates grid
    const grid = document.createElement('div');
    grid.className = 'calendar-grid';
    // Empty slots before first day
    for (let i = 0; i < firstDay.getDay(); i++) {
        const empty = document.createElement('div');
        grid.appendChild(empty);
    }
    // Dates
    for (let d = 1; d <= lastDay.getDate(); d++) {
        const date = new Date(year, month, d);
        const dateStr = date.toISOString().slice(0,10);
        const div = document.createElement('div');
        div.className = 'calendar-date';
        if (meetingsData.some(m => m.date === dateStr)) div.classList.add('has-meeting');
        if (dateStr === today.toISOString().slice(0,10)) div.classList.add('today');
        div.textContent = d;
        div.onclick = () => openCalendarModal(dateStr);
        grid.appendChild(div);
    }
    calendar.appendChild(grid);
}
function changeCalendarMonth(delta) {
    calendarCurrent.setMonth(calendarCurrent.getMonth() + delta);
    renderCalendar();
}
function openCalendarModal(dateStr) {
    document.getElementById('calendar-meetings-modal').style.display = 'flex';
    document.getElementById('calendar-modal-title').textContent = `Meetings for ${dateStr}`;
    document.getElementById('calendar-meeting-date').value = dateStr;
    // List meetings for this date
    const listDiv = document.getElementById('calendar-meetings-list');
    const meetings = meetingsData.filter(m => m.date === dateStr);
    if (meetings.length === 0) {
        listDiv.innerHTML = '<em>No meetings for this date.</em>';
    } else {
        listDiv.innerHTML = '<ul>' + meetings.map(m => `<li><strong>Agenda:</strong> ${m.agenda}<br><strong>Decisions:</strong> ${m.decisions}${m.zoom ? `<br><a href='${m.zoom}' target='_blank' class='zoom-link-btn'>Join Zoom</a>` : ''}</li>`).join('') + '</ul>';
    }
    document.getElementById('calendar-meeting-agenda').value = '';
    document.getElementById('calendar-meeting-decisions').value = '';
    document.getElementById('calendar-meeting-zoom').value = '';
}
function closeCalendarModal() {
    document.getElementById('calendar-meetings-modal').style.display = 'none';
}
function submitCalendarMeeting(e) {
    e.preventDefault();
    const date = document.getElementById('calendar-meeting-date').value;
    const agenda = document.getElementById('calendar-meeting-agenda').value.trim();
    const decisions = document.getElementById('calendar-meeting-decisions').value.trim();
    const zoom = document.getElementById('calendar-meeting-zoom').value.trim();
    if (!agenda || !decisions) return;
    meetingsData.push({ date, agenda, decisions, zoom });
    saveToLocalStorage('meetingsData', meetingsData);
    renderMeetingsTable();
    renderCalendar();
    openCalendarModal(date);
}
// --- Meetings Table ---
function renderMeetingsTable() {
    const tbody = document.querySelector('#meetings-table tbody');
    tbody.innerHTML = '';
    meetingsData.forEach((row, idx) => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td><input type="date" value="${row.date}" onchange="updateMeetingRow(${idx}, 'date', this.value)"></td>
            <td><input type="text" value="${row.agenda}" onchange="updateMeetingRow(${idx}, 'agenda', this.value)"></td>
            <td><textarea onchange="updateMeetingRow(${idx}, 'decisions', this.value)">${row.decisions}</textarea></td>
            <td>${row.zoom ? `<a href="${row.zoom}" target="_blank" class="zoom-link-btn">Join</a>` : `<input type="url" placeholder="https://zoom.us/..." value="${row.zoom||''}" onchange="updateMeetingRow(${idx}, 'zoom', this.value)">`}</td>
            <td><button class="remove-btn" onclick="removeMeetingRow(${idx})">Remove</button></td>
        `;
        tbody.appendChild(tr);
    });
}
function addMeetingRow() {
    meetingsData.push({ date: '', agenda: '', decisions: '', zoom: '' });
    meetingsData.push({ date: '', agenda: '', decisions: '' });
    saveToLocalStorage('meetingsData', meetingsData);
    renderMeetingsTable();
}
function removeMeetingRow(idx) {
    meetingsData.splice(idx, 1);
    saveToLocalStorage('meetingsData', meetingsData);
    renderMeetingsTable();
}
function updateMeetingRow(idx, field, value) {
    meetingsData[idx][field] = value;
    saveToLocalStorage('meetingsData', meetingsData);
    renderMeetingsTable();
    renderCalendar();
}
// --- Michango Table ---
function renderMichangoTable() {
    const tbody = document.querySelector('#michango-table tbody');
    tbody.innerHTML = '';
    michangoData.forEach((row, idx) => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td><input type="date" value="${row.date}" onchange="updateMichangoRow(${idx}, 'date', this.value)"></td>
            <td><input type="text" value="${row.name}" onchange="updateMichangoRow(${idx}, 'name', this.value)"></td>
            <td><input type="number" min="0" value="${row.amount}" onchange="updateMichangoRow(${idx}, 'amount', this.value)"></td>
            <td><input type="text" value="${row.purpose}" onchange="updateMichangoRow(${idx}, 'purpose', this.value)"></td>
            <td><button class="remove-btn" onclick="removeMichangoRow(${idx})">Remove</button></td>
        `;
        tbody.appendChild(tr);
    });
}
function addMichangoRow() {
    michangoData.push({ date: '', name: '', amount: '', purpose: '' });
    saveToLocalStorage('michangoData', michangoData);
    renderMichangoTable();
}
function removeMichangoRow(idx) {
    michangoData.splice(idx, 1);
    saveToLocalStorage('michangoData', michangoData);
    renderMichangoTable();
}
function updateMichangoRow(idx, field, value) {
    michangoData[idx][field] = value;
    saveToLocalStorage('michangoData', michangoData);
}
// --- Initialization ---
let familyData = loadFromLocalStorage('familyData');
let meetingsData = loadFromLocalStorage('meetingsData');
let michangoData = loadFromLocalStorage('michangoData');
window.onload = function() {
    renderFamilyTable();
    renderMeetingsTable();
    renderMichangoTable();
};
