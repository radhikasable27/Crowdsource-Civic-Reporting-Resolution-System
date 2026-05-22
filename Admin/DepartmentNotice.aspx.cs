using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

public partial class Admin_DepartmentNotice : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["IssueID"] != null)
            {
                txtIssueID.Text = Request.QueryString["IssueID"];
                LoadDepartment();
            }
        }
    }

    void LoadDepartment()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT d.DepartmentType
              FROM UserIssue u
              INNER JOIN Department d 
              ON u.DepartmentID = d.DepartmentID
              WHERE u.IssueID = @IssueID", con);

            cmd.Parameters.AddWithValue("@IssueID", txtIssueID.Text);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtDepartment.Text = dr["DepartmentType"].ToString();
            }
        }
    }

    protected void btnSendNotice_Click(object sender, EventArgs e)
    {
        string departmentEmail = "";

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // INSERT NOTICE
            SqlCommand cmd = new SqlCommand(
            "INSERT INTO DepartmentNotice(IssueID,DepartmentType,Message,Priority,NoticeDate) VALUES(@IssueID,@Department,@Message,@Priority,GETDATE())", con);

            cmd.Parameters.AddWithValue("@IssueID", txtIssueID.Text);
            cmd.Parameters.AddWithValue("@Department", txtDepartment.Text);
            cmd.Parameters.AddWithValue("@Message", txtMessage.Text);
            cmd.Parameters.AddWithValue("@Priority", ddlPriority.SelectedValue);

            cmd.ExecuteNonQuery();


            // GET DEPARTMENT EMAIL
            SqlCommand cmdEmail = new SqlCommand(
            @"SELECT d.Email
          FROM UserIssue u
          INNER JOIN Department d ON u.DepartmentID = d.DepartmentID
          WHERE u.IssueID = @IssueID", con);

            cmdEmail.Parameters.AddWithValue("@IssueID", txtIssueID.Text);

            departmentEmail = cmdEmail.ExecuteScalar().ToString();
        }

        // SEND EMAIL TO DEPARTMENT
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mycollegeproject02@gmail.com");
            mail.To.Add(departmentEmail);

            mail.Subject = "Department Warning Notice";

            mail.Body = "A new warning notice has been created.\n\n" +
                        "Issue ID: " + txtIssueID.Text + "\n" +
                        "Department: " + txtDepartment.Text + "\n" +
                        "Message: " + txtMessage.Text + "\n" +
                        "Priority: " + ddlPriority.SelectedValue;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("mycollegeproject02@gmail.com", "rzkh ekar ngzy vghw");
            smtp.EnableSsl = true;

            smtp.Send(mail);

            Response.Write("<script>alert('Notice sent and email delivered to department');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Email error: " + ex.Message + "');</script>");
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("IssueManagment.aspx");
    }
}