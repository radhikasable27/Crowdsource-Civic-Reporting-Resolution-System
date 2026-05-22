<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Forgot Password
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color:#f8f9fa; }
        .forgot-container { max-width:400px; margin:50px auto; padding:30px; background:#fff; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1); }
        .form-label { font-weight:500; }
        .btn-primary, .btn-success { width:100%; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="forgot-container">
        <h3 class="text-center mb-4">Forgot Password</h3>

        <!-- Step 0: Select Type -->
        <div class="mb-3">
            <label class="form-label">Select Type</label>
            <asp:RadioButtonList ID="rblType" runat="server">
                  <asp:ListItem Value="User" Selected="True">User</asp:ListItem>
    <asp:ListItem Value="Department">Department</asp:ListItem>
    <asp:ListItem Value="Admin">Admin</asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <!-- Step 1: Email -->
        <asp:Panel ID="pnlEmail" runat="server">
            <div class="mb-3">
                <label class="form-label">Registered Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
            </div>
            <asp:Button ID="btnSendOTP" runat="server" CssClass="btn btn-primary" Text="Send OTP" OnClick="btnSendOTP_Click" />
            <asp:Label ID="lblEmailMsg" runat="server" CssClass="text-danger mt-2 d-block"></asp:Label>
        </asp:Panel>

        <!-- Step 2: OTP -->
        <asp:Panel ID="pnlOTP" runat="server" Visible="false" class="mt-3">
            <div class="mb-3">
                <label class="form-label">Enter OTP</label>
                <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" Placeholder="Enter OTP"></asp:TextBox>
            </div>
            <asp:Button ID="btnVerifyOTP" runat="server" CssClass="btn btn-primary" Text="Verify OTP" OnClick="btnVerifyOTP_Click" />
            <asp:Label ID="lblOTPMsg" runat="server" CssClass="text-danger mt-2 d-block"></asp:Label>
        </asp:Panel>

        <!-- Step 3: Reset Password -->
        <asp:Panel ID="pnlReset" runat="server" Visible="false" class="mt-3">
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>
            </div>
            <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-success" Text="Reset Password" OnClick="btnResetPassword_Click" />
            <asp:Label ID="lblResetMsg" runat="server" CssClass="text-success mt-2 d-block"></asp:Label>
        </asp:Panel>
        <asp:Button ID="Button1" runat="server" Text="Login Now!" CssClass="btn btn-info" OnClick="Button1_Click" />
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>