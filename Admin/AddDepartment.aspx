<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AddDepartment.aspx.cs" Inherits="Admin_AddDepartment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <style>
        .card-custom {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .form-label {
            font-weight: 600;
            color: #444;
        }

        .btn-custom {
            background: #3d5afe;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
        }

        .btn-custom:hover {
            background: #2c46d3;
        }
    </style>

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <div class="card card-custom p-4">
            <h4 class="mb-4">
                <i class="fas fa-building me-2"></i> Add Department
            </h4>

            <div class="row">
                    <asp:Label ID="lblmsg" runat="server" CssClass="validation-error" Visible="false"></asp:Label>


                <!-- Department Type -->
               <div class="col-md-6 mb-3">
    <label class="form-label">Department</label>
    <asp:DropDownList ID="ddlDepartmentType" runat="server" CssClass="form-select">
        <asp:ListItem Text="-- Select Type --" Value=""></asp:ListItem>

        <asp:ListItem>Public Works</asp:ListItem>
        <asp:ListItem>Electricity</asp:ListItem>
        <asp:ListItem>Water Supply</asp:ListItem>
        <asp:ListItem>Sanitation</asp:ListItem>
        <asp:ListItem>Transport</asp:ListItem>
        <asp:ListItem>Health</asp:ListItem>
        <asp:ListItem>Road Maintenance</asp:ListItem>
        <asp:ListItem>Street Lighting</asp:ListItem>
        <asp:ListItem>Drainage</asp:ListItem>
        <asp:ListItem>Parks & Gardens</asp:ListItem>
        <asp:ListItem>Waste Management</asp:ListItem>
        <asp:ListItem>Fire & Emergency</asp:ListItem>

    </asp:DropDownList>
</div>
                <!-- Description -->
                <div class="col-md-12 mb-3">
                    <label class="form-label">Department Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter department description"></asp:TextBox>
                </div>

                <!-- Contact Number -->
                <div class="col-md-12 mb-3">
                    <label class="form-label">Contact Number</label>
                    <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" placeholder="Enter department Contact Number"></asp:TextBox>
                </div>

                <!-- Status -->
                <div class="col-md-6 mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Map for location -->
     <div class="col-12 mt-3">
    <label class="form-label">Select Location on Map</label>
    <div id="map" style="height:400px; border-radius:15px;"></div>
</div>

<asp:HiddenField ID="hfLatitude" runat="server" />
<asp:HiddenField ID="hfLongitude" runat="server" />
                </div>
                <!-- Location fields -->
     

              <div class="col-md-6">
    <label class="form-label">Enter Address of Department</label>
    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" 
        placeholder="Type the address of the issue here..."></asp:TextBox>
</div>

                <div class="col-md-4 mb-3">
                    <label>Email</label>
                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
             <asp:Button ID="btnSendOTP" runat="server"
            Text="Send OTP"
            CssClass="btn btn-custom"
            OnClick="btnSendOTP_Click" />

        <!-- OTP -->
        <div class="input-group-custom">
            <i class="fas fa-key"></i>
            <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" placeholder="Enter OTP"></asp:TextBox>
        </div>

        <!-- Verify OTP -->
        <asp:Button ID="btnVerifyOTP" runat="server"
            Text="Verify OTP"
            CssClass="btn btn-danger"
            OnClick="btnVerifyOTP_Click" />

                <!-- Password -->
                <div class="col-md-6 mb-3">
                    <label class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter strong password"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revPass" runat="server" ControlToValidate="txtPassword"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$"
                        ErrorMessage="Min 6 chars, 1 Upper, 1 Lower, 1 Number"
                        ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Photo -->
                <div class="col-md-6 mb-3">
                    <label class="form-label">Department Photo</label>
                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                </div>

                <!-- Buttons -->
                <div class="mt-3">
                    <asp:Button ID="btnSave" runat="server" Text="Save Department" CssClass="btn btn-custom text-white" OnClick="btnSave_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary ms-2" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        var map = L.map('map').setView([20.5937, 78.9629], 5);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        var marker = L.marker([20.5937, 78.9629], { draggable: true }).addTo(map);

        var addressBox = document.getElementById('<%= txtAddress.ClientID %>');

    // ================= CLICK ON MAP =================
    map.on('click', function (e) {
        marker.setLatLng(e.latlng);
        updateLocation(e.latlng);
    });

    // ================= DRAG MARKER =================
    marker.on('dragend', function () {
        updateLocation(marker.getLatLng());
    });

    // ================= UPDATE ADDRESS =================
    function updateLocation(latlng) {

        document.getElementById('<%= hfLatitude.ClientID %>').value = latlng.lat;
        document.getElementById('<%= hfLongitude.ClientID %>').value = latlng.lng;

        fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${latlng.lat}&lon=${latlng.lng}`)
            .then(response => response.json())
            .then(data => {
                if (data.display_name) {
                    addressBox.value = data.display_name;
                }
            })
            .catch(error => console.log("Error fetching address:", error));
    }

    // ================= ADDRESS TYPING → MAP =================
    let timer;

    addressBox.addEventListener("keyup", function () {

        clearTimeout(timer);

        timer = setTimeout(function () {

            let address = addressBox.value;

            if (address.length < 5) return;

            fetch("https://nominatim.openstreetmap.org/search?format=json&q=" + address)
                .then(response => response.json())
                .then(data => {

                    if (data.length > 0) {

                        var lat = data[0].lat;
                        var lon = data[0].lon;

                        var latlng = L.latLng(lat, lon);

                        map.setView(latlng, 15);
                        marker.setLatLng(latlng);

                        document.getElementById('<%= hfLatitude.ClientID %>').value = lat;
                        document.getElementById('<%= hfLongitude.ClientID %>').value = lon;

                    }
                })
                .catch(error => console.log(error));

        }, 800); // wait 0.8 sec after typing
    });

    setTimeout(function () {
        map.invalidateSize();
    }, 500);

});
</script>    
</asp:Content>