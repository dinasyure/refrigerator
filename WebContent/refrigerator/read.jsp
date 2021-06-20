<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>냉장고 재료 정보</h2>
<form name="frm" method="post" action="update">
	<table>
		<tr>
			<td class="title" width=100>아이디</td>
			<td width=150>
				<input type="text" name="refrigerator_userid" value="${user.uid}" readonly/>
				<input type="hidden" name="refrigerator_num" value="${vo.refrigerator_num}" readonly/>
			</td>			
			<td class="title" width=100>재료명</td>
			<td width=150>
				<input type="hidden" name="refrigerator_ingNum" value="${vo.refrigerator_ingNum}" readonly/>
				<input type="text" name="ingredient_name" value="${vo.ingredient_name}" readonly/>
			</td>			
			<td class="title" width=100>보관장소</td>
			<td width=150>
				<select name="refrigerator_place">
					<option value="냉장" <c:out value="${vo.refrigerator_place=='냉장'?'selected':''}"/>>냉장</option>
					<option value="냉동" <c:out value="${vo.refrigerator_place=='냉동'?'selected':''}"/>>냉동</option>
					<option value="외부" <c:out value="${vo.refrigerator_place=='외부'?'selected':''}"/>>외부</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title" >등록날짜</td>
			<td colspan=2><input type="text" name="refrigerator_date" value="${vo.refrigerator_date }"/></td>
			<td class="title" >유통기한</td>
			<td colspan=2><input type="text" name="refrigerator_exDate" placeholder="yyyy-mm-dd" value="${vo.refrigerator_exDate }"/></td>			
		</tr>
		<tr>
			<td class="title" >메모</td>
			<td colspan=5><textarea name="refrigerator_memo" rows="2" cols="100" size=100>${vo.refrigerator_memo }</textarea></td>
		</tr>		
	</table>
	<div style="text-align:center;margin:10px;">
		<input type="submit" value="수정"/>
		<input type="reset" value="취소"/>
		<input type="button" value="삭제" id="btnDel"/>		
	</div>		
</form>

<script>
	//냉장고 식재료 수정
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("수정하실래요?")) return;
		frm.submit();
	});
	$("#btnDel").on("click",function(){
		if(!confirm("삭제하실래요?")) return;
		var refrigerator_num=$(frm.refrigerator_num).val();
		location.href="/refrigerator/delete?refrigerator_num=" + refrigerator_num;		
	});
	
</script>
