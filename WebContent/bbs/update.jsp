<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>[게시글 수정]</h2>
<form name="frm" method="post" action="/bbs/update" >
	<table >
		<tr>
			<td width=100 class="title">게시글 번호</td>
			<td width=50><input type="text" name="bbs_num" value="${vo.bbs_num}" size=5 readonly></td>
			<td width=100 class="title">카테고리</td>
			<td width=100>
				<select name="bbs_type">
					<option value="레시피" <c:out value="${vo.bbs_type=='레시피'?'selected':''}"/>>레시피</option>
					<option value="정보/팁" <c:out value="${vo.bbs_type=='정보/팁'?'selected':''}"/>>정보/팁</option>
					<option value="자유" <c:out value="${vo.bbs_type=='자유'?'selected':''}"/>>자유</option>
				</select>
			</td>
			<td width=100 class="title">작성자</td>
			<td width=50><input type="text" name="writer" value="${vo.writer}" size=10 readonly></td>
		</tr>
		<tr>
 			<td class="title">제목</td>
			<td colspan=5><input type="text" name="title" size=100 value="${vo.title}"></td>
 		</tr>
 		<tr>
 			<td colspan=6><textarea cols=110 rows=20 name="content" style="padding:10px;">${vo.content}</textarea></td>
 		</tr>
 	</table>
 	<div style="width:900px; text-align:center;">
	 	<input type="submit" value="수정">
	 	<input type="reset" value="취소">
 	</div>
</form>

<script>
//게시글 수정
$(frm).on("submit", function(e){
	e.preventDefault();
	if(!confirm("수정하실래요?")) return;
	frm.submit();
});
</script>
