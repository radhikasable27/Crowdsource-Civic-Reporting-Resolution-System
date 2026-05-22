<%@ Page Title="Student Login" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Logins.aspx.cs" Inherits="Logins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Student Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .login-card {
            max-width: 450px;
            margin: 60px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            background: #fff;
        }

        .login-title {
            text-align: center;
            font-weight: 700;
            margin-bottom: 20px;
            color: #2563eb;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: #fff;
        }

        .btn-login:hover {
            opacity: 0.95;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="login-card">
        <h3 class="login-title">
            <i class="fas fa-user-graduate"></i>  Login
        </h3>

        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger fw-bold"
            Visible="false"></asp:Label>

        <!-- Username -->
        <div class="mb-3">
            <label class="form-label">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                placeholder="Enter username"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvUser" runat="server"
                ControlToValidate="txtUsername"
                ErrorMessage="Username required"
                Display="None"
                ValidationGroup="login" />
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                TextMode="Password"
                placeholder="Enter password"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvPwd" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password required"
                Display="None"
                ValidationGroup="login" />
        </div>

        <!-- One popup for all fields -->
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            ValidationGroup="login"
            ShowMessageBox="true"
            ShowSummary="false"
            HeaderText="Please fill all fields" />

        <asp:Button ID="btnlogins" runat="server"
            Text="Login"
            CssClass="btn-login"
            ValidationGroup="login"
            OnClick="btnlogins_Click" />

        <div class="text-center mt-3">
            <a href="Registration.aspx" class="text-decoration-none fw-bold">
                New user? Register here
            </a>
        </div>
    </div>

</asp:Content>
