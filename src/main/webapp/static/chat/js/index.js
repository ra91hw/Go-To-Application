
// var friends = {
//   list: document.querySelector('ul.people'),
//   all: document.querySelectorAll('.left .person'),
//   name: '' },
//
// chat = {
//   container: document.querySelector('.container .right'),
//   current: null,
//   person: null,
//   name: document.querySelector('.container .right .top .name') };
//
//
// friends.all.forEach(function (f) {
//   f.addEventListener('mousedown', function () {
//     f.classList.contains('active') || setAciveChat(f);
//   });
// });

function setAciveChat(o) {

    $(".people .active").removeClass('active');
    $(o).addClass('active');
    $('.message .active-chat').removeClass('active-chat');
    var currentPerson = $(o).attr("data-chat");
    $('div[data-chat='+currentPerson+']').addClass('active-chat');
    var name = $(".people .active .name").text();
    $(".right .top .name").html(name);
    // Set the scroll bar at the bottom
    var message_box = $.find("div.active-chat .message-box");
    message_box[0].scrollTop = message_box[0].scrollHeight;	// The scroll bar is at the bottom
  // friends.list.querySelector('.active').classList.remove('active');
  // f.classList.add('active');
  // chat.current = chat.container.querySelector('.active-chat');
  // chat.person = f.getAttribute('data-chat');
  // chat.current.classList.remove('active-chat');
  // chat.container.querySelector('[data-chat="' + chat.person + '"]').classList.add('active-chat');
  // friends.name = f.querySelector('.name').innerText;
  // chat.name.innerHTML = friends.name;
}

/* js search operation */
$('#findinput').keydown(function(event){
    if(event.keyCode == 13){
        var keyword = $(this).val()
        var data = {'userId': userId,"nickname":keyword};
        $.ajax({
            url: '/getFriendList',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (data) {
                if (data.code == 200) {
                    var user1 = data.body.user1;
                    var friendList = data.body.friendList;
                    $(".people").empty();
                    $(".message").empty();
                    $.each(friendList, function(index, value) {
                        var friend = value;
                        var friendAccount = friend.user2;
                        var lastMessage = friend.lastMessage;
                        var messageList = friend.messageList;
                        $(".people").append(
                            '<li class="person" data-chat="'+friendAccount.id+'">' +
                            '<img src="'+friendAccount.avatar+'" alt="" />' +
                            '<span class="name">'+friendAccount.nickname+'</span>' +
                            '<span class="time">'+(lastMessage == null ? "" : lastMessage.createTime)+'</span>' +
                            '<span class="preview">'+(lastMessage == null ? "" : lastMessage.message)+'</span>' +
                            '</li>');
                        var chatDiv=$('<div class="chat" data-chat="'+friendAccount.id+'"></div>');
                        var messageBoxDiv = $('<div class="detail message-box"></div>');
                        $.each(messageList, function(index, value) {
                            var oneChatClasDiv = $('<div class="oneChatClass""></div>');
                            if(value.flag == 1){
                                var divClassYou = $(
                                    '<div class="divClassYou">' +
                                    '   <img class="photo you" src="'+friendAccount.avatar+'" width="40" height="40">' +
                                    '   <div class="bubble you">' + value.message + '</div>' +
                                    '</div>');
                                divClassYou.appendTo(oneChatClasDiv);
                            }else{
                                var divClassMe = $(
                                    '<div class="divClassMe">' +
                                    '   <img class="photo me" src="'+ user1.avatar + '" width="40" height="40">' +
                                    '   <div class="bubble me">' + value.message +'</div>' +
                                    '</div>');
                                divClassMe.appendTo(oneChatClasDiv);
                            }
                            oneChatClasDiv.appendTo(messageBoxDiv);
                        });
                        messageBoxDiv.appendTo(chatDiv);
                        chatDiv.appendTo($(".message"));
                    });
                    // Set the first friend to be selected
                    $('.people li:first').addClass("active") ;
                    $('.message div:first').addClass("active-chat") ;
                    var name = $('.people li:first .name').text();
                    $('.right .top .name').html(name);
                    // Set the scroll bar at the bottom
                    var message_box = $.find("div.active-chat .message-box");
                    message_box[0].scrollTop = message_box[0].scrollHeight;	// The scroll bar is at the bottom
                } else if (data.code == "403") {
                    $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
                    $("#registerModal").modal("show");
                }
            },
            complete: function () {
                $("#register_submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#register_submit").removeAttr("disabled");
            }
        });
    }
})