using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

public partial class Admin_NewMess : System.Web.UI.Page
{
    protected int issueID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Get IssueID from QueryString
            if (Request.QueryString["id"] != null)
            {
                issueID = Convert.ToInt32(Request.QueryString["id"]);
                ViewState["IssueID"] = issueID;
                LoadIssueDetails(issueID);
            }
            else
            {
                Response.Redirect("IssueManagement.aspx");
            }
        }
    }

    private void LoadIssueDetails(int id)
    {
        // Replace with your database connection
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM UserIssue WHERE IssueID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblType.Text = dr["IssueType"].ToString();
                lblDescription.Text = dr["Description"].ToString();
                lblAddress.Text = dr["Address"].ToString();
                lblStatus.Text = dr["Status"].ToString();
                lblCreatedDate.Text = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd-MM-yyyy HH:mm");

                if (dr["Photo"] != DBNull.Value)
                {
                    imgIssuePhoto.ImageUrl = "~/IssuePhotos/" + dr["Photo"].ToString();
                }
            }
            dr.Close();
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Show completion photo section only when status is Completed
        if (ddlStatus.SelectedValue == "Completed")
        {
            divCompletionPhoto.Style["display"] = "block";
        }
        else
        {
            divCompletionPhoto.Style["display"] = "none";
        }
    }

    protected void btnSaveAction_Click(object sender, EventArgs e)
    {
        if (ViewState["IssueID"] == null) return;

        int id = Convert.ToInt32(ViewState["IssueID"]);
        string status = ddlStatus.SelectedValue;
        string remarks = txtRemarks.Text.Trim();
        string photoFileName = null;

        // Save captured photo if available
        if (!string.IsNullOrEmpty(hfCompletionPhoto.Value))
        {
            string base64 = hfCompletionPhoto.Value.Split(',')[1];
            byte[] bytes = Convert.FromBase64String(base64);
            photoFileName = "completion_" + id + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".png";
            string path = Server.MapPath("~/uploads/completion/") + photoFileName;
            File.WriteAllBytes(path, bytes);
        }
        else if (fileCompletionPhoto.HasFile)
        {
            photoFileName = "completion_" + id + "_" + fileCompletionPhoto.FileName;
            fileCompletionPhoto.SaveAs(Server.MapPath("~/uploads/completion/") + photoFileName);
        }

        // Update database
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "UPDATE IssueActions SET Status=@status, Remarks=@remarks, CompletionPhoto=@photo WHERE IssueID=@id", con);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            cmd.Parameters.AddWithValue("@photo", (object)photoFileName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Action saved successfully!'); window.location='IssueManagement.aspx';", true);
    }
}