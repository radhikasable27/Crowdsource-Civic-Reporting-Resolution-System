using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;


public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public static string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();

            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }

            return builder.ToString();
        }
    }
    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        if (Session["UserOTP"] == null)
        {
            lblmsg.Text = "Please request OTP first.";
            return;
        }

        if (txtOTP.Text.Trim() == Session["UserOTP"].ToString())
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpVerified",
            "Swal.fire({icon:'success',title:'OTP Verified!',text:'OTP Verified Successfully!',confirmButtonColor:'#18c1d6'});", true); Session["OTPVerified"] = true;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpInvalid",
            "Swal.fire({icon:'error',title:'Invalid OTP!',text:'Please enter correct OTP.',confirmButtonColor:'#d33'});", true);
        }
    }
    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtemail.Text))
        {
            lblmsg.Text = "Please enter email first.";
            return;
        }

        string otp = GenerateOTP();
        Session["UserOTP"] = otp;   // Store OTP in session

        try
        {

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mycollegeproject02@gmail.com", "CivicConnect");

            mail.To.Add(txtemail.Text.Trim());
            mail.Subject = "Your Registration OTP";
            mail.Body = "Your OTP is: " + otp;
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);

            ScriptManager.RegisterStartupScript(this, GetType(), "otpSuccess",
 "Swal.fire({icon:'success',title:'OTP Sent!',text:'OTP sent to your email successfully.',confirmButtonColor:'#18c1d6'});", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpError",
            "Swal.fire({icon:'error',title:'Error!',text:'Failed to send OTP. Please try again.',confirmButtonColor:'#d33'});", true);
        }
    }
    // Generate Random 6 Digit OTP
    private string GenerateOTP()
    {
        Random rnd = new Random();
        return rnd.Next(100000, 999999).ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtname.Text) ||
            string.IsNullOrWhiteSpace(txtemail.Text) ||
            string.IsNullOrWhiteSpace(txtaddress.Text) ||
            string.IsNullOrWhiteSpace(txtcontact.Text) ||
            string.IsNullOrWhiteSpace(txtusername.Text) ||
            string.IsNullOrWhiteSpace(txtpwd.Text))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "fillAll",
                "Swal.fire({icon:'warning',title:'Empty Fields',text:'Please fill all fields',confirmButtonColor:'#d33'});", true);
            return;
        }

        string cs = ConfigurationManager.AppSettings["LISS"];

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // ====== CHECK EMAIL ======
            using (SqlCommand checkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM Registration WHERE emailid=@Email", con))
            {
                checkEmailCmd.Parameters.AddWithValue("@Email", txtemail.Text.Trim());
                int emailCount = Convert.ToInt32(checkEmailCmd.ExecuteScalar());

                if (emailCount > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "emailExists",
                        "Swal.fire({icon:'warning',title:'Email Exists!',text:'This email is already registered.',confirmButtonColor:'#d33'});", true);
                    return;
                }
            }

            // ====== CHECK USERNAME ======
            using (SqlCommand checkUsernameCmd = new SqlCommand("SELECT COUNT(*) FROM Registration WHERE username=@Username", con))
            {
                checkUsernameCmd.Parameters.AddWithValue("@Username", txtusername.Text.Trim());
                int usernameCount = Convert.ToInt32(checkUsernameCmd.ExecuteScalar());

                if (usernameCount > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "usernameExists",
                        "Swal.fire({icon:'warning',title:'Username Exists!',text:'This username is already registered.',confirmButtonColor:'#d33'});", true);
                    return;
                }
            }

            // ====== INSERT NEW USER ======
            string hashedPassword = HashPassword(txtpwd.Text.Trim());

            using (SqlCommand insertCmd = new SqlCommand(
                @"INSERT INTO Registration (uname, mobileno, address, emailid, username, pwd)
              VALUES (@sname, @contact, @address, @emailid, @userid, @pwd);
              SELECT SCOPE_IDENTITY();", con))
            {
                insertCmd.Parameters.AddWithValue("@sname", txtname.Text.Trim());
                insertCmd.Parameters.AddWithValue("@contact", txtcontact.Text.Trim());
                insertCmd.Parameters.AddWithValue("@address", txtaddress.Text.Trim());
                insertCmd.Parameters.AddWithValue("@emailid", txtemail.Text.Trim());
                insertCmd.Parameters.AddWithValue("@userid", txtusername.Text.Trim());
                insertCmd.Parameters.AddWithValue("@pwd", hashedPassword);

                int newUserId = Convert.ToInt32(insertCmd.ExecuteScalar());

                // ====== SAVE PHOTO IF EXISTS ======
                if (fuphoto.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(fuphoto.FileName);
                    string photoFileName = "User_" + newUserId + extension;
                    string folderPath = Server.MapPath("~/UserPhotos/");
                    fuphoto.SaveAs(System.IO.Path.Combine(folderPath, photoFileName));

                    using (SqlCommand updatePhotoCmd = new SqlCommand("UPDATE Registration SET photo=@photo WHERE user_id=@uid", con))
                    {
                        updatePhotoCmd.Parameters.AddWithValue("@photo", photoFileName);
                        updatePhotoCmd.Parameters.AddWithValue("@uid", newUserId);
                        updatePhotoCmd.ExecuteNonQuery();
                    }
                }

                // ====== SUCCESS MESSAGE ======
                ScriptManager.RegisterStartupScript(this, GetType(), "regSuccess",
                    "Swal.fire({icon:'success',title:'Registered!',text:'Registration Successful',confirmButtonColor:'#18c1d6'}).then(()=>{window.location='Default3.aspx';});", true);
            }
        }
    }
}