// helper function to AJAX pull a new room message
$(function() {
    $('#new_room_message').on('ajax:success', function(a, b,c ) {
        $(this).find('input[type="text"]').val('');
    });
});
