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
	
})
