//图片翻转
$(function() {

	//图片轮播
	var carousel = $(".carousel"), //获取最外层框架的名称
		ul = carousel.find("ul"),
		showNumber = carousel.find(".showNav span"), //获取按钮
		oneWidth = carousel.find("ul li").eq(0).width(); //获取每个图片的宽度
	var timer = null; //定时器返回值，主要用于关闭定时器
	var iNow = 0; //iNow为正在展示的图片索引值，当用户打开网页时首先显示第一张图，即索引值为0

	showNumber.on("click", function() { //为每个按钮绑定一个点击事件 
		$(this).addClass("active").siblings().removeClass("active"); //按钮点击时为这个按钮添加高亮状态，并且将其他按钮高亮状态去掉
		var index = $(this).index(); //获取哪个按钮被点击，也就是找到被点击按钮的索引值
		iNow = index;
		ul.animate({
			"left": -oneWidth * (iNow + 1) //注意此处用到left属性，所以ul的样式里面需要设置position: relative; 让ul左移N个图片大小的宽度，N根据被点击的按钮索引值iNOWx确定
		})
	});

	timer = setInterval(function() { //打开定时器
		iNow++; //让图片的索引值次序加1，这样就可以实现顺序轮播图片
		if (iNow > showNumber.length - 1) { //当到达最后一张图的时候，让iNow赋值为第一张图的索引值，轮播效果跳转到第一张图重新开始
			ul.stop().animate({
				"left": 0
			}, 0);
			iNow = 0;
		}
		showNumber.eq(iNow).trigger("click"); //模拟触发数字按钮的click
	}, 3000); //2000为轮播的时间
})


//04智库
$(function(){
	$(".list_nav1_main1 li").click(function(){
		$(this).addClass("now_find").siblings("li").removeClass("now_find")
	});


	$(".n-ul li").click(function(){
		$(this).addClass("page_now").siblings("li").removeClass("page_now")
	});

	$(".page_right").click(function(){
//			var pageIndex = $(".n-ul li").index($(".n-ul").find(".page_now"))-0;
		var pageIndex1 = $(".n-ul .page_now").find("a").text()-0;
		console.log(pageIndex1);
		if(pageIndex1 >= 5){
			for(var i =0 ; i<5;i++){
				$(".n-ul li").eq(i).html("<a href='#'>"+(i+pageIndex1+1)+"</a>")
			}
		}

	});
	$(".page_left").click(function(){
//			var pageIndex = $(".n-ul li").index($(".n-ul").find(".page_now"))-0;
		var pageIndex1 = $(".n-ul .page_now").find("a").text()-0;
		console.log(pageIndex1);
		if(pageIndex1 > 5){
			for(var i =5 ; i>0;i--){
				$(".n-ul li").eq(i-1).html("<a href='#'>"+(pageIndex1+i-6)+"</a>")
			}
		}else{
			for(var i =0 ; i<5;i++){
				$(".n-ul li").eq(i).html("<a href='#'>"+(i+1)+"</a>")
			}
		}

	});

});

