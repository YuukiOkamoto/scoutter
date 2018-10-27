$(document).on('click', '.trigger', function (event) {
    event.preventDefault();
    $('#modal-top').iziModal('setZindex', 99999);
    $('#modal-top').iziModal('open', { zindex: 99999 });
    $('#modal-top').iziModal('open');
});
$("#modal-top").iziModal();
$("#modal-power").iziModal();
$("#modal-result").iziModal();
