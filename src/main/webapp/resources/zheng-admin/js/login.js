$(function() {
	// Waves初始化
	Waves.displayEffect();
	// 输入框获取焦点后出现下划线
	$('.form-control').focus(function() {
		$(this).parent().addClass('fg-toggled');
	}).blur(function() {
		$(this).parent().removeClass('fg-toggled');
	});
});
Checkbix.init();
$(function() {
	// 点击登录按钮
	$('#login-bt').click(function() {
		login();
	});
	// 回车事件
	$('#username, #password').keypress(function (event) {
		if (13 == event.keyCode) {
			login();
		}
	});
});
// 登录
function login() {

	$.ajax({
		url: BASE_PATH + '/sso/login',
		type: 'POST',
		data: {
			enterpriseCode: $('#enterpriseCode').val(),
			username: $('#username').val(),
			password: $('#password').val(),
			rememberMe: $('#rememberMe').is(':checked'),
			backurl: BACK_URL
		},
        dataType: 'json',
		beforeSend: function() {

		},
		success: function(json){
			// alert(json.msg);
			console.log(json);
			if(json.success){

				var obj = json.obj;
				if(obj!=null){

					var enterprises = obj.enterprises;
					var rememberMe = obj.rememberMe;
					var staffingEmp = obj.staffingEmp;
					enterpriseLoginAction(enterprises,rememberMe,staffingEmp);

					return;
				}

				window.location.href = BASE_PATH + json.msg;
			}else{


			}
		},
		error: function(error){
			console.log(error);
		}
	});
	
	
}

function enterpriseLoginAction(enterprises, rememberMe, staffingEmp) {

	// console.log(enterprises);
	// console.log(rememberMe);
	// console.log(staffingEmp);
	alert("多个账套 还没实现");

}