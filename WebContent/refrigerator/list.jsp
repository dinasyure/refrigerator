<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#tbl{width:800px;border:1px solid black;overflow:hidden;}
	.box{width:130px;float:left;}
</style>

<h2>[냉장고 관리]</h2>

<table id="tbl2"></table>
<script id="temp2" type="text/x-handlebars-template">
	<tr class="title">
		<td width=70>아이디</td>
		<td width=130>재료명</td>
		<td width=70>보관장소</td>
		<td width=140>등록날짜</td>
		<td width=140>유통기한</td>		
		<td width=200>메 모</td>				
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
<br/>

<div id="divCondition">
	<button value="">전체</button><button value="과일/견과">과일/견과</button><button value="아이스크림/얼음">아이스크림/얼음</button><button value="정육/계란">정육/계란</button><button value="쌀/잡곡">쌀/잡곡</button><button value="수산/건어">수산/건어</button>
	<button value="채소/두부/콩나물">채소/두부/콩나물</button><button value="우유/유제품">우유/유제품</button><button value="냉장/냉동/간편식">냉장/냉동/간편식</button><button value="도시락/반찬/밀키트">도시락/반찬/밀키트</button><button value="베이커리/디저트">베이커리/디저트</button>
	<button value="생수/음료/주류">생수/음료/주류</button><button value="면/통조림/소스">면/통조림/소스</button><button value="과자/씨리얼/안주류">과자/씨리얼/안주류</button>
</div>

<div id="tbl"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box" style="cursor:pointer;">		
		<div onClick="location.href='/refrigerator/insert?ingredient_num={{ingredient_num}}'">{{ingredient_name}}</div>
	</div>
	{{/each}}
</script>

<script>
	//냉장고 식재료 목록
	$.ajax({
		type:"get",
		url:"/refrigerator/list.json",
		dataType:"json",
		success:function(result){
			var temp2=Handlebars.compile($("#temp2").html());
			$("#tbl2").html(temp2(result));
		}
	});
	
	//전체 식재료 목록
	$("#divCondition").on("click"," button",function(){
		var word=$(this).val();
		getList();
		function getList(){			
			$.ajax({
				type:"get",
				url:"/ing/list.json",
				dataType:"json",
				data:{"word":word},
				success:function(result){					
					var temp=Handlebars.compile($("#temp").html());
					$("#tbl").html(temp(result));				
				}
			});
		}
	});
	
</script>