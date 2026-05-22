<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container mt-4">

    <h3 class="mb-4 text-center">🛠 Admin Dashboard</h3>

    <div class="row text-center">
         <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h6>Total Issues</h6>
                    <h3><asp:Label ID="lblTotalIssues" runat="server" /></h3>
                </div>
            </div>
        </div>

        <!-- PENDING -->
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h6>Pending</h6>
                    <h3><asp:Label ID="lblPending" runat="server" /></h3>
                </div>
            </div>
        </div>

        <!-- IN PROGRESS -->
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h6>In Progress</h6>
                    <h3><asp:Label ID="lblInProgress" runat="server" /></h3>
                </div>
            </div>
        </div>

        <!-- COMPLETED -->
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h6>Completed</h6>
                    <h3><asp:Label ID="lblCompleted" runat="server" /></h3>
                </div>
            </div>
        </div>

    </div>
      <!-- USERS -->
        <div class="col-md-4 mb-3">
            <div class="card bg-dark text-white">
                <div class="card-body">
                    <h6>Total Users</h6>
                    <h3><asp:Label ID="lblUsers" runat="server" /></h3>
                </div>
            </div>
        </div>

        <!-- DEPARTMENTS -->
        <div class="col-md-4 mb-3">
            <div class="card bg-secondary text-white">
                <div class="card-body">
                    <h6>Total Departments</h6>
                    <h3><asp:Label ID="lblDepartments" runat="server" /></h3>
                </div>
            </div>
        </div>

        <!-- AVG RATING -->
        <div class="col-md-4 mb-3">
            <div class="card bg-danger text-white">
                <div class="card-body">
                    <h6>Average Rating</h6>
                    <h3><asp:Label ID="lblAvgRating" runat="server" /></h3>
                </div>
            </div>
        </div>
      <asp:HiddenField ID="hfPending" runat="server" />
<asp:HiddenField ID="hfInProgress" runat="server" />
<asp:HiddenField ID="hfCompleted" runat="server" />
<asp:HiddenField ID="hfDeptLabels" runat="server" />
<asp:HiddenField ID="hfDeptCounts" runat="server" />
</div>

        <!-- Manage Users -->
    <%--    <div class="col-md-3 mb-4">
            <a href="ManageUsers.aspx" style="text-decoration:none;">
                <div class="card dashboard-card">
                    <img src="../Images/users.png" class="card-img-top p-3" height="120" />
                    <div class="card-body">
                        <h5 class="card-title">Manage Users</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- Manage Departments -->
        <div class="col-md-3 mb-4">
            <a href="ManageDepartment.aspx" style="text-decoration:none;">
                <div class="card dashboard-card">
                    <img src="../Images/department.png" class="card-img-top p-3" height="120" />
                    <div class="card-body">
                        <h5 class="card-title">Departments</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- View Issues -->
        <div class="col-md-3 mb-4">
            <a href="ViewIssues.aspx" style="text-decoration:none;">
                <div class="card dashboard-card">
                    <img src="../Images/issues.png" class="card-img-top p-3" height="120" />
                    <div class="card-body">
                        <h5 class="card-title">View Issues</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- Analytics -->
        <div class="col-md-3 mb-4">
            <a href="Analytics.aspx" style="text-decoration:none;">
                <div class="card dashboard-card">
                    <img src="../Images/analytics.png" class="card-img-top p-3" height="120" />
                    <div class="card-body">
                        <h5 class="card-title">Analytics</h5>
                    </div>
                </div>
            </a>
        </div>--%>

   

<style>
.dashboard-card {
    border-radius: 15px;
    transition: 0.3s;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

.dashboard-card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}
</style>

</asp:Content>
