<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" CodeFile="Registration.aspx.cs" Inherits="Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
   /* background: 
        linear-gradient(rgba(0,0,0,0.55), rgba(0,0,0,0.55)),
        url('images/city.png');*/
    background-size: cover;
    background-position: center;
}

/* Center Wrapper */
.register-wrapper {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

/* Card */
.register-card {
    width: 100%;
    max-width: 420px;
    background: #fff;
    border-radius: 20px;
    padding: 35px 30px;
    box-shadow: 0 20px 45px rgba(0,0,0,0.25);
}

/* Title */
.register-card h3 {
    font-weight: 700;
    margin-bottom: 5px;
}

.register-card p {
    font-size: 14px;
    color: #777;
    margin-bottom: 25px;
}

/* Input Wrapper */
.input-group-custom {
    position: relative;
    margin-bottom: 18px;
}

.input-group-custom i {
    position: absolute;
    top: 12px;
    left: 12px;
    color: #999;
}

.input-group-custom .form-control {
    padding-left: 38px;
    border-radius: 12px;
    height: 45px;
}

.form-control:focus {
    border-color: #18c1d6;
    box-shadow: 0 0 5px rgba(24,193,214,0.4);
}

/* Button */
.btn-register {
    width: 100%;
    height: 45px;
    border-radius: 12px;
    border: none;
    background: #18c1d6;
    color: white;
    font-weight: 600;
    transition: 0.3s;
}

.btn-register:hover {
    background: #12a9bb;
}

.validation-error {
    font-size: 13px;
    color: red;
}
</style>


<div class="register-wrapper">
    <div class="register-card">

        <h3 class="text-center">Create Account</h3>
        <p class="text-center">Register to report civic issues</p>

        <asp:Label ID="lblmsg" runat="server" CssClass="validation-error" Visible="false"></asp:Label>

        <!-- Full Name -->
        <div class="input-group-custom">
            <i class="fas fa-user"></i>
            <asp:TextBox ID="txtname" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
        </div>

        <!-- Email -->
        <div class="input-group-custom">
            <i class="fas fa-envelope"></i>
            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email Address"></asp:TextBox>
        </div>


<!-- Email Format Validation -->
<asp:RegularExpressionValidator ID="revEmail" runat="server"
    ControlToValidate="txtemail"
    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
    ErrorMessage="Enter valid email address"
    ForeColor="Red"
    Display="Dynamic" />


        <!-- Send OTP -->
        <asp:Button ID="btnSendOTP" runat="server"
            Text="Send OTP"
            CssClass="btn-register mb-3"
            OnClick="btnSendOTP_Click" />

        <!-- OTP -->
        <div class="input-group-custom">
            <i class="fas fa-key"></i>
            <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" placeholder="Enter OTP"></asp:TextBox>
        </div>

        <!-- Verify OTP -->
        <asp:Button ID="btnVerifyOTP" runat="server"
            Text="Verify OTP"
            CssClass="btn-register mb-3"
            OnClick="btnVerifyOTP_Click" />

        <!-- Contact -->
        <div class="input-group-custom">
            <i class="fas fa-phone"></i>
            <asp:TextBox ID="txtcontact" runat="server" CssClass="form-control"
                MaxLength="10" placeholder="10-digit Mobile Number"></asp:TextBox>
        </div>

        <!-- Username -->
        <div class="input-group-custom">
            <i class="fas fa-user-circle"></i>
            <asp:TextBox ID="txtusername" runat="server" CssClass="form-control"
                placeholder="Username"></asp:TextBox>
        </div>

        <!-- Password -->
        <div class="input-group-custom">
            <i class="fas fa-lock"></i>
            <asp:TextBox ID="txtpwd" runat="server" CssClass="form-control"
                TextMode="Password" placeholder="Password"></asp:TextBox>
        </div>
  

<!-- Strong Password Validation -->
<asp:RegularExpressionValidator ID="revPassword" runat="server"
    ControlToValidate="txtpwd"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&#]).{6,}$"
    ErrorMessage="Password must be 6+ chars, include Upper, Lower & Special symbol"
    ForeColor="Red"
    Display="Dynamic" />
        <!-- Address -->
        <div class="input-group-custom">
            <i class="fas fa-map-marker-alt"></i>
            <asp:TextBox ID="txtaddress" runat="server"
                CssClass="form-control"
                TextMode="MultiLine"
                Rows="2"
                placeholder="Address"></asp:TextBox>
        </div>

<div class="mb-3">
    <asp:Label ID="lblPhoto" runat="server" Text="Upload Profile Photo" CssClass="form-label"></asp:Label>
    <asp:FileUpload ID="fuphoto" runat="server" CssClass="form-control" />
</div>        <!-- Register Button -->
        <asp:Button ID="btnSubmit"
            runat="server"
            Text="Create Account"
            CssClass="btn-register mt-2"
            OnClick="btnSubmit_Click" />

        <div class="text-center mt-3">
            <small>Already have an account?
                <a href="Default3.aspx" class="fw-bold text-decoration-none">Sign In</a>
            </small>
        </div>

    </div>
</div>

</asp:Content>