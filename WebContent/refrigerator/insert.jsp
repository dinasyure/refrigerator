<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>냉장고 재료 등록</h2>
<form name="frm" method="post" action="/refrigerator/insert">
	<table>
		<tr>
			<td class="title" width=100>아이디</td>
			<td width=150><input type="text" name="refrigerator_userid" value="${user.uid}"/></td>			
			<td class="title" width=100>재료명</td>
			<td width=150>
				<input type="hidden" name="refrigerator_ingNum" value="${vo.ingredient_num}"/>
				<input type="text" name="ingredient_name" value="${vo.ingredient_name}"/>
			</td>			
			<td class="title" width=100>보관장소</td>
			<td width=150>
				<select name="refrigerator_place">
					<option value="냉장">냉장</option>
					<option value="냉동">냉동</option>
					<option value="외부">외부</option>
					<option value="김치냉장고">김치냉장고</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title" >유통기한</td>
			<td><input type="text" name="refrigerator_exDate" placeholder="yyyy-mm-dd"/></td>
			<td class="title" >메모</td>
			<td colspan=3><input type="text" name="refrigerator_memo" size=70/></td>
		</tr>		
	</table>
	<div style="text-align:center;margin:10px;">
		<input type="submit" value="등록"/>
		<input type="reset" value="취소"/>		
	</div>		
</form>

<script>
//냉장고에 식재료 등록
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("등록하실래요?")) return;
		frm.submit();
	});
</script>
