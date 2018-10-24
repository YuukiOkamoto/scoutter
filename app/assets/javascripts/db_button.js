$('.power-btn').on('click', function(){
    $('.db-btn').addClass('db-spin');
});

$('.db-btn').on('click', function(){
    $(this).addClass('db-spin');
});

$('.db-btn').hover( () => {
    $('.power-btn').addClass('db-hover');
}, function() {
    $('.power-btn').removeClass('db-hover');
});
