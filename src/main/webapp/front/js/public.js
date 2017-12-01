/**
 * Created by Administrator on 2017/5/23.
 */
var api = '';//http://172.16.35.242:8080

$(function(){
    //返回顶部
    //通用咨询
    $(".zx li").mouseenter(function(){
        $(this).children("div").show();
    });
    $(".zx li").mouseleave(function(){
        $(this).children("div").stop().hide();
    });
    $(window).scroll(function(){
        var A = $(window).scrollTop();
        if(A > 400){
            $("#back").css("visibility","visible");
        }else{
            $("#back").css("visibility","hidden");
        }
    });
    $("#back").click(function(){
        $("html,body").animate({
                "scrollTop":0
            },500
        );
    });

//在线报名
    $('.bmlist li').eq(0).mouseenter(function(){
        $(this).find('a span').html('QQ：2300705570');
    });
    $('.bmlist li').eq(0).mouseleave(function(){
        $(this).find('a span').html('线上报名');
    });
    $('.bmlist li').eq(1).mouseenter(function(){
        $(this).find('a span').html('QQ：2300705570');
    });
    $('.bmlist li').eq(1).mouseleave(function(){
        $(this).find('a span').html('线上报名');
    });
    $('.bmlist li').eq(2).mouseenter(function(){
        $(this).find('a span').html('0571-28828241');
    });
    $('.bmlist li').eq(2).mouseleave(function(){
        $(this).find('a span').html('电话咨询');
    });
});
// 函数用来解析来自URL的产讯传中的name = value参数对，并将其存储在一个对象的属性中，并且返回该对象
function urlArgs(){
    var args = {};
    var query = location.search.substring(1);
    var pairs = query.split("&");
    for(var i = 0;i < pairs.length; i++){
        var pos = pairs[i].indexOf("=");
        if(pos == -1) continue;
        var name = pairs[i].substring(0, pos);
        var value = pairs[i].substring(pos + 1);
        value = decodeURIComponent(value);
        args[name] = value;
    }
    return args;
}
function escape2Html(str) {
    if(str.indexOf("&#34;")){
        str = str.replace(/&#34;/ig,"&quot;");
    }
    var arrEntities={'&#34;':'"','lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig,function(all,t){return arrEntities[t];});
}



