$(document).on('click', '#what-scoutter', function (event) {
    event.preventDefault();
    $('#modal-top').iziModal('setZindex', 99999);
    $('#modal-top').iziModal('open', { zindex: 99999 });
    $('#modal-top').iziModal('open');
});
$("#modal-top").iziModal({
    title: 'スカウッターとは？',
    group: 'scoutter',
    width: 800
});
$("#modal-power").iziModal({
    title: '戦闘力をはかろう！',
    group: 'scoutter',
    width: 800
});
$("#modal-result").iziModal({
    title: 'あなたの戦闘力は！？',
    group: 'scoutter',
    width: 800
});
$("#modal-last").iziModal({
    title: 'Let\'s Start!!!',
    group: 'scoutter',
    width: 800
});
