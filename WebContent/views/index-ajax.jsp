<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
<link rel="stylesheet" type="text/css"
	href="/guestbook2/assets/css/gb.css">
<script type="text/javascript"
	src="/guestbook2/assets/js/jquery/jquery-1.9.0.js"></script>
<script>
	var pageNumber = 1;
	var fetchList = function() {
		//ajax 통신
		$
				.ajax({
					url : "/guestbook2/api/gb",
					type : "get",
					dataType : "json",
					data : "page=" + pageNumber++,
					contentType : 'application/json',
					success : function(response) {
						if (response.result == "fail") {
							console.error(response.message);
							return;
						}
						//redering
						response.data;
						var $listDiv = $("#list");
						$
								.each(
										response.data,
										function(index, data) {
											console.log(index, data);
											// template EJS
											var html = "<table><tr><td>"
													+ data.name
													+ "</td><td>"
													+ data.regDate
													+ "</td><td><a href=''>삭제</a></td></tr><tr><td colspan='3'>"
													+ data.message.replace(
															/\n/g, "<br>")
															.replace(/\r\n/g,
																	"<br>")
													+ "</td></tr></table>";
											$listDiv.append(html);
										});
					},
					error : function(jqXHR, status, e) {
						console.error(status + " : " + e);
					}
				});
	}
	$(function() {
		//다음 버튼 이벤트 매핑
		$("#btn-next").click(function() {
			fetchList();
		});
		//최초 data 가져오기
		fetchList();
	});
</script>
</head>
<body>
	<form>
		<input type="hidden" name="a" value="insert">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
				<td>비밀번호</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr>
				<td colspan=4><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan=4 align=right><input type="button" VALUE=" 확인 "></td>
			</tr>
		</table>
	</form>
	<div id="list"></div>
	<div id="buttons">
		<button id="btn-next">다음 가져오기</button>
	</div>
</body>
</html>