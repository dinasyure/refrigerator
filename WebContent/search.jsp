<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.RCP_NM {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>

<button id="btnShow" style="margin-left:10px;">냉장고 보기</button>
<div id="refInfo">
	<button id="btnHidden" style="margin-left:10px;">냉장고 숨기기</button>
	<h2>[내 재료 목록]</h2>
	<table id="tbl2"></table>
	<script id="temp2" type="text/x-handlebars-template">
	<tr class="title">
		<td width=70>아이디</td>
		<td width=130>재료명</td>
		<td width=70>보관장소</td>
		<td width=140>등록날짜</td>
		<td width=140>유통기한</td>		
		<td width=200>메모</td>				
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{refrigerator_userid}}</td>
		<td class="name">{{ingredient_name}}</td>
		<td>{{refrigerator_place}}</td>
		<td>{{refrigerator_date}}</td>
		<td>{{refrigerator_exDate}}</td>		
		<td>{{refrigerator_memo}}</td>				
	</tr>
	{{/each}}
	</script>
</div>

<h2>[레시피 검색]</h2>
<div style="width:900px; margin:0px auto; margin-bottom:5px; text-align:center;" id="divCondition">
	<input type="text" placeholder="메뉴명" id="query1"/>
	<input type="text" placeholder="재료명" id="query2"/>
	<select id="perpage">
		<option value=10 selected>10건씩 출력</option>
		<option value=15>15건씩 출력</option>
		<option value=20>20건씩 출력</option>
		<option value=25>25건씩 출력</option>
		
	</select>
</div>
<div id="tbl" style="width:800px;overflow:hidden;margin:0px auto;"></div>
<script id="temp" type="text/x-handlebars-template">	
	{{#each COOKRCP01.row}}
	<div class="box2" style="width:130px;height:130px;float:left;background:#F7F3F3;text-align:center;margin:5px;padding:10px;">
		<img src="{{ATT_FILE_NO_MAIN}}" width=80 style="cursor:pointer;" RCP_NM="{{RCP_NM}}" RCP_WAY2="{{RCP_WAY2}}" RCP_PAT2="{{RCP_PAT2}}" 
			INFO_WGT="{{INFO_WGT}}" INFO_ENG="{{INFO_ENG}}" INFO_CAR="{{INFO_CAR}}" INFO_PRO="{{INFO_PRO}}" INFO_FAT="{{INFO_FAT}}" 
			INFO_NA="{{INFO_NA}}" HASH_TAG="{{HASH_TAG}}" ATT_FILE_NO_MAIN="{{ATT_FILE_NO_MAIN}}" ATT_FILE_NO_MK="{{ATT_FILE_NO_MK}}" 
			RCP_PARTS_DTLS="{{RCP_PARTS_DTLS}}" MANUAL01="{{MANUAL01}}" MANUAL02="{{MANUAL02}}" MANUAL03="{{MANUAL03}}" MANUAL04="{{MANUAL04}}"  
			MANUAL05="{{MANUAL05}}" MANUAL06="{{MANUAL06}}" MANUAL07="{{MANUAL07}}" MANUAL08="{{MANUAL08}}" MANUAL09="{{MANUAL09}}" MANUAL10="{{MANUAL10}}" 
		/>
		<div class="RCP_NM">{{RCP_NM}}</div>
	</div>
	{{/each}}
</script>
<div style="width:700px; margin:auto; margin-top:5px;">
	<button id="btnPre">이전</button>
	<span id="pageInfo"></span>
	<button id="btnNext">다음</button>
</div>

<div id="darken-background">
	<div id="lightbox">
		<img src="http://placehold.it/150x170" width=150 id="image" style="text-align:center;"/>
		<br/>
		<div id="RCP_NM"></div>
		<div id="RCP_WAY2"></div>
		<div id="RCP_PAT2"></div>
		<div id="INFO_WGT"></div>
		<div id="HASH_TAG"></div>
		<div id="RCP_PARTS_DTLS"></div>
		<br/>
		<div><b>만드는 법</b></div>
		<div id="MANUAL01"></div>
		<div id="MANUAL02"></div>
		<div id="MANUAL03"></div>
		<div id="MANUAL04"></div>
		<div id="MANUAL05"></div>
		<div id="MANUAL06"></div>
		<div id="MANUAL07"></div>
		<div id="MANUAL08"></div>
		<div id="MANUAL09"></div>
		<div id="MANUAL10"></div>		
		<hr/>
		<button id="btnClose">닫 기</button>
	</div>
</div>
<script>
	$("#tbl").on("click",".box2 img", function(){
		$("#image").attr("src", $(this).attr("src"));
		$("#RCP_NM").html("<b>메뉴명</b> : " + $(this).attr("RCP_NM"));
		$("#RCP_WAY2").html("<b>조리방법</b> : " + $(this).attr("RCP_WAY2"));
		$("#RCP_PAT2").html("<b>요리종류</b> : " + $(this).attr("RCP_PAT2"));		
		$("#RCP_PARTS_DTLS").html("<b>재료정보</b> : " + $(this).attr("RCP_PARTS_DTLS"));
		$("#MANUAL01").html($(this).attr("MANUAL01"));
		$("#MANUAL02").html($(this).attr("MANUAL02"));
		$("#MANUAL03").html($(this).attr("MANUAL03"));
		$("#MANUAL04").html($(this).attr("MANUAL04"));
		$("#MANUAL05").html($(this).attr("MANUAL05"));
		$("#MANUAL06").html($(this).attr("MANUAL06"));
		$("#MANUAL07").html($(this).attr("MANUAL07"));
		$("#MANUAL08").html($(this).attr("MANUAL08"));
		$("#MANUAL09").html($(this).attr("MANUAL09"));
		$("#MANUAL10").html($(this).attr("MANUAL10"));		
		$("#darken-background").show();
	});
	$("#btnClose").on("click", function(){
		$("#darken-background").hide();
	});
</script>

<script>	
var page=1;
var perpage=$("#perpage").val();
getUrl(); 
getList();

//냉장고 row 클릭시
$("#tbl2").on("click",".row",function(){
	var name=$(this).find(".name").html();	
	document.getElementById("query2").value = name;	
});

//냉장고 정보 숨기기 보이기
$("#refInfo").hide();
$("#btnShow").on("click",function(){
	$("#refInfo").show();
	$("#btnShow").hide();
});
$("#btnHidden").on("click",function(){
	$("#refInfo").hide();
	$("#btnShow").show();
});

//이전 다음버튼
$("#btnNext").click(function(){
	page++;
	getList();
});
$("#btnPre").click(function(){
	page--;
	getList();
});

//perpage 변경
$("#perpage").on("change", function(){
	perpage=$("#perpage").val();
	getUrl(); 
	getList();
});

//text박스 엔터키 입력
$("#query1").keydown(function(e){
	if(e.keyCode==13) {		
		var perpage=$("#perpage").val();
		getUrl();		
		getList();
	}
});
$("#query2").keydown(function(e){
	if(e.keyCode==13) {		
		var perpage=$("#perpage").val();
		getUrl();		
		getList();
	}
});
//getUrl 함수
function getUrl(){
	var query1=$("#query1").val();
	var query2=$("#query2").val();	
	if(query1==""){
		if(query2==""){
			url="http://openapi.foodsafetykorea.go.kr/api/31d3385aabdc4da8a52e/COOKRCP01/json/" + page + "/" +perpage;				
		}else{
			url="http://openapi.foodsafetykorea.go.kr/api/31d3385aabdc4da8a52e/COOKRCP01/json/" + page + "/" + perpage + "/RCP_PARTS_DTLS=" + query2;				
		}
	}else{
		if(query2==""){
			url="http://openapi.foodsafetykorea.go.kr/api/31d3385aabdc4da8a52e/COOKRCP01/json/" + page + "/" + perpage + "/RCP_NM=" + query1;				
		}else{
			url="http://openapi.foodsafetykorea.go.kr/api/31d3385aabdc4da8a52e/COOKRCP01/json/" + page + "/" + perpage + "/RCP_NM=" + query1 +"&RCP_PARTS_DTLS=" + query2;				
		}
	}
}

//getList 함수
function getList(){	
	$.ajax({
		type:"get",
		url:url,				
		success:function(result){
			alert("성공");
			var temp=Handlebars.compile($("#temp").html());
			$("#tbl").html(temp(result));
			var lastPage=Math.ceil(result.COOKRCP01.total_count/perpage);
			$("#pageInfo").html(page + "/" + lastPage);
			if(page==1){
				$("#btnPre").attr("disabled", true);
			}else{
				$("#btnPre").attr("disabled", false);
			}
			if(page==lastPage || lastPage==0){
				$("#btnNext").attr("disabled", true);
			}else{
				$("#btnNext").attr("disabled", false);
			}
		}
	});
}

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
</script>