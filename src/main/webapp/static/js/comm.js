$(document).ready(function () {

    //banner
    $('#banner').easyFader();

    //nav
    var oH2 = document.getElementById("mnavh");
    var oUl = document.getElementById("starlist");
    oH2.onclick = function () {
        var style = oUl.style;
        style.display = style.display == "block" ? "none" : "block";
        oH2.className = style.display == "block" ? "open" : ""
    }

    //The navigation menu at the top of the website dynamically sets the click style
    var obj = null;
    var As = document.getElementById('starlist').getElementsByTagName('a');
    obj = As[0];
    for (i = 1; i < As.length; i++) {
        if (window.location.href.indexOf(As[i].href) >= 0)
            obj = As[i];
    }
    obj.id = 'selected';


    //The menu on the left side of the website's personal center
    var lis = $('.pagemenu').find('li');
    $.each(lis,function(i,li){  //Traverse a two-dimensional array
        var href = $(li).find('a').attr('href');
        if (window.location.href.indexOf(href) >= 0){
            $(li).addClass('active');
        }
    })

    //search
    $('.search_ico').click(function () {
        $('.search_bar').toggleClass('search_open');
        if ($('#keyboard').val().length > 2) {
            $('#keyboard').val('');
            $('#searchform').submit();
        } else {
            return false;
        }
    });


    //header
    var new_scroll_position = 0;
    var last_scroll_position;
    var header = document.getElementById("header");

    window.addEventListener('scroll', function (e) {
        last_scroll_position = window.scrollY;

        if (new_scroll_position < last_scroll_position && last_scroll_position > 80) {
            header.classList.remove("slideDown");
            header.classList.add("slideUp");

        } else if (new_scroll_position > last_scroll_position) {
            header.classList.remove("slideUp");
            header.classList.add("slideDown");
        }

        new_scroll_position = last_scroll_position;
    });

    //scroll to top
    var offset = 300,
        offset_opacity = 1200,
        scroll_top_duration = 700,
        $back_to_top = $('.cd-top');

    $(window).scroll(function () {
        ($(this).scrollTop() > offset) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass('cd-is-visible cd-fade-out');
        if ($(this).scrollTop() > offset_opacity) {
            $back_to_top.addClass('cd-fade-out');
        }
    });
    $back_to_top.on('click', function (event) {
        event.preventDefault();
        $('body,html').animate({
                scrollTop: 0,
            }, scroll_top_duration
        );
    });

    //aside
    var Sticky = new hcSticky('aside', {
        stickTo: 'article',
        innerTop: 200,
        followScroll: false,
        queries: {
            480: {
                disable: true,
                stickTo: 'body'
            }
        }
    });

//scroll
    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
        window.scrollReveal = new scrollReveal({reset: true});
    }
    ;

//tab	
//     var oLi = document.getElementById("tab").getElementsByTagName("a");
//     var oUls = document.getElementById("content").getElementsByTagName("ul");

    // for (var i = 0; i < oLi.length; i++) {
    //     oLi[i].index = i;
    //     oLi[i].onmouseover = function () {
    //         for (var n = 0; n < oLi.length; n++) oLi[n].className = "";
    //         this.className = "current";
    //         for (var n = 0; n < oUls.length; n++) oUls[n].style.display = "none";
    //         oUls[this.index].style.display = "block"
    //     }
    // }
    // ;

});


$(function () {
    $('#register_form').submit(function (e) {
        e.preventDefault();
        var username = $.trim($('#registerUsername').val());
        var nickname = $.trim($('#registerNickname').val());
        var password = $.trim($('#registerPassword').val());
        var confirmPassword = $.trim($('#registerConfirmPassword').val());

        if (username == null || username == '') {
            layer.msg("Username cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerUserName").focus();
            return;
        }
        if (nickname == null || nickname == '') {
            layer.msg("Nickname cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerNickName").focus();
            return;
        }
        if (password == null || password == '') {
            layer.msg("Password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerPassword").focus();
            return;
        }
        if (confirmPassword == null || confirmPassword == '') {
            layer.msg("Confirmable password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerConfirmPassword").focus();
            return;
        }
        if (confirmPassword != password) {
            layer.msg("Confirmable password must be the same as the password！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerConfirmPassword").focus();
            return;
        }
        var data = {'username': username, 'nickname': nickname, 'password': password};
        $.ajax({
            url: '/signup',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // Disable button to prevent duplicate submission
                $("#register_submit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $("#registerModal").modal("hide");
                } else if (data.code == "403") {
                    $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
                    $("#registerModal").modal("show");
                }
                else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#register_submit").removeAttr("disabled");

            },
            complete: function () {
                $("#register_submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#register_submit").removeAttr("disabled");
            }
        });
    });


    $('#login_form').submit(function (e) {
        e.preventDefault();
        var username = $.trim($('#loginUsername').val());
        var password = $.trim($('#loginPassword').val());
        if (username == null || username == '') {
            layer.msg("Username cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerUsername").focus();
            return;
        }
        if (password == null || password == '') {
            layer.msg("Password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerPassword").focus();
            return;
        }
        var data = {'username': username, 'password': password};
        $.ajax({
            url: '/signin',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // Disable button to prevent duplicate submission
                $("#login_submit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    window.location.reload();
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#login_submit").removeAttr("disabled");

            },
            complete: function () {
                $("#login_submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#login_submit").removeAttr("disabled");
            }
        });
    })
});

//Site search
function checkForm() {

    //Parameter verification
    var wd = $("#wd").val();
    if (wd == "" || wd == null) {
        layer.msg("Please enter key words！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
        $("#wd").focus();
        return false;
    }
    return true;
}