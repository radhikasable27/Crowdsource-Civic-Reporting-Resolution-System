using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ChnageEmail : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAdminEmail();
        }
    }

    // ================= LOAD CURRENT EMAIL =================
    private void LoadAdminEmail()
    {
        using(SqlConnection con = new SqlConnection(cs))
        {
            string query = @"select username from Admin_Login";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtCurrentEmail.Text = dr["username"].ToString();
            }
            dr.Close();


        }
    }

    // ================= UPDATE EMAIL =================
    protected void btnUpdateEmail_Click(object sender, EventArgs e)
    {
        string currentEmail = txtCurrentEmail.Text.Trim();
        string newEmail = txtNewEmail.Text.Trim();

        if (newEmail == "")
        {
            lblMsg.Text = "Please enter new email.";
            return;
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("UPDATE Admin_Login SET username=@newemail WHERE username=@currentemail", con);

            cmd.Parameters.AddWithValue("@newemail", newEmail);
            cmd.Parameters.AddWithValue("@currentemail", currentEmail);

            cmd.ExecuteNonQuery();
        }

        // Update session email
        Session["username"] = newEmail;

        lblMsg.ForeColor = System.Drawing.Color.Green;
        lblMsg.Text = "Email updated successfully.";
    }
}