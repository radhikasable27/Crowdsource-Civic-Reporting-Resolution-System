<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="DepartmentNotice.aspx.cs" Inherits="Admin_DepartmentNotice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container mt-4">

<div class="card shadow p-4">

<h4 class="mb-3">Department Warning Notice</h4>

<div class="mb-3">
<label>Issue ID</label>
<asp:TextBox ID="txtIssueID" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
</div>

<div class="mb-3">
<label>Department</label>
<asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
</div>

<div class="mb-3">
<label>Notice Message</label>
<asp:TextBox 
    ID="txtMessage" 
    runat="server" 
    CssClass="form-control" 
    TextMode="MultiLine" 
    Rows="4"
    placeholder="Write warning to department for delay...">
</asp:TextBox>
</div>

<div class="mb-3">
<label>Priority</label>
<asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select">
<asp:ListItem>Normal</asp:ListItem>
<asp:ListItem>Important</asp:ListItem>
<asp:ListItem>Urgent</asp:ListItem>
</asp:DropDownList>
</div>

<asp:Button 
ID="btnSendNotice" 
runat="server" 
Text="Send Warning" 
CssClass="btn btn-danger"
OnClick="btnSendNotice_Click" />
<br />
    <asp:Button 
ID="btnback" 
runat="server" 
Text="Go Back" 
CssClass="btn btn-info"
OnClick="btnback_Click" />

</div>

</div>
</asp:Content>

