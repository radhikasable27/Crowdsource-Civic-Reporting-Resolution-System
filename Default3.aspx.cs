using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class Default3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // ================= HASH PASSWORD =================
    public static string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();

            foreach (byte b in bytes)
                builder.Append(b.ToString("x2"));

            return builder.ToString();
        }
    }

    // ================= GENERATE OTP =================
    private string GenerateOTP()
    {
        Random rnd = new Random();
        return rnd.Next(100000, 999999).ToString();
    }

    // ================= SEND OTP =================
    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtUsername.Text))
        {
            ShowPopup("warning", "Enter Email First", "Please enter your email or username.");
            return;
        }

        string otp = GenerateOTP();
        Session["UserOTP"] = otp;

        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mycollegeproject02@gmail.com", "CivicConnect");
            mail.To.Add(txtUsername.Text.Trim());
            mail.Subject = "Your Login OTP";
            mail.Body = "Your OTP is: " + otp;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new System.Net.NetworkCredential("mycollegeproject02@gmail.com", "rzkh ekar ngzy vghw");
            smtp.EnableSsl = true;
            smtp.Send(mail);

            btnLogin.Text = "Verify OTP";

            ShowPopup("success", "OTP Sent", "OTP sent to your email successfully.");

        }
        catch
        {
            ShowPopup("error", "Error", "Failed to send OTP.");
        }
    }

    // ================= LOGIN =================
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string userType = hfUserType.Value;
        string username = txtUsername.Text.Trim();
        string passwordInput = txtPassword.Text.Trim();

        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // ================= OTP LOGIN =================
            if (btnLogin.Text == "Verify OTP")
            {
                if (Session["UserOTP"] == null)
                {
                    ShowPopup("warning", "Request OTP", "Please request OTP first.");
                    return;
                }

                if (passwordInput != Session["UserOTP"].ToString())
                {
                    ShowPopup("error", "Invalid OTP", "Please enter correct OTP.");
                    return;
                }

                Session.Remove("UserOTP");

                ResetLoginAttempts(con, username, userType);

                ShowPopup("success", "OTP Verified", "Login successful.");

                LoginUser(con, username, userType);
                return;
            }

            // ================= PASSWORD LOGIN =================

            // ================= PASSWORD LOGIN =================

            string hashedPassword = HashPassword(passwordInput);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            if (userType == "Citizen")
                cmd.CommandText = "SELECT * FROM Registration WHERE emailid=@username OR username=@username";

            else if (userType == "Department")
                cmd.CommandText = "SELECT * FROM Department WHERE Email=@username AND Status='Active'";

            else
                cmd.CommandText = "SELECT * FROM Admin_Login WHERE username=@username";

            cmd.Parameters.AddWithValue("@username", username);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                dr.Close();
                ShowPopup("error", "User Not Found", "Invalid username.");
                return;
            }

            string dbPassword = "";
            int attempts = 0;
            string userId = "";
            string userNameDB = "";
            string email = "";

            if (userType == "Citizen")
            {
                dbPassword = dr["pwd"].ToString();
                attempts = Convert.ToInt32(dr["LoginAttempts"]);
                userId = dr["user_id"].ToString();
                userNameDB = dr["username"].ToString();
            }
            else if (userType == "Department")
            {
                dbPassword = dr["Password"].ToString();
                attempts = Convert.ToInt32(dr["LoginAttempts"]);
                userId = dr["DepartmentID"].ToString();
                userNameDB = dr["DepartmentType"].ToString();
            }
            else
            {
               
                    dbPassword = dr["password"].ToString();
                email = dr["username"].ToString();
                    attempts = Convert.ToInt32(dr["LoginAttempts"]);
                    userId = dr["adminid"].ToString();
                
            }

            dr.Close();

            // ================= BLOCK AFTER 3 ATTEMPTS =================
            if (attempts >= 3)
            {
                ShowPopup("error", "Account Locked", "Too many wrong password attempts. Please login using OTP.");
                return;
            }

            // ================= PASSWORD MATCH =================
            if (hashedPassword == dbPassword)
            {
                // Always reset attempts after successful login
                ResetLoginAttempts(con, username, userType);

                ShowPopup("success", "Login Success", "Welcome to CivicConnect.");

                LoginUser(con, username, userType);
            }
            else
            {
                IncreaseAttempts(con, username, userType);

                int newAttempts = attempts + 1;

                if (newAttempts >= 3)
                {
                    ShowPopup("error", "Account Locked", "Too many wrong password attempts. Please login using OTP.");
                }
                else
                {
                    int remaining = 3 - newAttempts;
                    ShowPopup("warning", "Wrong Password", "Attempts remaining: " + remaining);
                }
            }
        }
    }

    // ================= INCREASE ATTEMPTS =================
    private void IncreaseAttempts(SqlConnection con, string username, string userType)
    {
        string query = "";

        if (userType == "Citizen")
            query = "UPDATE Registration SET LoginAttempts = ISNULL(LoginAttempts,0) + 1 WHERE emailid=@username OR username=@username";

        else if (userType == "Department")
            query = "UPDATE Department SET LoginAttempts = ISNULL(LoginAttempts,0) + 1 WHERE Email=@username";

        else if (userType == "Admin")
            query = "UPDATE Admin_Login SET LoginAttempts = ISNULL(LoginAttempts,0) + 1 WHERE username=@username";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@username", username);
        cmd.ExecuteNonQuery();
    }    // ================= RESET ATTEMPTS =================
    private void ResetLoginAttempts(SqlConnection con, string username, string userType)
    {
        string query = "";

        if (userType == "Citizen")
            query = "UPDATE Registration SET LoginAttempts=0 WHERE emailid=@username OR username=@username";

        else if (userType == "Department")
            query = "UPDATE Department SET LoginAttempts=0 WHERE Email=@username";

        else if (userType == "Admin")
            query = "UPDATE Admin_Login SET LoginAttempts=0 WHERE username=@username";

        if (query != "")
        {
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.ExecuteNonQuery();
        }
    }
    // ================= LOGIN USER =================
    private void LoginUser(SqlConnection con, string username, string userType)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        if (userType == "Citizen")
            cmd.CommandText = "SELECT * FROM Registration WHERE emailid=@username OR username=@username";

        else if (userType == "Department")
            cmd.CommandText = "SELECT * FROM Department WHERE Email=@username";

        else
        {
            Session["UserType"] = "Admin";
            Response.Redirect("Admin/Default.aspx");
            return;
        }

        cmd.Parameters.AddWithValue("@username", username);

        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            if (userType == "Citizen")
            {
                Session["user_id"] = dr["user_id"].ToString();
                Session["username"] = dr["username"].ToString();
                Session["UserType"] = "Citizen";
                Response.Redirect("User/Default.aspx");
            }
            else
            {
                Session["dept_id"] = dr["DepartmentID"].ToString();
                Session["username"] = dr["DepartmentType"].ToString();
                Session["UserType"] = "Department";
                Response.Redirect("Department/DepartmentDashboard.aspx");
            }
        }

        dr.Close();
    }

    // ================= SWEET ALERT POPUP =================
    private void ShowPopup(string icon, string title, string message)
    {
        string script = "Swal.fire({icon:'" + icon + "',title:'" + title + "',text:'" + message + "'});";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", script, true);
    }
}