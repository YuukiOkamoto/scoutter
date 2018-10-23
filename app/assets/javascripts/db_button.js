$('.power-btn').on('click', function(){
    $('.db-btn').addClass('db-spin');
});

$('.db-btn').on('click', function(){
    $(this).addClass('db-spin');
});

$('.db-btn').hover( () => {
    $('.power-btn').css('color', '#fff');
    $('.power-btn').css('background-color', '#d23430');
    $('.power-btn').css('border-color', '#c9302c');
}, function() {
    $('.power-btn').css('color', '');
    $('.power-btn').css('background-color', '');
    $('.power-btn').css('border-color', '');
});
