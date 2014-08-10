jQuery(function() {
    return $(window).scroll(function() {
        var navbar = document.getElementById("nav-header");
        var distFromTop = function(elem) {
            var pageTop = $(window).scrollTop();
            //var elemTop = elem.offset().top;
            elemTop = 215;
            return(elemTop - pageTop);
        }
        var banner = document.getElementById("banner");
        if (distFromTop(navbar) <= 0) {
            banner.className = "header-fixed";
            navbar.className = "fixed";
        } else {
            banner.classList.remove("header-fixed");
            navbar.className = "not-fixed";
        }
    });
});
