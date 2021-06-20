<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	.box{background:#D3E1E6; padding:10px; color:black; border-radius:5px;}
	#replyPage{border-bottom:2px solid black; width:900px;padding:10px;}
	.replyTitle{background:#E8E1D5; padding:5px; margin:5px;}
	#count{margin:10px;}
	.btnDelete{cursor:pointer;}		
</style>


<h2>[게시글 읽기]</h2>
<div id="replyPage">
	<div class="replyTitle">제목 : <b>${vo.title}</b><br/>작성자 : ${vo.writer}&nbsp;&nbsp;&nbsp;&nbsp;작성일 : ${vo.wdate}</div>			
	<hr/>
	<div id="replyContent"><br/>${vo.content}</div><br/>
	<hr/>
	<div>
		<c:if test="${user.uid==vo.writer}">
			<button onClick="location.href='update?bbs_num=${vo.bbs_num}'">글 수정</button>
			<button id="btnDelete">글 삭제</button>
		</c:if>
		<button onClick="location.href='list'">목록</button>
	</div>
	<br/>
<form name="frm" method="post" action="/reply/insert">
	아이디 : <input type="hidden" name="bbs_id" value="${vo.bbs_num}" readonly>
		  <input type="text" name="reply_writer" value="${user.uid}" readonly><br>
	<textarea cols=120 rows=3 name="reply_content"></textarea><br>
	<input type="submit" value="저장">
</form>
	<div id="count"></div>
	<div id="replyList"></div>
	<script id="replyTemp" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box">
		<span><b>{{rdate}} [{{reply_writer}}]</b></span>
		<span class="btnDelete" style="{{printDel reply_writer}}" reply_num={{reply_num}}>❌</span><br/>			
		<div>{{reply_content}}</div>			
	</div>
	<br>
	{{/each}}
	</script>
	<button id="btnNext">더보기</button>
</div>

<script>
	var page=1;
	var perpage=5;
	var bbs_id="${vo.bbs_num}";
	getList();
	//게시글 삭제
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		location.href="/bbs/delete?bbs_num=" + bbs_id;
		alert("삭제되었습니다");
	});
	//댓글 삭제
	$("#replyList").on("click",".box .btnDelete", function(){
		var reply_num=$(this).attr("reply_num");
		if(!confirm("삭제하실래요?")) return;		
		location.href="/reply/delete?reply_num=" + reply_num;
		alert("삭제되었습니다");
		location.reload();		
	});
	//로그인한 아이디만 댓글삭제버튼노출 
	Handlebars.registerHelper("printDel", function(reply_writer){
		var uid="${user.uid}";
		if(uid!=reply_writer){
			return "display:none;";
		}
	});
	
	$("#btnNext").on("click", function(){
		perpage+=5;
		getList();
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/reply/list.json",
			dataType:"json",
			data:{"bbs_id":bbs_id, "page":page, "perpage": perpage},
			success:function(result){
				var temp=Handlebars.compile($("#replyTemp").html());
				$("#replyList").html(temp(result));
				$("#count").html("댓글수 : " + result.count);
				if(perpage>=result.count){					
					$("#btnNext").hide();
				}else {					
					$("#btnNext").show();
				}
			}
		});		
	}
</script>
