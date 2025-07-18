// zoom.js - Render all Zoom links from meetingsData in localStorage
function loadFromLocalStorage(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : [];
}
function renderZoomLinks() {
    const meetings = loadFromLocalStorage('meetingsData');
    const tbody = document.querySelector('#zoom-table tbody');
    tbody.innerHTML = '';
    const zoomMeetings = meetings.filter(m => m.zoom && m.zoom.trim() !== '');
    if (zoomMeetings.length === 0) {
        const tr = document.createElement('tr');
        tr.innerHTML = '<td colspan="4" style="text-align:center;">No Zoom links found.</td>';
        tbody.appendChild(tr);
        return;
    }
    zoomMeetings.forEach(m => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${m.date || ''}</td>
            <td>${m.agenda || ''}</td>
            <td>${m.decisions || ''}</td>
            <td><a href="${m.zoom}" target="_blank" class="zoom-link-btn">Join Zoom</a></td>
        `;
        tbody.appendChild(tr);
    });
}
document.addEventListener('DOMContentLoaded', renderZoomLinks);
