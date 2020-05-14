# SAFTY_SignUp_Focus ![logo](https://user-images.githubusercontent.com/62732915/81911271-0c63e700-9608-11ea-8243-ab5725af4fe2.png)

### 저는 로그인 파트를 맡았습니다. 로그인 파트 위주로 설명하겠습니다 

## 설치 방법
* SAFTY홈페이지의 로그인쪽을 위한 DB 부분입니다. 개인,기업,단체로 나눠서 세개의 DB를 만들었습니다.

  * 개인[ORDINARY_PEOPLE]
  ```C
  CREATE TABLE ORDINARY_PEOPLE(
  OP_ID VARCHAR2(50),
  OP_NAME VARCHAR(30) NOT NULL,
  OP_PW VARCHAR2(25) NOT NULL,
  OP_BDATE VARCHAR2(6) NOT NULL,
  OP_EMAIL VARCHAR2(25) NOT NULL,
  OP_ADDR VARCHAR2(200) NOT NULL,
  OP_PCODE INT NOT NULL,
  OP_GENDER NUMBER NOT NULL,
  OP_PHONE INT NOT NULL,
  OP_DATE DATE,
  PRIMARY KEY(OP_ID));
  ```


  * 기업 [ORGANIZATION]
  ```C 
  CREATE TABLE ORGANIZATION(
  OR_LINUMBER VARCHAR2(50) NOT NULL,
  OR_MAN VARCHAR2(50) NOT NULL,
  OR_NAME VARCHAR(30) NOT NULL,
  OR_ID VARCHAR2(50)NOT NULL,
  OR_PW VARCHAR2(25) NOT NULL,
  OR_PHONE INT NOT NULL,
  OR_ADDR VARCHAR2(200) NOT NULL,
  OR_PCODE INT NOT NULL,
  OR_EMAIL VARCHAR2(25) NOT NULL,
  OR_DATE DATE,
  PRIMARY KEY(OR_LINUMBER));
  ```
  * 단체 [CORPORATION]
  ```C   
  CREATE TABLE CORPORATION(
  CR_NUMBER VARCHAR2(50) NOT NULL,
  CR_NAME VARCHAR(30) NOT NULL,
  CR_ID VARCHAR2(50)NOT NULL,
  CR_PW VARCHAR2(25) NOT NULL,
  CR_PHONE INT NOT NULL,
  CR_ADDR VARCHAR2(200) NOT NULL,
  CR_PCODE INT NOT NULL,
  CR_MAN VARCHAR2(50) NOT NULL,
  CR_EMAIL VARCHAR2(25) NOT NULL,
  CR_DATE DATE,
  PRIMARY KEY(CR_NUMBER));
  ```
  ## 사용방법
  
  MainPage쪽 package의 **main.jsp** 를 구동하면 정상 작동이 됩니다.
  

  ## 코드설명
  
  * 아이디 중복 체크
      
    ```c
    <%
    String userid = request.getParameter("id");
    int rst = 0;
    Join1_DAO dao = new Join1_DAO();
    rst = dao.joinCheck(userid);
    %>
    <%
    if(rst == 1){
    %>

    <img src="../image/yes.png" alt="" class="img1"/>
    <!-- 아이디가 이미 존재할때 이미지 -->
    <%}else{ %>

    <img src="../image/no.png" alt="" class="img1"/>
    <!-- 아이디가 존재하지 않을 때 이미지 -->
    <%} %>
    ```
    DAO에 joinCheck메소드 를 불러와서 
    스크립틀릿으로 아이디 중복체크를 하였습니다.
    
   * 이메일인증
  
    ```c 
    <%
      request.setCharacterEncoding("UTF-8");

      String email = request.getParameter("email");

      String key = new MailSend().mailSend(email);		//받은 인증키

      out.println(key);


    %>
    ```
    project패키지의 MailSend.java와 MailAuth.java를 통해서
    메일을 보냈습니다.
    
    **MailAuth.java** 에 
    ```c
        public MailAuth() {
        String mail_id = "본인 지메일 아이디";
        String mail_pw = "본인 지메일 비번";
    ```
    에 빈칸을 채워줘야 정상적으로 메일이 갑니다.
    
  * 회원가입시 유효성 체크
      
    ```c
    <script type="text/javascript">
	  $(function() {

		$("#alert-success").hide();
		$("#alert-danger").hide();

		$('.email3').change(function() {
			$(".email3 option:selected").each(function() {

				console.log($(this).val());

				if ($(this).val() == '1') { //직접입력한 경우
					$(".emailBox2").val('');
					$(".emailBox2").attr("disabled", false);
				} else {
					$(".emailBox2").val($(this).text());
					$(".emailBox2").attr("disabled", true);

				}

			});

		  });//이메일값 넣기

		  $("input").keyup(function() {
			var pwd1 = $("#password1").val(); //pwd1의 값
			var pwd2 = $("#password2").val(); //pwd1의 값

			if (pwd1 != "" || pwd2 != "") {
				if (pwd1 == pwd2) {
					$("#alert-success").show();
					$("#alert-danger").hide();
					$("#submit").removeAttr("disabled");
				} else {
					$("#alert-success").hide();
					$("#alert-danger").show();
					$("#submit").attr("disabled", "disabled");
				}
			  }

		  });

		  $('#userId').keyup(
				function() {

					// console.log(this.value);
					for (var i = 0; i < this.value.length; i++) {

						var ch = this.value.charAt(i);
						//console.log(ch)

						if (!(ch >= '0' && ch <= '9')
								&& !(ch >= 'a' && ch <= 'z')
								&& !(ch >= 'A' && ch <= 'Z')) {

							//console.log("영어 대소문자, 숫자만")

							$('#idCheck').text("영어 대소문자와 숫자만 입력 가능합니          다.")
							break;
						} else {
							$('#idCheck').text("")

						}
						//if end
					}//for end
				});//아이디 유효성 end
	      });

	    //아이디 유효성 검사

	    function confirmId() {

		  if (id = "") {
			alert("ID를 입력하세요");
			return;
		  }

		  url = ("idCheck1.jsp?id=" +             document.getElementById("userId").value);
		open(
				url,
				"confirm",
				"toolbar = no, location = no, status = np, menubar = no, width = 550, height=300, left=700, top=250, menubar =no, overflow-x:hidden,overflow-y:hidden ");
	}

	//이메일 인증번호 받기
	function emailCheck() {
		/* console.log("ok") */;

		if (email = "") {
			alert("email 입력하세요");
			return;
		}

		url = ("mailsend.jsp?mail=" + document.getElementById("email1").value
				+ "@" + document.getElementById("email_select").value);
		open(
				url,
				"confirm",
				"toolbar = no, location = no, status = np, menubar = no, width = 550, height=650, left=700, top=250, menubar =no, overflow-x:hidden,overflow-y:hidden ");
	}

	//빈칸 유효성 검사
	function check() {
		if ($.trim($("#userId").val()) == "") {
			alert("아이디를 입력하세요 ");
			$("#userId").val("").focus();
			return false;
		}
		if ($.trim($("#password1").val()) == "") {
			alert("비밀번호를 입력하세요 ");
			$("#password1").val("").focus();
			return false;
		}
		if ($.trim($("#password2").val()) == "") {
			alert("비밀번호를 체크하세요 ");
			$("#password2").val("").focus();
			return false;
		}
		if ($.trim($("#realName").val()) == "") {
			alert("이름을 입력하세요 ");
			$("#realName").val("").focus();
			return false;
		}
		if ($('input:radio[name=radios]').is(':checked') == false) {
			alert("성별을 선택하세요 ");
			$("#radio1").val("").focus();
			return false;
		}
		if ($.trim($("#birth").val()) == "") {
			alert("생년월일을 입력해주세요 ");
			$("#birth").val("").focus();
			return false;
		}
	
		if ($.trim($(".hpBox").val()) == "") {
			alert("핸드폰 번호를 입력하세요 ");
			$(".hpBox").val("").focus();
			return false;
		}
		if ($.trim($("#sample4_detailAddress").val()) == "") {
			alert("주소를 입력하세요 ");
			$("#sample4_detailAddress").val("").focus();
			return false;
		}

    ```
    빈칸유효성체크, 숫자/영문 체크 등
    회원가입시 체크해야할 부분들을 ajax와 jquery로 체크했습니다.
    
   * 회원가입
  
    ```c 
      <%
      request.setCharacterEncoding("UTF-8"); //사용자한테 받은 것
      String userID = null;
      String userName = request.getParameter("name");
      String userPassword = null;
      String userBirth = request.getParameter("birth1");
      String userEmail = null;
      String userAddr = null;
      int userPcode = Integer.parseInt(request.getParameter("pcode"));
      int userGender = Integer.parseInt(request.getParameter("radios"));
      int userHp = 0;

      if (request.getParameter("userId") != null) {
        userID = request.getParameter("userId");
      }
      if (request.getParameter("password1") != null) {
        userPassword = request.getParameter("password1");
      }
      if (request.getParameter("email1") != null && request.getParameter("email_select") != null) {
        userEmail = request.getParameter("email1") + "@" + request.getParameter("email_select");
      }
      if (request.getParameter("hp1") != null && request.getParameter("hp2") != null
          && request.getParameter("hp3") != null) {
        userHp = Integer.parseInt(
            request.getParameter("hp1") + request.getParameter("hp2") + request.getParameter("hp3"));
      }
      if (request.getParameter("addr1") != null) {
        userAddr = request.getParameter("addr1") + request.getParameter("addr2") + request.getParameter("addr3")
            + request.getParameter("addr4");
      }

      if (userID == null || userName == null || userPassword == null || userBirth == null || userEmail == null || userAddr == null || userPcode == 0 || userGender == 0 || userHp == 0 ) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert ('입력이 안된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
      }

      Join1_DAO dao = new Join1_DAO();
      Join1_VO vo = new Join1_VO( userID, userName,  userPassword,  userBirth,  userEmail, userAddr, userPcode, userGender,
          userHp);

      dao.addData(vo);

      request.setCharacterEncoding("UTF-8");
      request.getSession().setAttribute("userName", userName);
      response.sendRedirect("join4.jsp");

    %>
   
   ```
    
    각 개인,단체,기업의 형태에 맞게 **join1Ok.jsp** , **join2Ok.jsp** , **join3Ok.jsp** 에서
    
    ```C
        <%
      request.setCharacterEncoding("UTF-8"); //사용자한테 받은 것
      String userID = null;
      String userName = request.getParameter("name");
      String userPassword = null;
      String userBirth = request.getParameter("birth1");
      String userEmail = null;
      String userAddr = null;
      int userPcode = Integer.parseInt(request.getParameter("pcode"));
      int userGender = Integer.parseInt(request.getParameter("radios"));
      int userHp = 0;

      if (request.getParameter("userId") != null) {
        userID = request.getParameter("userId");
      }
      if (request.getParameter("password1") != null) {
        userPassword = request.getParameter("password1");
      }
      if (request.getParameter("email1") != null && request.getParameter("email_select") != null) {
        userEmail = request.getParameter("email1") + "@" + request.getParameter("email_select");
      }
      if (request.getParameter("hp1") != null && request.getParameter("hp2") != null
          && request.getParameter("hp3") != null) {
        userHp = Integer.parseInt(
            request.getParameter("hp1") + request.getParameter("hp2") + request.getParameter("hp3"));
      }
      if (request.getParameter("addr1") != null) {
        userAddr = request.getParameter("addr1") + request.getParameter("addr2") + request.getParameter("addr3")
            + request.getParameter("addr4");
      }

      if (userID == null || userName == null || userPassword == null || userBirth == null || userEmail == null || userAddr == null || userPcode == 0 || userGender == 0 || userHp == 0 ) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert ('입력이 안된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
      }

      Join1_DAO dao = new Join1_DAO();
      Join1_VO vo = new Join1_VO( userID, userName,  userPassword,  userBirth,  userEmail, userAddr, userPcode, userGender,
          userHp);

      dao.addData(vo);




      request.setCharacterEncoding("UTF-8");
      request.getSession().setAttribute("userName", userName);
      response.sendRedirect("join4.jsp");


    %>
    ```
    
    스크립틀릿을 사용해서 DAO를 통해 DB에 정보들을 넣어줬습니다.
    
    ## 버그들
    
    게시판을 사용할려면 별도의 DB가 필요합니다.
    
