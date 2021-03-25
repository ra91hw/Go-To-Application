/*
 * Dynamically set menu according to browser access address
 */
$('.sidebar-menu li:not(.treeview) > a').on('click', function(){
    var $parent = $(this).parent().addClass('active');
    $parent.siblings('.treeview.active').find('> a').trigger('click');
    $parent.siblings().removeClass('active').find('li').removeClass('active');
});

$(function () {
    $('.sidebar-menu a').each(function(){
        // console.log(this);
        var cur = window.location.href;
        var url = this.href;
        // console.log(cur.match(url));
        if(cur==url){
            $(this).parent().addClass('active')
                .closest('.treeview-menu').addClass('.menu-open')
                .closest('.treeview').addClass('active');
        }
    });
});


//Verification code refresh
function refresh(){
    $("#verifyCodeUrl").attr('src',"/captcha.jpg?t="+$.now());
}


//Background pop-up login
function login4Admin(){
    //Get the current browser address bar url
    var from = document.location.href;
    var username = $("#loginModalUserNmae").val();
    var password = $("#loginModalUserPwd").val();
    var verifyCode = $("#loginModalVerifyCode").val().trim();
    var rememberMe = $("#rememberMe").val();
    if (username == "" || username == null) {
        layer.msg("The user name cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
        $("#username").focus();
        return;
    }
    if (password == "" || password == null) {
        layer.msg("The password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
        $("#password").focus();
        return;
    }

    //Interact with the background
    var data = {"username":username,"password":password,"verifyCode":verifyCode,"rememberMe":rememberMe}
    $.ajax({
        url: "/admin/login",
        type: "POST",
        dataType: "JSON",
        contentType: "application/json",
        data: JSON.stringify(data),
        beforeSend: function () {
            // Disable button to prevent duplicate submission
            $("#login4Admin").attr({disabled: "disabled"});
        },
        success: function (data) {
            if (data.code == "200") {
                layer.msg("Login successfully！", {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                location.href = from;
            } else {
                layer.msg(data.message, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#login4Admin").removeAttr("disabled");
            }
        },
        complete: function () {
            $("#login4Admin").removeAttr("disabled");
        },
        error: function (data) {
            layer.msg(data.message, {icon: 5, time: 2000});
            $("#login4Admin").removeAttr("disabled");
        }
    });
}



