<%@page import="dao.Join1_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>



<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>JSP</title>
<%  /* 핸드폰으로 비밀번호 변경 */
String id = request.getParameter("id");





Join1_DAO dao = new Join1_DAO();



boolean flg = dao.isExist_findID(id);


if(flg){

	response.sendRedirect("sf_insert_PW_fom.jsp");/* 수정하기 창으로 가기 */

}else{
	%>
	  <script>
      alert("일치하는 아이디와 핸드폰 번호가  없습니다..");
      location.href = "safetyFind_PW.jsp";
  </script>
	<%
	}
	%>
</head>

<body>





</body>

</html>

