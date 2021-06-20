<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="menuItem"><a href="/myinfo">내정보</a></div>
<div class="menuItem"><a href="/refrigerator/list">냉장고</a></div>
<div class="menuItem"><a href="/search">레시피</a></div>
<div class="menuItem"><a href="/cart/list">장바구니</a></div>
<div class="menuItem"><a href="/bbs/list">게시판</a></div>


<div style="float:right">
	<c:if test="${user.uid==null}">
		<form name="frmLogin" method="post" action="login">
			<input type="text" name="uid" size=5/>
			<input type="password" name="upass" size=5/>
			<input type="submit" value="로그인"/>
		</form>
	</c:if>	
	<c:if test="${user.uid!=null}">
		${user.uname}님
		<button onClick="location.href='/user/logout'">로그아웃</button>
	</c:if>
</div>

<script>
	$(frmLogin).on("submit", function(e){
		e.preventDefault();
		var uid=$(frmLogin.uid).val();
		var upass=$(frmLogin.upass).val();
		
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{"uid":uid, "upass":upass},
			success:function(result){
				if(result==0){
					alert("아이디가 존재하지 않습니다")
					$(frmLogin.uid).focus();
				}else if(result==2){
					alert("비밀번호가 일치하지 않습니다");
					$(frmLogin.upass).focus();
				}else{
					alert("로그인 성공");
					location.href="/home";
				}
			}
		});
	});
</script>