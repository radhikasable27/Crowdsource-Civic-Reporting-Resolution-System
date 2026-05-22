using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

public partial class ForgotPassword : Page
{
    private string generatedOTP
    {
        get { return ViewState["OTP"] != null ? ViewState["OTP"].ToString() : ""; }
        set { ViewState["OTP"] = value; }
    }

    private string resetType
    {
        get { return rblType.SelectedValue; }
    }

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        if (email == "")
        {
            lblEmailMsg.Text = "Enter email.";
            return;
        }

        string tableName = "";
        string emailColumn = "";

        if (resetType == "User")
        {
            tableName = "Registration";
            emailColumn = "emailid";
        }
        else if (resetType == "Department")
        {
            tableName = "Department";
            emailColumn = "Email";
        }
        else if (resetType == "Admin")
        {
            tableName = "Admin_Login";
            emailColumn = "username";   // admin login column
        }


        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM " + tableName + " WHERE " + emailColumn + "=@Email", con); cmd.Parameters.AddWithValue("@Email", email);
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            if (count == 0)
            {
                lblEmailMsg.Text = resetType + " email not registered.";
                return;
            }
        }

        Random rnd = new Random();
        generatedOTP = rnd.Next(100000, 999999).ToString();

        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mycollegeproject02@gmail.com","CivicConnect");
            mail.To.Add(email);
            mail.Subject = "OTP for Password Reset";
            mail.Body = "Your OTP is: " + generatedOTP;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("mycollegeproject02@gmail.com", "rzkh ekar ngzy vghw");
            smtp.EnableSsl = true;
            smtp.Send(mail);

            lblEmailMsg.CssClass = "text-success";
            lblEmailMsg.Text = "OTP sent successfully to " + email;
        }
        catch (Exception ex)
        {
            lblEmailMsg.CssClass = "text-danger";
            lblEmailMsg.Text = "Error sending OTP: " + ex.Message;
            return;
        }

        pnlEmail.Visible = false;
        pnlOTP.Visible = true;
    }

    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        if (txtOTP.Text.Trim() == generatedOTP)
        {
            pnlOTP.Visible = false;
            pnlReset.Visible = true;
        }
        else
        {
            lblOTPMsg.Text = "Invalid OTP.";
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        if (txtNewPassword.Text.Trim() != txtConfirmPassword.Text.Trim())
        {
            lblResetMsg.CssClass = "text-danger";
            lblResetMsg.Text = "Passwords do not match!";
            return;
        }

        string newPwd = HashPassword(txtNewPassword.Text.Trim());

        string tableName = "";
        string emailColumn = "";
        string pwdColumn = "";

        if (resetType == "User")
        {
            tableName = "Registration";
            emailColumn = "emailid";
            pwdColumn = "pwd";
        }
        else if (resetType == "Department")
        {
            tableName = "Department";
            emailColumn = "Email";
            pwdColumn = "Password";
        }
        else if (resetType == "Admin")
        {
            tableName = "Admin_Login";
            emailColumn = "username";
            pwdColumn = "password";
        }

        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            string query = "";

            if (resetType == "Admin")
            {
                query = "UPDATE " + tableName + " SET " + pwdColumn + "=@pwd WHERE " + emailColumn + "=@Email";
            }
            else
            {
                query = "UPDATE " + tableName + " SET " + pwdColumn + "=@pwd, LoginAttempts=0 WHERE " + emailColumn + "=@Email";
            }

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@pwd", newPwd);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            cmd.ExecuteNonQuery();
        }
        // Success Popup
        string script = "alert('" + resetType + " password updated successfully!');window.location='Default3.aspx';";
        ClientScript.RegisterStartupScript(this.GetType(), "PasswordReset", script, true);
    }
    private string HashPassword(string password)
    {
        SHA256Managed sha = new SHA256Managed();
        byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.Length; i++)
            sb.Append(bytes[i].ToString("x2"));
        return sb.ToString();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default3.aspx");
    }
}