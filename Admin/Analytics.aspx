<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Analytics.aspx.cs" Inherits="Admin_Analytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">

    <h4 class="mb-3">📊 Admin Analytics Dashboard</h4>

    <div class="row">

        <!-- TOTAL ISSUES -->
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

    <div class="row mt-3">

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

    </div>

    <!-- Issues Per Department -->
    <div class="card mt-4">
        <div class="card-header">
            📌 Issues by Department
        </div>
        <div class="card-body">
            <asp:GridView ID="gvDeptIssues" runat="server" 
                CssClass="table table-bordered"
                AutoGenerateColumns="true">
            </asp:GridView>
            <div class="row mt-4">

    <!-- STATUS CHART -->
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">📊 Issues by Status</div>
            <div class="card-body">
                <canvas id="statusChart"></canvas>
            </div>
        </div>
    </div>

    <!-- DEPARTMENT CHART -->
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">📈 Issues by Department</div>
            <div class="card-body">
                <canvas id="deptChart"></canvas>
            </div>
        </div>
    </div>
                <asp:HiddenField ID="hfPending" runat="server" />
<asp:HiddenField ID="hfInProgress" runat="server" />
<asp:HiddenField ID="hfCompleted" runat="server" />
<asp:HiddenField ID="hfDeptLabels" runat="server" />
<asp:HiddenField ID="hfDeptCounts" runat="server" />
</div>
        </div>
    </div>

</div>
    <script>

window.onload = function () {

    // STATUS PIE CHART
    var ctx1 = document.getElementById('statusChart').getContext('2d');

    new Chart(ctx1, {
        type: 'pie',
        data: {
            labels: ['Pending', 'In Progress', 'Completed'],
            datasets: [{
                data: [
                    <%= hfPending.Value %>,
                    <%= hfInProgress.Value %>,
                    <%= hfCompleted.Value %>
                ],
                backgroundColor: ['#ffc107', '#17a2b8', '#28a745']
            }]
        }
    });

    // DEPARTMENT BAR CHART
    var ctx2 = document.getElementById('deptChart').getContext('2d');

    new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: [<%= hfDeptLabels.Value %>],
            datasets: [{
                label: 'Total Issues',
                data: [<%= hfDeptCounts.Value %>],
                backgroundColor: '#007bff'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            }
        }
    });

};

    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

