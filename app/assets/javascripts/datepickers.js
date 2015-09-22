$(document).on('page:change', function () {
    $('.datepicker').pickadate({
        format: 'dddd, mmmm dd, yyyy',
        hiddenName: true
    });

    $('.timepicker').pickatime({
        clear: false,
        format: 'h:i A',
        interval: 15
    });
});
