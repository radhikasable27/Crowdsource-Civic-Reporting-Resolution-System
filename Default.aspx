<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
    body {
        background: #e5e5e5;
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
        min-height: 90vh;
    }

    .mobile-card {
        width: 360px;
        max-width: 95%;
        background: #ffffff;
        border-radius: 25px;
        padding: 30px 20px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        text-align: center;
    }

    .top-gradient-box {
        background: linear-gradient(180deg,#d9f3f8,#eef9fb);
        border-radius: 20px;
        padding: 40px 20px;
        margin-bottom: 25px;
    }

    .logo-circle {
        width: 90px;
        height: 90px;
        background: #18c1d6;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }

    .logo-circle i {
        font-size: 35px;
        color: white;
    }

    .app-title {
        font-weight: 700;
        font-size: 22px;
        margin-top: 10px;
    }

    .app-tagline {
        color: #18c1d6;
        font-weight: 600;
        font-size: 14px;
        margin-bottom: 10px;
    }

    .app-desc {
        font-size: 13px;
        color: #6c757d;
        margin-bottom: 25px;
    }

    .progress {
        height: 8px;
        border-radius: 10px;
        background: #e9ecef;
    }

    .progress-bar {
        background: #18c1d6;
        border-radius: 10px;
    }
     .onboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        font-weight: 600;
    }
      .skip-btn {
        color: #18c1d6;
        font-size: 14px;
        cursor: pointer;
        text-decoration: none;
    }
    .footer-icons {
        margin-top: 25px;
        font-size: 18px;
        color: #c0c0c0;
    }

    .footer-icons i {
        margin: 0 12px;
    }
</style>

<div class="mobile-wrapper">
    
    <div class="mobile-card">
           
         <div class="onboard-header">
             <div>CivicConnect</div>
            <a href="Default3.aspx" class="skip-btn">Skip</a>
        </div>
        <!-- TOP ICON AREA -->
        <div class="top-gradient-box">
            <div class="logo-circle">
                <i class="fas fa-project-diagram"></i>
            </div>
        </div>

        <!-- TITLE -->
        <div class="app-title">
            CivicConnect
        </div>

        <div class="app-tagline">
            Report. Resolve. Improve.
        </div>

        <div class="app-desc">
            Empowering citizens to build better communities
            through real-time collaboration.
        </div>

        <!-- LOADING TEXT -->
        <div class="d-flex justify-content-between mb-1" style="font-size:12px;">
            <span>Connecting to local server...</span>
            <span style="color:#18c1d6;font-weight:600;">30%</span>
        </div>
      
        <!-- PROGRESS BAR -->
        <div class="progress">
            <div class="progress-bar" role="progressbar" style="width:30%"></div>
        </div>
        <br />
         <a href="Default2.aspx" class="btn-next">
    Next <i class="fas fa-arrow-right ms-2"></i>
</a>
        <!-- FOOTER ICONS -->
        <div class="footer-icons">
            <i class="fas fa-mobile-alt"></i>
            <i class="fas fa-map-marker-alt"></i>
            <i class="fas fa-users"></i>
        </div>

    </div>

</div>

</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
</asp:Content>

