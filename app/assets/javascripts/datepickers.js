$(document).on('turbolinks:load', function () {
    $('.full-datepicker').pickadate({
        format: 'dddd, mmmm dd, yyyy',
        hiddenName: true
    });

    $('.datepicker').pickadate({
        format: 'mmmm dd, yyyy',
        hiddenName: true
    });

    $('.timepicker').pickatime({
        clear: false,
        format: 'h:i A',
        interval: 15
    });
});
