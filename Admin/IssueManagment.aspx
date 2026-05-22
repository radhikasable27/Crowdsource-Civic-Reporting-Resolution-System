<%@ Page Title="Issue Management" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="IssueManagment.aspx.cs" Inherits="Admin_IssueManagment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style>

/* PAGE */
.page-title {
    font-weight: 600;
    margin-bottom: 5px;
}

.subtitle {
    color: #777;
    font-size: 14px;
    margin-bottom: 20px;
}

/* FILTER */
.filter-box {
    background: #ffffff;
    padding: 15px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

/* TABLE CARD */
.table-card {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    padding: 15px;
}

/* DETAIL CARD */
.detail-card {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    padding: 20px;
}

/* SECTION TITLE */
.section-title {
    font-size: 14px;
    font-weight: 600;
    margin-top: 15px;
    margin-bottom: 10px;
    color: #555;
}

/* STATUS BADGE */
.badge-status {
    background: #f0f0f0;
    color:#333;
}

/* MOBILE IMPROVEMENT */
@media (max-width: 768px) {

    .page-title {
        font-size: 18px;
    }

    .subtitle {
        font-size: 12px;
    }

    .detail-card {
        margin-top: 15px;
    }

    .table-card {
        padding: 10px;
    }

}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container-fluid">

    <!-- TITLE -->
    <h4 class="page-title">Issue Management</h4>
    <div class="subtitle">Monitor and resolve active citizen reports</div>

    <!-- FILTER SECTION -->
    <div class="filter-box row g-3 align-items-end">

        <div class="col-12 col-md-3">
            <asp:DropDownList 
                ID="ddlStatus" 
                runat="server" 
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                <asp:ListItem Value="">All Statuses</asp:ListItem>
                <asp:ListItem>In Progress</asp:ListItem>
                <asp:ListItem>Completed</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-12 col-md-3">
            <asp:DropDownList 
                ID="ddlDepartment" 
                runat="server" 
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div class="col-12 col-md-3 d-grid">
            <asp:Button 
                ID="btnClear" 
                runat="server" 
                Text="Clear Filters" 
                CssClass="btn btn-outline-secondary w-100"
                OnClick="btnClear_Click" />
        </div>

    </div>

    <!-- MAIN ROW -->
    <div class="row g-4">

        <!-- LEFT TABLE -->
        <div class="col-12 col-lg-8">
            <div class="table-card">

                <div class="table-responsive">

                    <asp:GridView ID="gvIssues" runat="server"
                        CssClass="table table-hover table-bordered"
                        AutoGenerateColumns="False"
                        DataKeyNames="IssueID"
                        OnSelectedIndexChanged="gvIssues_SelectedIndexChanged"  OnRowCommand="gvIssues_RowCommand"
                        AutoGenerateSelectButton="True">

                        <Columns>

                            <asp:BoundField DataField="IssueID" HeaderText="ID" />
                            <asp:BoundField DataField="IssueType" HeaderText="Issue Type" />
                            <asp:BoundField DataField="Address" HeaderText="Location" />

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class="badge badge-status">
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="CreatedDate" HeaderText="Reported" />
                            <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:Button 
            ID="btnTakeAction" 
            runat="server" 
            Text="Take Action" 
            CssClass="btn btn-sm btn-info w-100"
            CommandName="TakeAction" 
            CommandArgument='<%# Eval("IssueID") %>' />
    </ItemTemplate>
</asp:TemplateField>
                        </Columns>

                    </asp:GridView>

                </div>

            </div>
        </div>

        <!-- RIGHT DETAILS -->
        <div class="col-12 col-lg-4">
            <div class="detail-card">

                <h5>Case #<asp:Label ID="lblIssueID" runat="server" /></h5>
                <h6 class="text-muted">
                    <asp:Label ID="lblIssueType" runat="server" />
                </h6>

                <div class="section-title">Description</div>
                <p><asp:Label ID="lblDescription" runat="server" /></p>

                <div class="section-title">Location Detail</div>
                <p><asp:Label ID="lblAddress" runat="server" /></p>

                <div class="section-title">Before Image</div>
                <asp:Image ID="imgBefore" runat="server"
                    CssClass="img-fluid rounded mb-2 w-100" />
                  <asp:Image ID="imgBefore2" runat="server"
                    CssClass="img-fluid rounded mb-2 w-100" />

                <asp:Panel ID="pnlAfter" runat="server" Visible="false">
                    <div class="section-title">Completion Image</div>
                    <asp:Image ID="imgAfter" runat="server"
                        CssClass="img-fluid rounded w-100" />
                                        <asp:Image ID="imgAfter2" runat="server"
                        CssClass="img-fluid rounded w-100" />

                </asp:Panel>

            </div>
        </div>

    </div>

</div>

</asp:Content>