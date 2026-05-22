<%@ Page Title="Home - College Complaints Box" Language="C#" MasterPageFile="~/User/UserMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="User_Default"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
/* Profile Section */
/* ===== PROFILE SECTION ===== */
.profile-section {
    text-align: center;
    padding: 30px 15px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 20px;
    color: white;
    margin-bottom: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

.profile-img {
    width: 110px;
    height: 110px;
    border-radius: 50%;
    border: 4px solid white;
    object-fit: cover;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.profile-name {
    font-size: 22px;
    font-weight: 700;
    margin-top: 12px;
}

.profile-role {
    font-size: 14px;
    opacity: 0.9;
}

/* ===== STATS CARDS ===== */
.stats-card {
    border-radius: 18px;
    padding: 18px;
    text-align: center;
    color: white;
    transition: 0.3s;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

/* COLORS */
.stats-card.total { background: linear-gradient(135deg, #36d1dc, #5b86e5); }
.stats-card.resolved { background: linear-gradient(135deg, #11998e, #38ef7d); }
.stats-card.pending { background: linear-gradient(135deg, #f7971e, #ffd200); }
.stats-card.progress { background: linear-gradient(135deg, #667eea, #764ba2); }

.stats-card h4 {
    font-size: 26px;
    font-weight: bold;
}

.stats-card span {
    font-size: 13px;
}

/* HOVER EFFECT */
.stats-card:hover {
    transform: translateY(-5px) scale(1.05);
}

/* ===== BADGES ===== */
.badge-card {
    background: white;
    border-radius: 18px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    transition: 0.3s;
}

.badge-card:hover {
    transform: translateY(-6px);
}

.badge-icon {
    font-size: 32px;
    margin-bottom: 10px;
    background: linear-gradient(135deg, #00c6ff, #0072ff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ===== REPORT ITEMS ===== */
.report-item {
    background: white;
    border-radius: 15px;
    padding: 12px;
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.report-item:hover {
    transform: translateX(5px);
}

.report-item img {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    object-fit: cover;
    margin-right: 12px;
}

.report-title {
    font-weight: 600;
    font-size: 15px;
}

/* STATUS BADGES */
.report-status {
    font-size: 12px;
    padding: 4px 10px;
    border-radius: 20px;
    color: white;
}

.status-resolved {
    background: linear-gradient(135deg, #28a745, #5dd39e);
}

.status-progress {
    background: linear-gradient(135deg, #ffc107, #ff9800);
    color: black;
}

.status-pending {
    background: linear-gradient(135deg, #ff416c, #ff4b2b);
}
/* Dashboard Stats Card */
.stats-card {
    min-height: 100px; /* ensures all cards have the same height */
    display: flex;
    flex-direction: column;
    justify-content: center; /* vertically centers content */
    align-items: center;     /* horizontally centers content */
    border-radius: 18px;
    padding: 18px;
    text-align: center;
    color: white;
    transition: 0.3s;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.stats-card h4 {
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 5px;
}

.stats-card span {
    font-size: 14px;
    font-weight: 500;
}

/* Color Variants */
.stats-card.total { background: linear-gradient(135deg, #36d1dc, #5b86e5); }
.stats-card.resolved { background: linear-gradient(135deg, #11998e, #38ef7d); }
.stats-card.pending { background: linear-gradient(135deg, #f7971e, #ffd200); }
.stats-card.progress { background: linear-gradient(135deg, #667eea, #764ba2); }

/* Hover Effect */
.stats-card:hover {
    transform: translateY(-5px) scale(1.05);
    box-shadow: 0 15px 30px rgba(0,0,0,0.25);
}

    </style>
<!-- Profile Section -->
<div class="profile-section">
    
    <asp:Image ID="imgProfile" runat="server" 
        CssClass="profile-img" 
        ImageUrl="~/images/user.jpg" />

    <div class="profile-name">
        <asp:Label ID="lblUsername" runat="server"></asp:Label>
    </div>

    <div class="profile-role">
      Memeber Since  <asp:Label ForeColor="YellowGreen" ID="lblMemberSince" runat="server"></asp:Label>
    </div>

</div>

<!-- Stats Row -->
<div class="row text-center mb-4 g-3">

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stats-card total">
            <h4><asp:Label ID="lblTotalIssues" runat="server" Text="0"></asp:Label></h4>
            <span>Total Issues</span>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stats-card resolved">
            <h4><asp:Label ID="lblResolved" runat="server" Text="0"></asp:Label></h4>
            <span>Resolved</span>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stats-card pending">
            <h4><asp:Label ID="lblPending" runat="server" Text="0"></asp:Label></h4>
            <span>Pending</span>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stats-card progress">
            <h4><asp:Label ID="lblInProgress" runat="server" Text="0"></asp:Label></h4>
            <span>In Progress</span>
        </div>
    </div>

</div>

    
<!-- My Past Reports -->
<h6 class="mb-3">My Past Reports</h6>

<asp:Repeater ID="rptReports" runat="server">
    <ItemTemplate>
        <div class="report-item">
            <img src='<%# Eval("Photo", "../IssuePhotos/{0}") %>' />

            <div>
                <div class="report-title">
                    <%# Eval("IssueType") %>
                </div>

                <span class='report-status <%# GetStatusClass(Eval("Status").ToString()) %>'>
                    <%# Eval("Status") %>
                </span>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater></asp:Content>