<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
    body {
        background: #e6e6e6;
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
        padding: 20px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        position: relative;
    }

    /* Top Header */
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

    /* Illustration Box */
    .illustration-box {
        background: linear-gradient(180deg,#c8eef4,#eaf8fb);
        border-radius: 20px;
        padding: 40px 20px;
        text-align: center;
        margin-bottom: 25px;
    }

    .illustration-circle {
        width: 80px;
        height: 80px;
        background: #18c1d6;
        border-radius: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
    }

    .illustration-circle i {
        color: white;
        font-size: 35px;
    }

    .title {
        font-weight: 700;
        font-size: 20px;
        margin-bottom: 10px;
    }

    .description {
        font-size: 14px;
        color: #6c757d;
        margin-bottom: 20px;
    }

    /* Dots */
    .dots {
        text-align: center;
        margin-bottom: 20px;
    }

    .dot {
        height: 8px;
        width: 8px;
        margin: 0 4px;
        background-color: #d1d5db;
        border-radius: 50%;
        display: inline-block;
    }

    .dot.active {
        background-color: #18c1d6;
        width: 20px;
        border-radius: 10px;
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

    .step-text {
        text-align: center;
        margin-top: 12px;
        font-size: 12px;
        color: #9ca3af;
    }
</style>

<div class="mobile-wrapper">

    <div class="mobile-card">

        <!-- Header -->
        <div class="onboard-header">
            <div>CivicConnect</div>
            <a href="Default3.aspx" class="skip-btn">Skip</a>
        </div>

        <!-- Illustration -->
        <div class="illustration-box">
            <div class="illustration-circle">
                <i class="fas fa-exclamation"></i>
            </div>
        </div>

        <!-- Text -->
        <div class="title text-center">
            Report issues instantly
        </div>

        <div class="description text-center">
            Found a pothole or a broken streetlight?  
            Take a photo and let your city officials  
            know in seconds.
        </div>

        <!-- Dots -->
        <div class="dots">
            <span class="dot active"></span>
            <span class="dot"></span>
            <span class="dot"></span>
        </div>
        <center>
        <!-- Button -->
     <a href="Default3.aspx" class="btn-next">
    Next <i class="fas fa-arrow-right ms-2"></i>
</a>
            </center>
        <div class="step-text">
            Step 1 of 3
        </div>

    </div>

</div>

</asp:Content>
