using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for BasicCode
/// </summary>
public class BasicCode
{

    public void SendSms(string senderid, string mob, string msg)
    {
        // New API
        //Your authentication key
        string authKey = "254664AbDmunYeD5c2cb046";
        //Multiple mobiles numbers separated by comma
        string mobileNumber = "91" + mob;
        //Sender ID,While using route4 sender id should be 6 characters long.
        string senderId = senderid;
        //Your message to send, Add URL encoding here.
        string message = HttpUtility.UrlEncode(msg);

        //Prepare you post parameters
        StringBuilder sbPostData = new StringBuilder();
        sbPostData.AppendFormat("authkey={0}", authKey);
        sbPostData.AppendFormat("&mobiles={0}", mobileNumber);
        sbPostData.AppendFormat("&message={0}", message);
        sbPostData.AppendFormat("&sender={0}", senderId);
        sbPostData.AppendFormat("&route={0}", "4");

        try
        {
            //Call Send SMS API

            string sendSMSUri = "http://sms.litsbros.com/api/sendhttp.php";
            //Create HTTPWebrequest
            HttpWebRequest httpWReq = (HttpWebRequest)WebRequest.Create(sendSMSUri);
            //Prepare and Add URL Encoded data
            UTF8Encoding encoding = new UTF8Encoding();
            byte[] data = encoding.GetBytes(sbPostData.ToString());
            //Specify post method
            httpWReq.Method = "POST";
            httpWReq.ContentType = "application/x-www-form-urlencoded";
            httpWReq.ContentLength = data.Length;
            using (Stream stream = httpWReq.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            //Get the response
            HttpWebResponse response = (HttpWebResponse)httpWReq.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string responseString = reader.ReadToEnd();

            //Close the response
            reader.Close();
            response.Close();
        }
        catch (SystemException ex)
        {

        }
    }

    public void send(string to, string subject, string body)
    {
        //StreamReader reader = new StreamReader(Microsoft.SqlServer.Server.MapPath("~/MailBody.htm"));
        //string readFile = reader.ReadToEnd();
        string myString = "";
        //  myString = readFile;
        //myString = myString.Replace("$$Admin$$", "Suresh Dasari");
        //myString = myString.Replace("$$CompanyName$$", "Dasari Group");
        //myString = myString.Replace("$$Email$$", "suresh@gmail.com");


        //string to = Session["username"].ToString();
        string from = "mycollegeproject02@gmail.com";
        //string subject = "Result";
        //string body = "YOUR RESULT IS  TOTAL MARKS : 20 OBTAINED MARKS :'" + lblmarks.Text + "'";
        using (MailMessage mm = new MailMessage(from, to))
        {
            mm.Subject = subject;
            mm.Body = body;
            //if (fuAttachment.HasFile)
            //{
            //    string FileName = Path.GetFileName(fuAttachment.PostedFile.FileName);
            //    mm.Attachments.Add(new Attachment(fuAttachment.PostedFile.InputStream, FileName));
            //}
            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("onlineadmissiongvish@gmail.com", "9503351933");
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
            //ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent.');", true);
        }
    }

    public string createPassword()
    {
        string alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        string small_alphabets = "abcdefghijklmnopqrstuvwxyz";
        string numbers = "1234567890";

        string characters = numbers;
        characters += alphabets + small_alphabets + numbers;
        int length = 6;
        string otp = string.Empty;
        for (int i = 0; i < length; i++)
        {
            string character = string.Empty;
            do
            {
                int index = new Random().Next(0, characters.Length);
                character = characters.ToCharArray()[index].ToString();
            } while (otp.IndexOf(character) != -1);
            otp += character;
        }

        return otp;

    }
}