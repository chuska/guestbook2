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
<link rel="stylesheet" type="text/css"
	href="/guestbook2/assets/css/jBox.css">
<script type="text/javascript"
	src="/guestbook2/assets/js/jquery/jquery-1.9.0.js"></script>
<script type="text/javascript" src="/guestbook2/assets/js/jBox.js"></script>
<script>
	var jbox;
	var pageNumber = 1;
	var fetchList = function() {
		//ajax 통신
		$.ajax({
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
				$.each(response.data, function(index, data) {
					insertGuestbook(data);
				});
			},
			error : function(jqXHR, status, e) {
				console.error(status + " : " + e);
			}
		});
	}
	var insertGuestbook = function(data) {
		var $listDiv = $("#list");
		// template EJS
		var html = "<table id='table-"+data.no+"'><tr><td>"
				+ data.name
				+ "</td><td>"
				+ data.regDate
				+ "</td><td><a href='' class='delete-guestbook' data-no='"+data.no+"'>삭제</a></td></tr><tr><td colspan='3'>"
				+ data.message.replace(/\n/g, '<br>').replace(/\r\n/g, '<br>')
				+ "</td></tr></table>";
		$listDiv.append(html);
	}
	var insertHeadGuestbook = function(data) {
		var $listDiv = $("#list");
		// template EJS
		var html = "<table id='table-"+data.no+"'><tr><td>"
				+ data.name
				+ "</td><td>"
				+ data.regDate
				+ "</td><td><a href='' class='delete-guestbook' data-no='"+data.no+"'>삭제</a></td></tr><tr><td colspan='3'>"
				+ data.message.replace(/\n/g, '<br>').replace(/\r\n/g, '<br>')
				+ "</td></tr></table>";
		$listDiv.prepend(html);
	}
	$(function() {
		//다음 버튼 이벤트 매핑
		$("#btn-next").click(function() {
			fetchList();
		});
		//삭제 버튼 이벤트 매핑(Live 이벤트)
		$(document).on("click", ".delete-guestbook", function() {
			event.preventDefault();
			var $a = $(this);
			var no = $a.attr("data-no");
			jbox = new jBox('Modal', {
				attach : $('#myModal'),
				title : '비밀번호 입력',
				content : $('#form-password')
			});
			jbox.open();
			//폼 리셋
			$("#delete-no").val(no);
			$("#delete-password").val("");
		});
		//팝업폼의 삭제 버튼 이벤트 매핑
		$("#form-password input[type='button']").click(function() {
			//팝업박스 닫기
			jbox.close();
			// no, password값을 받아온다
			var no = $("#delete-no").val();
			var password = $("#delete-password").val();
			// ajax 통신
			$.ajax({
				url : "/guestbook2/api/gb",
				type : "get",
				dataType : "json",
				data : "a=delete&no=" + no + "&password=" + password,
				contentType : 'application/json',
				success : function(response) {
					if (response.result == "fail") {
						console.error(response.message);
						return;
					}
					if (response.data == true) {
						$("#table-" + no).remove();
					} else {
						alert("비밀번호가 틀립니다.");
					}
				},
				error : function(jqXHR, status, e) {
					console.error(status + " : " + e);
				}
			});
		});
		//게시물 추가 확인 버튼 이벤트 매핑
		$("#btn-add")
				.click(
						function() {
							//이름, 비밀번호, content 가져오기
							var name = $("#insert-name").val();
							var password = $("#insert-password").val();
							var message = encodeURIComponent($(
									"#insert-message").val());
							//ajax
							$.ajax({
								url : "/guestbook2/api/gb",
								type : "get",
								dataType : "json",
								data : "a=insert&name=" + name + "&password="
										+ password + "&message=" + message,
								contentType : 'application/json',
								success : function(response) {
									if (response.result == "fail") {
										console.error(response.message);
										return;
									}
									var data = response.data;
									insertHeadGuestbook(data);
								},
								error : function(jqXHR, status, e) {
									console.error(status + " : " + e);
								}
							});
							$("#insert-name").val("");
							$("#insert-password").val("");
							$("#insert-message").val("");
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
				<td><input type="text" name="name" id="insert-name"></td>
				<td>비밀번호</td>
				<td><input type="password" name="pass" id="insert-password"></td>
			</tr>
			<tr>
				<td colspan=4><textarea name="content" id="insert-message"></textarea></td>
			</tr>
			<tr>
				<td colspan=4 align=right><input type="button" id="btn-add"
					VALUE=" 확인 "></td>
			</tr>
		</table>
	</form>
	<div id="list"></div>
	<div id="buttons">
		<button id="btn-next">다음 가져오기</button>
	</div>
	<div id="form-password" style="display: none">
		<p>작성시 비밀번호를 입력해 주세요.</p>
		<form>
			<input type="hidden" name="no" id="delete-no"> <input
				type="password" name="password" id="delete-password"> <input
				type="button" value="삭제">
		</form>
	</div>

</body>
</html>