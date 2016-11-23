$(document).on('turbolinks:load', function() {
    $('.member-image').click(function(e) {
        var member = e.currentTarget.dataset;
        var dialog = $('#member-dialog')[0];
        var dialogImage = dialog.querySelector('.bio-pic');
        var dialogName = dialog.querySelector('#member-name');
        var dialogGen = dialog.querySelector('#member-gen');
        var dialogMajor = dialog.querySelector('#member-major');
        var dialogBio = dialog.querySelector('#member-bio');

        dialogImage.src = member.image;
        dialogName.innerText = member.name;
        dialogGen.innerText = 'Generation ' + member.gen;
        dialogGen.href = member.genLink;
        dialogMajor.innerText = member.major;
        dialogBio.innerText = member.bio;

        dialog.withBackdrop = true;
        dialog.open();
    });
});
