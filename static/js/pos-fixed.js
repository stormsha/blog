(function ($) {
    $.extend($.fn, {
        posfixed: function (configSettings) {
            var settings = {
                direction: "bottom",
                type: "while",
                hide: false,
                distance: 0,
                left: 0
            };
            $.extend(settings, configSettings);

            //initial
            if ($.browser.msie && $.browser.version == 6.0) {
                $("html").css("overflow", "hidden");
                $("body").css({
                    height: "100%",
                    overflow: "auto"
                });
            }

            var obj = this;
            var initPos = $(obj).offset().top - $(window).scrollTop()
            var initPosRight = $(obj).offset().right;
            var anchoredPos = settings.distance;
            if (settings.type == "while") {
                if ($.browser.msie && $.browser.version == 6.0) {
                    $("body").scroll(function (event) {
                        var objTop = $(obj).offset().top - $("body").scrollTop();
                        if (objTop <= settings.distance) {
                            $(obj).css("position", "absolute");
                            $(obj).css("top", settings.distance + "px");
                            $(obj).css("left", settings.left);
                        }
                        if ($(obj).offset().top <= initPos) {
                            $(obj).css("position", "static");
                        }
                    });

                } else {
                    $(window).scroll(function (event) {
                        if (settings.direction == "top") {
                            var objTop = $(obj).offset().top - $(window).scrollTop();
                            console.log(objTop);
                            console.log(settings.distance);
                            if (objTop <= settings.distance) {
                                $(obj).css("position", "fixed");
                                $(obj).css(settings.direction, settings.distance + "px");
                                $(obj).css("left", settings.left)
                            }
                            if ($(obj).offset().top <= initPos) {
                                $(obj).css("position", "static");
                            }
                        } else {
                            if ( $(window).scrollTop() > initPos) {
                                console.log($(window).height(),  $(obj).offset().top, $(window).scrollTop(), $(obj).outerHeight());
                                $(obj).css("position", "fixed");
                                $(obj).css("top", $(obj).offset().top  + "px");
                                $(obj).css("left", settings.left)
                            }

                        }
                    });
                }
            }
            if (settings.type == "nav"){
                 if ($.browser.msie && $.browser.version == 6.0) {
                    console.log(settings.type);
                    $("body").scroll(function (event) {
                        var objTop = $(obj).offset().top - $("body").scrollTop();
                        if (objTop <= settings.distance) {
                            $(obj).css("position", "absolute");
                            $(obj).css("top", settings.distance + "px");
                            $(obj).css("left", settings.left);
                        }
                        if ($(obj).offset().top <= initPos) {
                            $(obj).css("position", "static");
                        }
                    });

                } else {
                    $(window).scroll(function (event) {
                        if (settings.direction == "top") {
                            var objTop = $(obj).offset().top - $(window).scrollTop();
                            if (objTop <= settings.distance) {
                                $(obj).css("position", "fixed");
                                $(obj).css(settings.direction, settings.distance + "px");
                            }
                            if ($(obj).offset().top <= initPos) {
                                $(obj).css("position", "static");
                            }
                        } else {
                            var objBottom = $(window).height() - $(obj).offset().top + $(window).scrollTop() - $(obj).outerHeight();

                            if (objBottom <= settings.distance) {

                                $(obj).css("position", "fixed");
                                $(obj).css(settings.direction, settings.distance + "px");

                            }
                            if ($(obj).offset().top >= initPos) {
                                $(obj).css("position", "static");
                            }
                        }
                    });
                }
            }
        }
    });


})(jQuery);


$(document).ready(function() {
    $("#sidebar").posfixed({
        direction: "bottom",
        distance: 0, //top值，高度
        type: "while",
        hide: false,
        left: "90.3%"
    });
});