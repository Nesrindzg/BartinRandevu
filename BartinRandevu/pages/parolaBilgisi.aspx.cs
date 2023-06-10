using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace BartinRandevu.pages
{
    public partial class parolaBilgisi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btGonder_Click(object sender, EventArgs e)
        {
            SqlConnection baglanti = new SqlConnection();
            string strcon = ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString;
            baglanti.ConnectionString = strcon;
            baglanti.Open();

            SqlCommand komut = new SqlCommand("sp_HastaTCveMailKontrol", baglanti);
            komut.CommandType = CommandType.StoredProcedure;
            komut.Parameters.AddWithValue("@hastaTC", hastaTC.Text.Trim());
            komut.Parameters.AddWithValue("@hastaMail", hastaMail.Text.Trim());

            SqlDataReader oku = komut.ExecuteReader();

            if (oku.Read())
            {
                string hastaSifre = oku["hastaSifre"].ToString();
                string adSoyad = oku["adSoyad"].ToString();

                MailMessage message = new MailMessage();
                message.To.Add(hastaMail.Text.Trim());
                message.From = new MailAddress("bartinhastanesi@gmail.com", "Bartın Hastanesi");
                message.Subject = "Şifre Bilgisi";
                message.IsBodyHtml = true;
                message.Body = "Sayın, " + adSoyad + "<br>Sistemde Kayıtlı Şifreniz: " + hastaSifre;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Credentials = new System.Net.NetworkCredential("bartinhastanesi@gmail.com", "wdggfvhhltgismnw");
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.Send(message);
                msg.Text = "Şifre Bilginiz E-Posta Adresinize Gönderildi";
                Response.AddHeader("Refresh", "2;url=hastaGiris.aspx");
            }
            else
            {
                msg.Text = "T.C. Kimlik No veya E-Posta Hatalı.";
            }

            oku.Close();
            baglanti.Close();
            
        }

        protected void btGeriDon_Click(object sender, EventArgs e)
        {
            Response.Redirect("hastaGiris.aspx");
        }
    }
}
