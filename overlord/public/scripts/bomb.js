'use strict';

var Bomb = Bomb || {};

Bomb.init = function () {
    Bomb.init_code_display();
    Bomb.init_keyboard_input();
    Bomb.init_keypad();
    Bomb.get_state_from_server();
};

Bomb.init_code_display = function () {
    $('input#code').change(function () {
        $('.code-display').html($('input#code').val());
    });
};

Bomb.init_keyboard_input = function () {
    $(window).keydown(function (e) {
        if (e.which === Key.enter) {
            $('#btn-enter').click();
            e.preventDefault();
        } else if (e.which == Key.backspace) {
            $('#btn-backspace').click();
            e.preventDefault();
        } else if (e.which >= Key.number_0 && e.which <= Key.number_9) {
            number = e.which - Key.number_0;
            $('.keypad button[data-value=' + number + ']').click();
            e.preventDefault();
        } else if (e.which >= Key.numpad_0 && e.which <= Key.numpad_9) {
            number = e.which - Key.numpad_0;
            $('.keypad button[data-value=' + number + ']').click();
            e.preventDefault();
        }
    });
};

Bomb.init_keypad = function () {
    Bomb.init_keypad_backspace();
    Bomb.init_keypad_enter();
    $('.keypad button[data-value]').click(function () {
        var number_pressed = $(this).data('value');
        Bomb.update_code_field(Bomb.get_code_field() + "" + number_pressed);
    });
};

Bomb.init_keypad_backspace = function () {
    $('#btn-backspace').click(function () {
        var value = Bomb.get_code_field();
        if (value.length > 0) {
            Bomb.update_code_field(value.substr(0, value.length - 1));
        }
    });
};

Bomb.init_keypad_enter = function () {
    $('#btn-enter').click(Bomb.submit_code);
};

Bomb.clear_code_field = function () {
    Bomb.update_code_field("");
};

Bomb.format_message = function (message) {
    var groups = [];
    var lines = message.split(/\n/);
    var temp = $('<div />');
    for (var i = 0; i < lines.length; i++) {
        groups.push(temp.text(lines[i]).html());
    }
    return groups.join("<br />");
};

Bomb.get_code_field = function () {
    return $('input#code').val() || "";
};

Bomb.get_state_from_server = function () {
    $.ajax({
        type: "GET",
        url: "/get_state",
        dataType: "json",
        error: Bomb.on_server_error,
        success: Bomb.handle_server_response
    });
};

Bomb.handle_server_response = function (result) {
    Bomb.update_state(result.state);
};

Bomb.on_server_error = function (request, status_message, error) {
    window.alert('Error connecting to server: ' + error);
};

Bomb.submit_code = function () {
    var _code = Bomb.get_code_field();
    Bomb.clear_code_field();
    $.ajax({
        type: "POST",
        url: "/code_entry",
        data: {code: _code},
        dataType: "json",
        error: Bomb.on_server_error,
        success: Bomb.handle_server_response
    });
};

Bomb.update_code_field = function (new_value) {
    if (new_value.length < 4) {
        $('input#code').val(new_value);
    } else {
        $('input#code').val(new_value.substr(0, 4));
    }
    $('input#code').change();
};


Bomb.update_state = function (state) {
    $('.activation_status').text(state.toUpperCase());
    $('.activation_status').attr('data-state', state);
    if (state === "exploded") {
        window.location.assign('/explosion');
    }
};

//an alias for $(document).ready() if you pass it a function
$(function () {
    Bomb.init();
});