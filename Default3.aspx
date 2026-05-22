<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
    body {
        background: #e6e6e6;
    }
        /* Next Button */
    .btn-next {
        width: 100%;
        background: #18c1d6;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 15px;
        transition: 0.3s;
    }

    .btn-next:hover {
        background: #12a9bb;
    }
    .mobile-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 95vh;
    }

    .mobile-card {
        width: 360px;
        max-width: 95%;
        background: #ffffff;
        border-radius: 25px;
        padding: 25px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        position: relative;
    }

    .title {
        font-weight: 700;
        font-size: 22px;
        text-align: center;
    }

    .subtitle {
        font-size: 13px;
        text-align: center;
        color: #6c757d;
        margin-bottom: 20px;
    }

    .account-type {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }

    .type-btn {
        flex: 1;
        margin: 0 5px;
        border: 1px solid #dee2e6;
        border-radius: 12px;
        padding: 10px 5px;
        font-size: 12px;
        text-align: center;
        cursor: pointer;
        transition: 0.3s;
    }

    .type-btn.active {
        border: 2px solid #18c1d6;
        background: #e8f9fc;
        color: #18c1d6;
        font-weight: 600;
    }

    .form-control {
        border-radius: 12px;
        padding: 12px;
        font-size: 14px;
        margin-bottom: 15px;
    }

    .forgot {
        font-size: 12px;
        text-align: right;
        margin-top: -10px;
        margin-bottom: 15px;
    }

    .forgot a {
        color: #18c1d6;
        text-decoration: none;
    }

    .btn-login {
        width: 100%;
        background: #18c1d6;
        color: white;
        padding: 12px;
        border-radius: 12px;
        border: none;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-login:hover {
        background: #12a9bb;
    }

    .divider {
        text-align: center;
        font-size: 12px;
        color: #9ca3af;
        margin: 15px 0;
    }

    .social-btn {
        width: 100%;
        border: 1px solid #dee2e6;
        border-radius: 12px;
        padding: 10px;
        font-size: 14px;
        background: white;
        margin-bottom: 10px;
        cursor: pointer;
    }

    .create-account {
        text-align: center;
        font-size: 13px;
        margin-top: 10px;
    }

    .create-account a {
        color: #18c1d6;
        font-weight: 600;
        text-decoration: none;
    }

    .dark-toggle {
        position: absolute;
        bottom: -20px;
        right: 20px;
        width: 40px;
        height: 40px;
        background: #111827;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        cursor: pointer;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    }
</style>

<div class="mobile-wrapper">

    <div class="mobile-card">

        <div class="title">Welcome Back</div>
        <div class="subtitle">Sign in to your account or create a new one</div>

        <!-- Account Type -->
     <div class="account-type">
    <div id="citizenBtn" class="type-btn active" onclick="selectType('Citizen')">
        <i class="fas fa-user"></i><br />
        CITIZEN
    </div>
           <div id="departmentbutton" class="type-btn " onclick="selectType('Department')">
        <i class="fas fa-user"></i><br />
        Department
    </div>
    <div id="adminBtn" class="type-btn" onclick="selectType('Admin')">
        <i class="fas fa-user-shield"></i><br />
        ADMIN
    </div>
</div>

<asp:HiddenField ID="hfUserType" runat="server" Value="Citizen" />
    
        <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
        <!-- Login Button -->
  
<asp:TextBox ID="txtUsername" runat="server"
    CssClass="form-control"
    placeholder="Email or Username"></asp:TextBox>

<asp:RequiredFieldValidator ID="rfvUsername" runat="server"
    ControlToValidate="txtUsername"
    ErrorMessage="Enter Username"
    ForeColor="Red"
    Display="Dynamic" />
         <asp:Button ID="btnSendOTP" runat="server"
    Text="Send OTP"
    CssClass="btn-next"
    OnClick="btnSendOTP_Click"  CausesValidation="false"
    Style="display:none;" />
<!-- Password -->
<asp:TextBox ID="txtPassword" runat="server"
    CssClass="form-control"
    TextMode="Password"
    placeholder="Password"></asp:TextBox>

<asp:RequiredFieldValidator ID="rfvPassword" runat="server"
    ControlToValidate="txtPassword"
    ErrorMessage="Enter Password"
    ForeColor="Red"
    Display="Dynamic" />

        <!-- OTP Textbox (Hidden Initially) -->
<asp:TextBox ID="txtOTP" runat="server"
    CssClass="form-control"
    placeholder="Enter OTP"
    Style="display:none;"></asp:TextBox>

<asp:RequiredFieldValidator ID="rfvOTP" runat="server"
    ControlToValidate="txtOTP"
    ErrorMessage="Enter OTP"
    ForeColor="Red"
    Display="Dynamic"
    Enabled="false" />
<div class="forgot">
<asp:HyperLink ID="lnkForgot" 
    runat="server" 
    NavigateUrl="ForgotPassword.aspx"
    CssClass="forgot-link">
    Forgot?
</asp:HyperLink></div>

<!-- Login Button -->
<asp:Button ID="btnLogin" runat="server"
    CssClass="btn-login"
    Text="Sign In"
    OnClick="btnLogin_Click" />

        <div class="divider">Or continue with</div>

        

     <button type="button" class="social-btn" onclick="enableOTP()">
    <i class="fas fa-key"></i> Login with OTP
</button>

<div class="create-account" id="createAccountDiv">
    Don't have an account?
            <a href="Registration.aspx">Create an account</a>
        </div>

  
    </div>

</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
<script>

    function selectType(type) {

        // Remove active from all
        document.getElementById("citizenBtn").classList.remove("active");
        document.getElementById("adminBtn").classList.remove("active");
        document.getElementById("departmentbutton").classList.remove("active");

        // Add active based on selection
        if (type === "Citizen") {
            document.getElementById("citizenBtn").classList.add("active");

            // ✅ Show Create Account for Citizen
            document.getElementById("createAccountDiv").style.display = "block";
        }
        else if (type === "Department") {
            document.getElementById("departmentbutton").classList.add("active");

            // ❌ Hide Create Account
            document.getElementById("createAccountDiv").style.display = "none";
        }
        else {
            document.getElementById("adminBtn").classList.add("active");

            // ❌ Hide Create Account
            document.getElementById("createAccountDiv").style.display = "none";
        }

        // Set hidden field
        document.getElementById("<%= hfUserType.ClientID %>").value = type;

    // Reset to password mode
    document.getElementById("<%= txtUsername.ClientID %>").style.display = "block";
    document.getElementById("<%= txtPassword.ClientID %>").style.display = "block";
    document.getElementById("<%= txtOTP.ClientID %>").style.display = "none";
    document.getElementById("<%= btnSendOTP.ClientID %>").style.display = "none";

    document.getElementById("<%= btnLogin.ClientID %>").value = "Sign In";

    ValidatorEnable(document.getElementById("<%= rfvPassword.ClientID %>"), true);
    ValidatorEnable(document.getElementById("<%= rfvOTP.ClientID %>"), false);
    }
    document.addEventListener("keydown", function (e) {

        if (e.key === "Enter") {

            e.preventDefault();

            document.getElementById("<%= btnLogin.ClientID %>").click();
        }

    });
function enableOTP() {

    // Show username
    document.getElementById("<%= txtUsername.ClientID %>").style.display = "block";

    // Hide password
    document.getElementById("<%= txtPassword.ClientID %>").style.display = "none";

    // Show OTP textbox
    document.getElementById("<%= txtOTP.ClientID %>").style.display = "block";

    // Show Send OTP button
    document.getElementById("<%= btnSendOTP.ClientID %>").style.display = "block";

    // Change login button text
    document.getElementById("<%= btnLogin.ClientID %>").value = "Verify OTP";

    // Disable password validation
    ValidatorEnable(document.getElementById("<%= rfvPassword.ClientID %>"), false);

    // Enable OTP validation
    ValidatorEnable(document.getElementById("<%= rfvOTP.ClientID %>"), true);
    }

</script>

</asp:Content>

