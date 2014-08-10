jQuery(function() {
    return $(window).scroll(function() {
        var navDistFromTop = function() {
            var pageTop = $(window).scrollTop();
            //var elemTop = $('#nav-header').offset().top;
            var elemTop = 215;
            return(elemTop - pageTop);
        }
        var navbar = document.getElementById("nav-header");
        var banner = document.getElementById("banner");
        if (navDistFromTop() <= 0) {
            banner.className = "header-fixed";
            navbar.className = "fixed";
        } else {
            banner.classList.remove("header-fixed");
            navbar.className = "not-fixed";
        }
    });
});
