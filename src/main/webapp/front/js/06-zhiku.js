$(function() {
	$("#btnInvitation").click(function() {
		$("div[class='alert'],.alert_content").css('display', 'block');
	})
	$("img[class='close']").click(function() {
		$("div[class='alert'],.alert_content").css('display', 'none');
	})
    /*var tip,
        tipPre = '<div class="tip" style="text-align: left;width: 292px;margin: 5px auto;color: red;font-size: 14px">';
    tipPos ='</div>';*/
	$("div[class='alert_content'] input[placeholder='主办方'],div[class='alert_content'] input[placeholder='联系人']").blur(function() {
		if($(this).val() == '') {
			$(this).css({
            'background': 'rgba(237,71,54,.15)'
			})
            /*tip = $(this).attr("placeholder")+"不能为空";
            tip = tipPre+tip+tipPos;
            $(this).after(tip);*/
		}
	}).focus(function() {
        $(this).css('background-color', '');
    })
        /*$(this).next('div').remove();*/

	$("div[class='alert_content'] input[placeholder='手机号']").blur(function() {
		if(!(/^1[3578]\d{9}$/.test($(this).val()))) {
			$(this).css({
                'background': 'rgba(237,71,54,.15)'
			})
           /* tip = "请输入正确的手机格式";
            tip = tipPre+tip+tipPos;
            $(this).after(tip);*/
		}
	}).focus(function() {
        $(this).css('background-color', '');
        /*$(this).next('div').remove();*/
	})

	$("div[class='alert_content'] input[placeholder='费用预算']").blur(function() {
		if(!(/^\d+/.test($(this).val()))) {
			$(this).css({
                'background': 'rgba(237,71,54,.15)'
			})
           /* tip = "请输入正确的金额";
            tip = tipPre+tip+tipPos;
            $(this).after(tip);*/
		}
	}).focus(function() {
        $(this).css('background-color', '');
        /*$(this).next('div').remove();*/
	})

	$("div[class='alert_content'] input[placeholder='验证码']").blur(function() {
		if(!(/^\d{4}/.test($(this).val()))) {
			$(this).css({
                'background': 'rgba(237,71,54,.15)'
			})
		}
	}).focus(function() {
        $(this).css('background-color', '');
	})

	$("span[class='verification']").on('click', verification)

	function verification() {
        var time = 60;
        $(this).css('background-color', '#ccc').off('click').text(time + '秒后重新获取');
        var tid = setInterval(function () {
            time--;
            $("span[class='verification']").text(time + '秒后重新获取')
            if (time == -1) {
                $("span[class='verification']").css('background-color', '#ed4736').text('获取验证码');
                clearInterval(tid);
                $("span[class='verification']").on('click', verification)
            }
        }, 1000)
    }

})