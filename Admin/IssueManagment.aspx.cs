using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Admin_IssueManagment : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDepartments();
            LoadIssues();
        }
    }

    // ================= LOAD DEPARTMENTS =================
    private void LoadDepartments()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("SELECT DepartmentID, DepartmentType FROM Department", con);
            con.Open();

            ddlDepartment.DataSource = cmd.ExecuteReader();
            ddlDepartment.DataTextField = "DepartmentType";
            ddlDepartment.DataValueField = "DepartmentID";
            ddlDepartment.DataBind();

            ddlDepartment.Items.Insert(0, new ListItem("All Departments", ""));
        }
    }
    protected void gvIssues_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "TakeAction")
        {
            string issueID = e.CommandArgument.ToString();

            Response.Redirect("DepartmentNotice.aspx?IssueID=" + issueID);
        }
    }
    protected void gvIssues_SelectedIndexChanged(object sender, EventArgs e)
    {
        string issueID = gvIssues.SelectedDataKey.Value.ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
        SELECT 
            UI.IssueID,
            UI.IssueType,
            UI.Address,
            UI.Description,
            UI.Status,
            UI.Photo,Photo2,
            UI.CompletionPhoto,CompletionPhoto2,
            R.uname
        FROM UserIssue UI
        INNER JOIN Registration R 
            ON UI.UserID = R.user_id
        WHERE UI.IssueID=@IssueID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@IssueID", issueID);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblIssueID.Text = dr["IssueID"].ToString();
                lblIssueType.Text = dr["IssueType"].ToString();
                lblDescription.Text = dr["Description"].ToString();
                //lblCitizen.Text = dr["uname"].ToString();
                lblAddress.Text = dr["Address"].ToString();

                // BEFORE IMAGE
                imgBefore.ImageUrl = "~/IssuePhotos/" + dr["Photo"].ToString();
                imgBefore2.ImageUrl = "~/IssuePhotos/" + dr["Photo2"].ToString();

                // AFTER IMAGE (only if completed)
                if (dr["Status"].ToString() == "Completed")
                {
                    pnlAfter.Visible = true;

                    if (!string.IsNullOrEmpty(dr["CompletionPhoto"].ToString()))
                    {
                        imgAfter.ImageUrl = "~/CompletionPhotos/" + dr["CompletionPhoto"].ToString();
                    }

                    if (!string.IsNullOrEmpty(dr["CompletionPhoto2"].ToString()))
                    {
                        imgAfter2.ImageUrl = "~/CompletionPhotos/" + dr["CompletionPhoto2"].ToString();
                    }
                }
                else
                {
                    pnlAfter.Visible = false;
                }
            }
        }
    }
    // ================= LOAD ISSUES =================
    private void LoadIssues()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
        SELECT 
            UI.IssueID,
            UI.IssueType,
            UI.Address,
            UI.Status,
            UI.CreatedDate,
            UI.Description,
            UI.Photo,UI.Photo2,
            UI.CompletionPhoto,UI.CompletionPhoto2
        FROM UserIssue UI
        WHERE 1=1";

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            // ===== STATUS FILTER =====
            // STATUS FILTER
            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                query += " AND UI.Status = @Status";
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            }

            // DEPARTMENT FILTER
            if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
            {
                query += " AND UI.DepartmentID = @DeptID";
                cmd.Parameters.AddWithValue("@DeptID", ddlDepartment.SelectedValue);
            }

            query += " ORDER BY UI.CreatedDate DESC";

            cmd.CommandText = query;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvIssues.DataSource = dt;
            gvIssues.DataBind();
        }
    }    // ================= FILTER CHANGE EVENTS =================
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIssues();
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIssues();
    }

    protected void ddlPriority_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIssues();
    }

    // ================= CLEAR FILTERS =================
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlStatus.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
      //  ddlPriority.SelectedIndex = 0;

        LoadIssues();
    }

    // ================= SAVE CHANGES (Example: Update Status) =================
    protected void btnSave_Click(object sender, EventArgs e)
    {
        // Example: update selected issue status to Resolved
        if (gvIssues.SelectedRow != null)
        {
            string issueID = gvIssues.SelectedRow.Cells[0].Text;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE UserIssue SET Status='Complete' WHERE IssueID=@IssueID", con);

                cmd.Parameters.AddWithValue("@IssueID", issueID);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadIssues();
        }
    }
}