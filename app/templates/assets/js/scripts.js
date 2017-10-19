    function login_check() {
        if (document.loginfrm.userid.value == "") {
            alert("아이디를 입력하여 주시기 바랍니다.");
            document.loginfrm1.userid.focus();
            return false;
        }

        if (document.loginfrm.passwd.value == "") {
            alert("비밀번호를 입력하여 주시기 바랍니다.");
            document.loginfrm1.passwd.focus();
            return false;
        }
        document.loginfrm.submit();
    }