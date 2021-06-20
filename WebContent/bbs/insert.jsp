<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>[게시글 등록]</h2>
<form name="frm" method="post" action="/bbs/insert" >
	<table >
		<tr>
			<td width=100 class="title">카테고리</td>
			<td width=200>
				<select name="bbs_type">
					<option value="레시피">레시피</option>
					<option value="정보/팁">정보/팁</option>
					<option value="자유" selected>자유</option>
				</select>
			</td>
			<td width=100 class="title">작성자</td>
			<td width=300><input type="text" name="writer" value="${user.uid}" readonly></td>
		</tr>
		<tr>
 			<td class="title">제목</td>
			<td colspan=3><input type="text" name="title" size=100></td>
 		</tr>
 		<tr>
 			<td colspan=4><textarea cols=100 rows=20 name="content" style="padding:10px;"></textarea></td>
 		</tr>
 	</table>
 	<div style="width:900px; text-align:center;">
	 	<input type="submit" value="저장">
	 	<input type="reset" value="취소">
 	</div>
</form>
<script>
//게시글 등록
$(frm).on("submit", function(e){
	e.preventDefault();
	if(!confirm("등록하실래요?")) return;
	frm.submit();
});
</script>
