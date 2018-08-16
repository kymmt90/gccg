function popUpConfirmation(event, message) {
  if (!window.confirm(message)) {
    event.preventDefault();
  }
}

var el = document.getElementById('calendar-delete-form');
if (el) {
  el.addEventListener('submit', (event) => { return popUpConfirmation(event, 'カレンダーを消しますか？'); });
}
