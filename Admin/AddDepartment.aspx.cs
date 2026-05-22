using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

public partial class Admin_AddDepartment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "GetLocation",
                "getLocation();",
                true);
        }
        // Optional: Admin session check
        if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
        {
            Response.Redirect("~/Default3.aspx");
        }
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
    // ================= SAVE BUTTON =================
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtemail.Text.Trim() == "" ||
        ddlDepartmentType.SelectedIndex == 0 ||
        txtDescription.Text.Trim() == "" ||
      
        txtPassword.Text.Trim() == "" ||
        txtAddress.Text.Trim() == "" ||
        txtmobile.Text.Trim() == "" ||
        !fuPhoto.HasFile)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "required",
            "Swal.fire({icon:'warning',title:'All Fields Required!',text:'Please fill all fields before saving.'});", true);
            return;
        }

        if (txtemail.Text.Trim() ==""||
            ddlDepartmentType.SelectedIndex == 0 ||
            txtPassword.Text.Trim() == "")
        {
            return;
        }
        string address = txtAddress.Text.Trim();
        string latitude = hfLatitude.Value;
        string longitude = hfLongitude.Value;
        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string checkQuery = "SELECT COUNT(*) FROM Department WHERE Email=@Name";
            SqlCommand cmdCheck = new SqlCommand(checkQuery, con);
            cmdCheck.Parameters.AddWithValue("@Name", txtemail.Text.Trim());

            int count = (int)cmdCheck.ExecuteScalar();
            if (count > 0)
            {
                // Duplicate found, show popup and return
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Email with this name already exists!');", true);
                return;
            }
            string insertQuery = @"INSERT INTO Department
    ( DepartmentType, Description, Status,
     CreatedDate, Password, Latitude, Longitude,
     FullAddress, Email,Mobile)
    OUTPUT INSERTED.DepartmentID
    VALUES
    ( @Type, @Desc, @Status,
     @Date, @Password, @Lat, @Long,
     @Address,  @email,@mobile)";

            SqlCommand cmd = new SqlCommand(insertQuery, con);

            // 🔹 ADD ALL PARAMETERS (THIS WAS MISSING)

           // cmd.Parameters.AddWithValue("@Name", txtDepartmentName.Text.Trim());
            cmd.Parameters.AddWithValue("@Type", ddlDepartmentType.SelectedValue);
            cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            string hashedPassword = HashPassword(txtPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", hashedPassword); cmd.Parameters.AddWithValue("@Lat", string.IsNullOrEmpty(hfLatitude.Value) ? (object)DBNull.Value : Convert.ToDecimal(hfLatitude.Value));
            cmd.Parameters.AddWithValue("@Long", string.IsNullOrEmpty(hfLongitude.Value) ? (object)DBNull.Value : Convert.ToDecimal(hfLongitude.Value));
            //cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(Request.Form["txtCity"]) ? "" : Request.Form["txtCity"]);
            //cmd.Parameters.AddWithValue("@State", string.IsNullOrEmpty(Request.Form["txtState"]) ? "" : Request.Form["txtState"]);
            cmd.Parameters.AddWithValue("@Address", address);

            cmd.Parameters.AddWithValue("@email", txtemail.Text.Trim());
            cmd.Parameters.AddWithValue("@mobile", txtmobile.Text.Trim());

            int departmentID = (int)cmd.ExecuteScalar();
            SendDepartmentCredentials(txtemail.Text.Trim(), txtPassword.Text.Trim());
            if (fuPhoto.HasFile)
            {
                string folderPath = Server.MapPath("~/DepartmentPhotos/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string extension = Path.GetExtension(fuPhoto.FileName);
                string photoName = "Dept_" + departmentID + extension; // unique name
                string savePath = Path.Combine(folderPath, photoName);

                fuPhoto.SaveAs(savePath);

                // 3️⃣ Update Department table with photo name (assuming you have a Photo column)
                string updateQuery = "UPDATE Department SET photo=@Photo WHERE DepartmentID=@ID";
                SqlCommand cmdUpdate = new SqlCommand(updateQuery, con);
                cmdUpdate.Parameters.AddWithValue("@Photo", photoName);
                cmdUpdate.Parameters.AddWithValue("@ID", departmentID);
                cmdUpdate.ExecuteNonQuery();
            }
            // Now departmentID contains inserted ID
        }
        ClearFields();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
        "alert('Department Added Successfully!');", true);
    }
    // ================= RESET BUTTON =================
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearFields();
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
    private void SendDepartmentCredentials(string email, string password)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mycollegeproject02@gmail.com", "CivicConnect");

            mail.To.Add(email);
            mail.Subject = "Department Login Credentials";

            mail.Body = "Hello Department,\n\n" +
                        "Your department account has been created successfully.\n\n" +
                        "Login Details:\n" +
                        "Username (Email): " + email + "\n" +
                        "Password: " + password + "\n\n" +
                        "Please login and change your password after first login.\n\n" +
                        "Regards,\nCivicConnect Admin";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "mailError",
            "Swal.fire({icon:'error',title:'Email Error!',text:'Department added but email failed to send.'});", true);
        }
    }
    // Generate Random 6 Digit OTP
    private string GenerateOTP()
    {
        Random rnd = new Random();
        return rnd.Next(100000, 999999).ToString();
    }
    // ================= CLEAR METHOD =================
    private void ClearFields()
    {
       // txtDepartmentName.Text = "";
        ddlDepartmentType.SelectedIndex = 0;
        txtDescription.Text = "";
        ddlStatus.SelectedIndex = 0;
        txtPassword.Text = "";
        txtemail.Text = "";
        txtAddress.Text = "";
        txtmobile.Text = "";
    }
}