// --- Utility Functions ---
function saveToLocalStorage(key, data) {
    localStorage.setItem(key, JSON.stringify(data));
}
function loadFromLocalStorage(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : [];
}
// --- Error Message Utility ---
function showError(message) {
    const errorDiv = document.getElementById('error-message');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        setTimeout(() => { hideError(); }, 6000);
    }
}
function hideError() {
    const errorDiv = document.getElementById('error-message');
    if (errorDiv) errorDiv.style.display = 'none';
}

// --- Family Table (Firestore) ---
let familyData = [];

async function loadFamilyData() {
    const snapshot = await db.collection('family').get();
    familyData = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    renderFamilyTable();
}

function renderFamilyTable() {
    const tbody = document.querySelector('#family-table tbody');
    tbody.innerHTML = '';
    familyData.forEach((row, idx) => {
        const isOwner = row.creatorId === window.currentUserId;
        const nameInput = isOwner ? `<input type="text" value="${row.name}" onchange="updateFamilyRow('${row.id}', 'name', this.value)">` : `<span>${row.name}</span>`;
        const phoneInput = isOwner ? `<input type="tel" value="${row.phone}" onchange="updateFamilyRow('${row.id}', 'phone', this.value)">` : `<span>${row.phone}</span>`;
        const removeBtn = isOwner ? `<button class="remove-btn" onclick="removeFamilyRow('${row.id}')">Remove</button>` : '';
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${nameInput}</td>
            <td>${phoneInput}</td>
            <td>${removeBtn}</td>
        `;
        tbody.appendChild(tr);
    });
}

async function addFamilyRow() {
    try {
        await db.collection('family').add({ name: '', phone: '', creatorId: window.currentUserId });
        await loadFamilyData();
    } catch (err) {
        showError('Failed to add family member: ' + (err && err.message ? err.message : err));
    }
}

async function removeFamilyRow(id) {
    const doc = familyData.find(f => f.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('family').doc(id).delete();
        await loadFamilyData();
    }
}

async function updateFamilyRow(id, field, value) {
    const doc = familyData.find(f => f.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('family').doc(id).update({ [field]: value });
        await loadFamilyData();
    }
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
// --- Meetings Table (Firestore) ---
let meetingsData = [];

async function loadMeetingsData() {
    const snapshot = await db.collection('meetings').get();
    meetingsData = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    renderMeetingsTable();
    renderCalendar();
}

function renderMeetingsTable() {
    const tbody = document.querySelector('#meetings-table tbody');
    tbody.innerHTML = '';
    meetingsData.forEach((row, idx) => {
        const isOwner = row.creatorId === window.currentUserId;
        const dateInput = isOwner ? `<input type="date" value="${row.date}" onchange="updateMeetingRow('${row.id}', 'date', this.value)">` : `<span>${row.date}</span>`;
        const agendaInput = isOwner ? `<input type="text" value="${row.agenda}" onchange="updateMeetingRow('${row.id}', 'agenda', this.value)">` : `<span>${row.agenda}</span>`;
        const decisionsInput = isOwner ? `<textarea onchange="updateMeetingRow('${row.id}', 'decisions', this.value)">${row.decisions}</textarea>` : `<span>${row.decisions}</span>`;
        const zoomInput = isOwner
            ? (row.zoom ? `<a href="${row.zoom}" target="_blank" class="zoom-link-btn">Join</a>` : `<input type="url" placeholder="https://zoom.us/..." value="${row.zoom||''}" onchange="updateMeetingRow('${row.id}', 'zoom', this.value)">`)
            : (row.zoom ? `<a href="${row.zoom}" target="_blank" class="zoom-link-btn">Join</a>` : '');
        const removeBtn = isOwner ? `<button class="remove-btn" onclick="removeMeetingRow('${row.id}')">Remove</button>` : '';
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${dateInput}</td>
            <td>${agendaInput}</td>
            <td>${decisionsInput}</td>
            <td>${zoomInput}</td>
            <td>${removeBtn}</td>
        `;
        tbody.appendChild(tr);
    });
}

async function addMeetingRow() {
    try {
        await db.collection('meetings').add({ date: '', agenda: '', decisions: '', zoom: '', creatorId: window.currentUserId });
        await loadMeetingsData();
    } catch (err) {
        showError('Failed to add meeting: ' + (err && err.message ? err.message : err));
    }
}

async function removeMeetingRow(id) {
    const doc = meetingsData.find(m => m.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('meetings').doc(id).delete();
        await loadMeetingsData();
    }
}

async function updateMeetingRow(id, field, value) {
    const doc = meetingsData.find(m => m.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('meetings').doc(id).update({ [field]: value });
        await loadMeetingsData();
    }
}

// --- Michango Table (Firestore) ---
let michangoData = [];

async function loadMichangoData() {
    const snapshot = await db.collection('michango').get();
    michangoData = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    renderMichangoTable();
}

function renderMichangoTable() {
    const tbody = document.querySelector('#michango-table tbody');
    tbody.innerHTML = '';
    michangoData.forEach((row, idx) => {
        const isOwner = row.creatorId === window.currentUserId;
        const dateInput = isOwner ? `<input type="date" value="${row.date}" onchange="updateMichangoRow('${row.id}', 'date', this.value)">` : `<span>${row.date}</span>`;
        const nameInput = isOwner ? `<input type="text" value="${row.name}" onchange="updateMichangoRow('${row.id}', 'name', this.value)">` : `<span>${row.name}</span>`;
        const amountInput = isOwner ? `<input type="number" min="0" value="${row.amount}" onchange="updateMichangoRow('${row.id}', 'amount', this.value)">` : `<span>${row.amount}</span>`;
        const purposeInput = isOwner ? `<input type="text" value="${row.purpose}" onchange="updateMichangoRow('${row.id}', 'purpose', this.value)">` : `<span>${row.purpose}</span>`;
        const removeBtn = isOwner ? `<button class="remove-btn" onclick="removeMichangoRow('${row.id}')">Remove</button>` : '';
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${dateInput}</td>
            <td>${nameInput}</td>
            <td>${amountInput}</td>
            <td>${purposeInput}</td>
            <td>${removeBtn}</td>
        `;
        tbody.appendChild(tr);
    });
}

async function addMichangoRow() {
    try {
        await db.collection('michango').add({ date: '', name: '', amount: '', purpose: '', creatorId: window.currentUserId });
        await loadMichangoData();
    } catch (err) {
        showError('Failed to add michango: ' + (err && err.message ? err.message : err));
    }
}

async function removeMichangoRow(id) {
    const doc = michangoData.find(m => m.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('michango').doc(id).delete();
        await loadMichangoData();
    }
}

async function updateMichangoRow(id, field, value) {
    const doc = michangoData.find(m => m.id === id);
    if (doc && doc.creatorId === window.currentUserId) {
        await db.collection('michango').doc(id).update({ [field]: value });
        await loadMichangoData();
    }
}

// --- Initialization ---
window.onload = async function() {
    // Display user ID
    const userIdSpan = document.getElementById('user-id-value');
    if (userIdSpan && window.currentUserId) {
        userIdSpan.textContent = window.currentUserId;
    }
    // Copy to clipboard logic
    const copyBtn = document.getElementById('copy-user-id-btn');
    if (copyBtn && window.currentUserId) {
        copyBtn.onclick = function() {
            navigator.clipboard.writeText(window.currentUserId).then(() => {
                const oldText = copyBtn.textContent;
                copyBtn.textContent = 'Copied!';
                setTimeout(() => { copyBtn.textContent = oldText; }, 1200);
            });
        };
    }
    await loadFamilyData();
    await loadMeetingsData();
    await loadMichangoData();
};
