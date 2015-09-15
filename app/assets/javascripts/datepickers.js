$(document).on('page:change', function () {
    $('.datepicker').pickadate({
        format: 'dddd, mmmm d, yyyy',
        hiddenName: true
    });

    $('.timepicker').pickatime({
    });
});
