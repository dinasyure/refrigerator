<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#tbl{width:800px;border:1px solid black;overflow:hidden;}
	.box{width:130px;float:left;}
</style>

<h2>[장바구니]</h2>

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
		<div onClick="location.href='/cart/insert?ingredient_num={{ingredient_num}}'">{{ingredient_name}}</div>
	</div>
	{{/each}}
</script>

<script>
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
				location.href="/cart/delete?cart_num=" + cart_num;
			}
		});		
	});
	
	//카트 식재료 삭제
	$("#tbl2").on("click",".row .btnDelete", function(){
		var cart_num=$(this).attr("cart_num");
		var name=$(this).parent().parent().find(".name").html();
		if(!confirm(name + " 을(를) 삭제하실래요?")) return;		
		location.href="/cart/delete?cart_num=" + cart_num;
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