<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<button id="btnRefShow" style="margin-left:10px;">냉장고 보기</button>
<div id="refInfo">
	<button id="btnRefHidden" style="margin-left:10px;">냉장고 숨기기</button>
	<h2>[내 재료 목록]</h2>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=70>아이디</td>
		<td width=130>재료명</td>
		<td width=70>보관장소</td>
		<td width=140>등록날짜</td>
		<td width=140>유통기한</td>		
		<td width=200>메모</td>				
	</tr>
	{{#each .}}
	<tr class="row" onClick="location.href='/refrigerator/read?refrigerator_num={{refrigerator_num}}'">
		<td>{{refrigerator_userid}}</td>
		<td>{{ingredient_name}}</td>
		<td>{{refrigerator_place}}</td>
		<td>{{refrigerator_date}}</td>
		<td>{{refrigerator_exDate}}</td>		
		<td>{{refrigerator_memo}}</td>				
	</tr>
	{{/each}}
	</script>
</div>

<br/>

<button id="btnCartShow" style="margin-left:10px;">장바구니 보기</button>
<div id="cartInfo">
	<button id="btnCartHidden" style="margin-left:10px;">장바구니 숨기기</button>
	<h2>[내 장바구니 목록]</h2>
	<table id="tbl2"></table>
	<script id="temp2" type="text/x-handlebars-template">
		<tr class="title">		
			<td width=70>아이디</td>
			<td width=130>재료명</td>
			<td width=70>보관장소</td>				
			<td width=380>메 모</td>
			<td width=100>등록/삭제</td>				
		</tr>
		{{#each .}}
		<tr class="row" ingNum={{cart_ingNum}}>		
			<td class="id">{{cart_userid}}</td>
			<td class="name">{{ingredient_name}}</td>
			<td class="place">{{cart_place}}</td>				
			<td class="memo">{{cart_memo}}</td>
			<td>
				<button class="btnInsert" cart_num={{cart_num}}>등록</button>/
				<button class="btnDelete" cart_num={{cart_num}}>삭제</button>
			</td>				
		</tr>
		{{/each}}
	</script>
</div>

<br/>

<button id="btnBbsShow" style="margin-left:10px;">게시글 보기</button>
<div id="bbsInfo">
	<button id="btnBbsHidden" style="margin-left:10px;">게시글 숨기기</button>
	<h2>[내 게시글 목록]</h2>
	<table id="bbsTbl"></table>
	<script id="bbsTemp" type="text/x-handlebars-template">
		<tr class="title">				
			<td width=70>글 번호</td>
			<td width=90>카테고리</td>
			<td width=450>제 목</td>				
			<td width=90>작성자</td>
			<td width=160>작성일</td>
		</tr>
		{{#each array}}
		<tr class="row" style="cursor:pointer" onClick="location.href='/bbs/read?bbs_num={{bbs_num}}'">				
			<td>{{bbs_num}}</td>
			<td>{{bbs_type}}</td>
			<td>{{title}}</td>				
			<td>{{writer}}</td>
			<td>{{wdate}}</td>
		</tr>
		{{/each}}
	</script>
</div>

<script>
getList();

//게시글 숨기기 보이기
$("#btnBbsShow").hide();
$("#btnBbsShow").on("click",function(){
	$("#bbsInfo").show();
	$("#btnBbsShow").hide();
});
$("#btnBbsHidden").on("click",function(){
	$("#bbsInfo").hide();
	$("#btnBbsShow").show();
});

//게시글 목록
function getList(){	
	var order="bbs_num";
	var desc="desc";
	var page=1;
	var perpage=999;
	$.ajax({
		type:"get",
		url:"/bbslist.json",
		dataType:"json",
		data:{"order":order, "desc":desc, "page":page, "perpage":perpage},
		success:function(result){
			var temp=Handlebars.compile($("#bbsTemp").html());
			$("#bbsTbl").html(temp(result));
			$("#count").html(result.count);			
		}
	});
}

//카트 정보 숨기기 보이기
$("#btnCartShow").hide();
$("#btnCartShow").on("click",function(){
	$("#cartInfo").show();
	$("#btnCartShow").hide();
});
$("#btnCartHidden").on("click",function(){
	$("#cartInfo").hide();
	$("#btnCartShow").show();
});

//카트 식재료 냉장고 등록
$("#tbl2").on("click",".row .btnInsert", function(){		
	var name=$(this).parent().parent().find(".name").html();
	if(!confirm(name + " 을(를) 냉장고에 등록하실래요?")) return;
	var row=$(this).parent().parent();
	var refrigerator_userid=row.find(".id").html();
	var refrigerator_ingNum=row.attr("ingNum");
	var refrigerator_place=row.find(".place").html();
	var refrigerator_memo=row.find(".memo").html();
	var cart_num=$(this).attr("cart_num");
	//alert(refrigerator_userid + "/"+ refrigerator_ingNum + "/"+ refrigerator_place + "/"+ refrigerator_memo);
	$.ajax({
		type:"post",
		url:"/refrigerator/insert",
		data:{"refrigerator_userid":refrigerator_userid,"refrigerator_ingNum":refrigerator_ingNum,"refrigerator_place":refrigerator_place,"refrigerator_memo":refrigerator_memo},
		success:function(){
			alert("등록되었습니다.");
			location.href="/cartdelete?cart_num=" + cart_num;
		}
	});		
});

//카트 식재료 삭제
$("#tbl2").on("click",".row .btnDelete", function(){
	var cart_num=$(this).attr("cart_num");
	var name=$(this).parent().parent().find(".name").html();
	if(!confirm(name + " 을(를) 삭제하실래요?")) return;		
	location.href="/cartdelete?cart_num=" + cart_num;
});

//카트 식재료 목록
$.ajax({
	type:"get",
	url:"/cart/list.json",
	dataType:"json",
	success:function(result){
		var temp2=Handlebars.compile($("#temp2").html());
		$("#tbl2").html(temp2(result));
	}
});

//냉장고 정보 숨기기 보이기
$("#btnRefShow").hide();
$("#btnRefShow").on("click",function(){
	$("#refInfo").show();
	$("#btnRefShow").hide();
});
$("#btnRefHidden").on("click",function(){
	$("#refInfo").hide();
	$("#btnRefShow").show();
});

//냉장고 식재료 목록
$.ajax({
	type:"get",
	url:"/refrigerator/list.json",
	dataType:"json",
	success:function(result){
		var temp=Handlebars.compile($("#temp").html());
		$("#tbl").html(temp(result));
	}
});
</script>