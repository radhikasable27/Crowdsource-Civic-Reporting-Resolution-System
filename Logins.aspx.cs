using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Logins : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Do nothing here
    }

   

    protected void btnlogins_Click(object sender, EventArgs e)
    {
        

        SqlConnection con = new SqlConnection(
            ConfigurationManager.AppSettings["LISS"]);

        SqlCommand cmd = new SqlCommand(
            "SELECT user_id FROM Registration WHERE username=@username AND pwd=@pwd",
            con);

        cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
        cmd.Parameters.AddWithValue("@pwd", txtPassword.Text.Trim());

        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            Session["Email"] = dr["emailid"].ToString();
            // Successful login
            Session["user_id"] = dr["user_id"].ToString();
            con.Close();
            Response.Redirect("~/User/Default.aspx");
        }
        else
        {
            // Failed login
            con.Close();
            lblMsg.Visible = true;
            lblMsg.Text = "Invalid username or password";
        }
    }
}
