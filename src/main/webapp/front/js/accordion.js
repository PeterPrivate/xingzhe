/**
 * Created by Administrator on 2017/6/23.
 */
/*手风琴*/
;(function($){
    $.fn.accordion = function(opts){
        //默认值
        var defaults = {
            max: "340px",
            min: "168px",
            speed: "1000"
        };

        var opts = $.extend(defaults, opts);

        this.each(function(){
            var t = $(this),
                m = t.children(),
                c = m.children();

            //触发事件
            /*  /!* m.find(".active a").show();*!/*/
            m.on("mouseenter","li",function(){
                $(this).addClass('active')
                    .animate({width:opts.max},opts.speed)
                    .find("a").show()
                    .parent().siblings().removeClass('active')
                    .animate({width:opts.min},opts.speed)
                    .find("a").hide();
            })
        })
    }

})(jQuery);