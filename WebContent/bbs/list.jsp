<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>[게시판 목록]</h2>
<div style="width:800px;text-align:center;" id="divCondition">
	<select id="key">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
		<option value="bbs_type">카테고리</option>			
	</select>
	<input type="text" placeholder="검색어" id="word"/>
	<select id="order">
		<option value="bbs_num">작성일순 정렬</option>
		<option value="title">제목순 정렬</option>
		<option value="writer">작성자순 정렬</option>
	</select>
	<select id="perpage">
		<option value="10">10개씩 검색</option>
		<option value="15">15개씩 검색</option>
		<option value="20">20개씩 검색</option>
	</select>
	<select id="desc">
		<option value="desc">내림차순</option>
		<option value="">오름차순</option>			
	</select>
	<button id="btnSearch">검 색</button>
	검색수:<span id="count"></span>
</div>
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
	<tr class="row" style="cursor:pointer" onClick="location.href='read?bbs_num={{bbs_num}}'">				
		<td>{{bbs_num}}</td>
		<td>{{bbs_type}}</td>
		<td>{{title}}</td>				
		<td>{{writer}}</td>
		<td>{{wdate}}</td>
	</tr>
	{{/each}}
	</script>
	<button id="btnInsert" style="margin:10px;margin-left:50px;" onClick="location.href='insert'">글쓰기</button>
<div id="pagination">	
	<button id="btnPre">이 전</button>
	<span id="pageInfo"></span>
	<button id="btnNext">다 음</button>
</div>

<script>
	var page=1;
	getList();
	
	$("#btnNext").on("click", function(){
		page++;
		getList();
	});
	$("#btnPre").on("click", function(){
		page--;
		getList();
	});
	
	$("#btnSearch").on("click", function(){
		page=1;
		getList();
		
	});
	$("#word").on("keydown", function(e){
		if(e.keyCode==13){
			page=1;
			getList();
		}		
	});
	$("#order").on("change", function(){
		page=1;
		getList();
	});
	$("#desc").on("change", function(){
		page=1;
		getList();
	});
	$("#perpage").on("change", function(){
		page=1;
		getList();
	});
	
	function getList(){
		var key=$("#key").val();
		var word=$("#word").val();
		var order=$("#order").val();
		var desc=$("#desc").val();
		var perpage=$("#perpage").val();
		$.ajax({
			type:"get",
			url:"list.json",
			dataType:"json",
			data:{"key":key, "word":word, "order":order, "desc":desc, "page":page, "perpage":perpage},
			success:function(result){
				var temp=Handlebars.compile($("#bbsTemp").html());
				$("#bbsTbl").html(temp(result));
				$("#count").html(result.count);
				
				var lastPage=Math.ceil(result.count/perpage);
				$("#pageInfo").html(page + "/" + lastPage);
				if(page==1){
					$("#btnPre").attr("disabled", true);
				}else {
					$("#btnPre").attr("disabled", false);
				}
				if(page==lastPage || lastPage==0){
					$("#btnNext").attr("disabled", true);
				}else {
					$("#btnNext").attr("disabled", false);
				}
			}
		});
	}
</script>
