<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background: #e9ecef;
}

/* Mobile App Wrapper */
.dashboard-wrapper {
    max-width: 420px;
    margin: 30px auto;
    background: #f8f9fa;
    border-radius: 25px;
    padding: 15px;
    box-shadow: 0 20px 45px rgba(0,0,0,0.15);
    position: relative;
}

/* Header */
.dashboard-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.dashboard-header h5 {
    margin: 0;
    font-weight: 600;
}

/* Search */
.search-box {
    background: white;
    border-radius: 12px;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.search-box input {
    border: none;
    outline: none;
    width: 100%;
    margin-left: 8px;
}

/* Map */
.map-box img {
    width: 100%;
    border-radius: 15px;
}

/* Categories */
.categories {
    display: flex;
    justify-content: space-between;
    margin: 15px 0;
}

.category-item {
    text-align: center;
}

.category-icon {
    width: 55px;
    height: 55px;
    background: #dff6fb;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: auto;
    font-size: 20px;
    color: #18c1d6;
}

/* Issue Card */
.issue-card {
    background: white;
    border-radius: 15px;
    padding: 10px;
    display: flex;
    margin-bottom: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
}

.issue-card img {
    width: 70px;
    height: 60px;
    border-radius: 10px;
    object-fit: cover;
    margin-right: 10px;
}

.status {
    font-size: 11px;
    font-weight: 600;
}

.open { color: #28a745; }
.progress { color: #ff9800; }
.resolved { color: #18c1d6; }

/* Floating Button */
.floating-btn {
    position: absolute;
    right: 20px;
    bottom: 70px;
    width: 55px;
    height: 55px;
    border-radius: 50%;
    background: #18c1d6;
    color: white;
    border: none;
    font-size: 22px;
}

/* Bottom Nav */
.bottom-nav {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
    padding-top: 10px;
    border-top: 1px solid #ddd;
}

.bottom-nav i {
    font-size: 18px;
    color: #888;
}

.bottom-nav .active {
    color: #18c1d6;
}
</style>


<div class="dashboard-wrapper">

    <!-- Header -->
 <%--   <div class="dashboard-header">
        <i class="fas fa-bars"></i>
        <h5>CivicConnect</h5>
        <i class="fas fa-user-circle"></i>
    </div>--%>

    <!-- Search -->
    <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search for issues or locations" />
    </div>

    <!-- Map -->
    <div class="map-box mb-3">
        <img src="images/map.jpg" alt="Map" />
    </div>

    <!-- Categories -->
    <div>
        <div class="d-flex justify-content-between mb-2">
            <strong>Categories</strong>
            <small class="text-info">See all</small>
        </div>

        <div class="categories">
            <div class="category-item">
                <div class="category-icon"><i class="fas fa-road"></i></div>
                <small>Potholes</small>
            </div>
            <div class="category-item">
                <div class="category-icon"><i class="fas fa-trash"></i></div>
                <small>Garbage</small>
            </div>
            <div class="category-item">
                <div class="category-icon"><i class="fas fa-lightbulb"></i></div>
                <small>Lights</small>
            </div>
            <div class="category-item">
                <div class="category-icon"><i class="fas fa-tint"></i></div>
                <small>Water</small>
            </div>
        </div>
    </div>

    <!-- Nearby Issues -->
    <div class="mt-3">
        <strong>Nearby Issues</strong>

        <div class="issue-card">
            <img src="images/pothole.jpg" />
            <div>
                <div class="status open">OPEN</div>
                <strong>Large Pothole on Main St</strong>
                <div class="text-muted small">120m away</div>
            </div>
        </div>

        <div class="issue-card">
            <img src="images/garbage.jpg" />
            <div>
                <div class="status progress">IN-PROGRESS</div>
                <strong>Overflowing Trash Bin</strong>
                <div class="text-muted small">350m away</div>
            </div>
        </div>

        <div class="issue-card">
            <img src="images/light.jpg" />
            <div>
                <div class="status resolved">RESOLVED</div>
                <strong>Flickering Streetlight Fixed</strong>
                <div class="text-muted small">800m away</div>
            </div>
        </div>
    </div>

    <!-- Floating Button -->
    <button class="floating-btn">
        <i class="fas fa-plus"></i>
    </button>

    <!-- Bottom Navigation -->
    <div class="bottom-nav">
        <i class="fas fa-home active"></i>
        <i class="fas fa-compass"></i>
        <i class="fas fa-file-alt"></i>
        <i class="fas fa-bell"></i>
        <i class="fas fa-cog"></i>
    </div>

</div>

</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
</asp:Content>

