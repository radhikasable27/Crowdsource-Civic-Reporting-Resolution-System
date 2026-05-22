<%@ Page Title="Change Admin Email" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ChnageEmail.aspx.cs" Inherits="Admin_ChnageEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

.page-card{
    max-width:600px;
    margin:auto;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
    padding:30px;
    background:white;
}

.title{
    font-weight:600;
    color:#3d5afe;
}

.btn-main{
    background:#3d5afe;
    border:none;
    padding:10px 25px;
    border-radius:8px;
}

.btn-main:hover{
    background:#2c46d3;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container mt-5">

<div class="page-card">

<h4 class="title mb-4">
<i class="fas fa-envelope me-2"></i> Change Admin Email
</h4>

<!-- Current Email -->

<div class="mb-3">
<label class="form-label">Current Email</label>
<asp:TextBox ID="txtCurrentEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
</div>

<!-- New Email -->

<div class="mb-3">
<label class="form-label">New Email</label>
<asp:TextBox ID="txtNewEmail" runat="server" CssClass="form-control" placeholder="Enter new email"></asp:TextBox>
</div>

<!-- Send OTP -->


<!-- OTP Section -->




<!-- Change Email -->

<div class="mt-4">

<asp:Button ID="btnChangeEmail" runat="server"
Text="Update Email"
CssClass="btn btn-primary"
OnClick="btnUpdateEmail_Click" />

</div>

<asp:Label ID="lblMsg" runat="server" CssClass="text-danger mt-3 d-block"></asp:Label>

</div>

</div>

</asp:Content>