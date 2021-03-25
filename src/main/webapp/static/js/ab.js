$(document).ready(function () {



    //nav
    var oH2 = document.getElementById("mnavh");
    var oUl = document.getElementById("starlist");
    oH2.onclick = function ()
    {
        var style = oUl.style;
        style.display = style.display == "block" ? "none" : "block";
        oH2.className = style.display == "block" ? "open" : ""
    }

    var obj=null;
    var As=document.getElementById('starlist').getElementsByTagName('a');
    obj = As[0];
    for(i=1;i<As.length;i++){if(window.location.href.indexOf(As[i].href)>=0)
        obj=As[i];}
    obj.id='selected';

    /*

    search

    */
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

    window.addEventListener('scroll', function(e) {
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

    //

    (function(){
        var len = 100; //The number of words displayed by default
        var content = document.getElementById("content"); //content Get content div object
        var text = content.innerHTML;  // text is the content
        var span = document.createElement("span"); // Create a SPAN label
        var n = document.createElement("a");  // Create an A label
        span.innerHTML = text.substring(0,len); // The content of the SPAN tag is the first len ​​characters of text
        n.innerHTML = text.length > len ? "...Unfold" : ""; // The content of the created A tag, if the content of the content is greater than len, then it is ".. Expand", otherwise it is empty
        n.href = "javascript:void(0)"; // Set the link address of the A label (optional)
        n.onclick = function(){ // Click the A link to execute the following function
            // If the content of the A tag is ".. expand", then the content of the A tag becomes "collapsed", and the content of the SPAN tag is the entire content of the DIV, otherwise the content is the first len ​​characters
            if (n.innerHTML == "...Unfold"){
                n.innerHTML = "hide";
                span.innerHTML = text;
            }else{
                n.innerHTML = "...Unfold";
                span.innerHTML = text.substring(0,len);
            }
        }
        content.innerHTML = "";   // Set DIV content to empty
        content.appendChild(span); // Add the SPAN element to the DIV
        content.appendChild(n);   // Add the A element to the DIV
    })();

    $('.navlist li').click(function(){
        $(this).addClass('navcurrent').siblings().removeClass('navcurrent');
        $('.navtab>div:eq('+$(this).index()+')').show().siblings().hide();
    });


});