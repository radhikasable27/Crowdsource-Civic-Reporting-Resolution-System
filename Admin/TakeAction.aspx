<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Admin/AdminMasterPage.master"
    EnableEventValidation="false"
    CodeFile="TakeAction.aspx.cs"
    Inherits="Admin_NewMess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <div class="container py-4">
        <h3 class="mb-4 text-primary">Take Action on Issue</h3>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <!-- Issue Details -->
                <div class="row mb-3">
                    <div class="col-md-4 text-center">
                        <asp:Image ID="imgIssuePhoto" runat="server" CssClass="img-fluid img-thumbnail mb-2" />
                        <p><small class="text-muted">Issue Photo</small></p>
                    </div>
                    <div class="col-md-8">
                        <h5 id="lblIssueType"><b>Issue Type:</b> <asp:Label ID="lblType" runat="server" /></h5>
                        <p><b>Description:</b> <asp:Label ID="lblDescription" runat="server" /></p>
                        <p><b>Location:</b> <asp:Label ID="lblAddress" runat="server" /></p>
                        <p><b>Status:</b> <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold" /></p>
                        <%--<p><b>Reported By User ID:</b> <asp:Label ID="lblUserID" runat="server" /></p>--%>
                        <p><b>Created Date:</b> <asp:Label ID="lblCreatedDate" runat="server" /></p>
                    </div>
                </div>

                <!-- Action Form -->
                <div class="row mt-4">
                    <div class="col-12">
                        <h5>Update Action / Status</h5>
                    
                            <div class="mb-3">
                                <label for="ddlStatus" class="form-label">Change Status</label>
<asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">                                   
                                    <asp:ListItem Text="In Progress" Value="In Progress" />
                                    <asp:ListItem Text="Completed" Value="Completed" />
                                </asp:DropDownList>
                            </div>

                            <div class="mb-3">
                                <label for="txtRemarks" class="form-label">Remarks / Notes</label>
                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4" />
                            </div>
<div id="divCompletionPhoto" runat="server" style="display:none;" class="mb-3">
    <label class="form-label fw-bold">Capture Completion Photo</label>
    <!-- File Upload Option -->
<div class="mt-3">
    <label for="fileCompletionPhoto" class="form-label fw-bold">Or Upload Photo</label>
    <asp:FileUpload ID="fileCompletionPhoto" runat="server" CssClass="form-control" />
</div>
    <div class="text-center">

        <!-- Responsive Video -->
        <video id="video" autoplay playsinline
            class="img-fluid rounded shadow-sm"
            style="max-height:300px; width:100%; border:1px solid #ccc;">
        </video>

        <!-- Buttons -->
        <div class="mt-3">
            <button type="button" onclick="capturePhoto()"
                class="btn btn-success btn-sm px-4">
                📸 Capture
            </button>

            <button type="button" onclick="retakePhoto()"
                class="btn btn-warning btn-sm px-4 ms-2">
                🔄 Retake
            </button>
        </div>

        <!-- Hidden Canvas -->
        <canvas id="canvas" style="display:none;"></canvas>

        <!-- Hidden Field -->
        <asp:HiddenField ID="hfCompletionPhoto" runat="server" />

    </div>
</div>
                            <div class="d-flex justify-content-end">
                                <asp:Button ID="btnSaveAction" runat="server" CssClass="btn btn-primary me-2" Text="Save Changes" OnClick="btnSaveAction_Click"  />
                                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" PostBackUrl="IssueManagement.aspx" />
                            </div>
                    
                    </div>
                </div>
            </div>
        </div>
</div>
<script>
    const video = document.getElementById('video');
    const canvas = document.getElementById('canvas');
    let stream;

    // Open Back Camera on Mobile
    async function startCamera() {
        try {
            stream = await navigator.mediaDevices.getUserMedia({
                video: { facingMode: "environment" } // Back camera
            });
            video.srcObject = stream;
        } catch (err) {
            alert("Camera access denied or not supported.");
        }
    }

    startCamera();

    function capturePhoto() {
        const context = canvas.getContext('2d');

        // Set canvas size dynamically
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;

        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        const dataURL = canvas.toDataURL('image/png');
        document.getElementById('<%= hfCompletionPhoto.ClientID %>').value = dataURL;

        alert("Photo Captured Successfully!");

        // Stop camera after capture (optional)
        stopCamera();
    }

    function retakePhoto() {
        document.getElementById('<%= hfCompletionPhoto.ClientID %>').value = "";
        startCamera();
    }

    function stopCamera() {
        if (stream) {
            stream.getTracks().forEach(track => track.stop());
        }
    }
</script>
</asp:Content>
