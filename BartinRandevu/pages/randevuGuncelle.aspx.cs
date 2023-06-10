using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BartinRandevu.pages
{
    public partial class randevuGuncelle : System.Web.UI.Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            poliklinik.Visible = false;
            doktor.Visible = false;
            randevuTarih.Visible = false;
            randevuSaat.Visible = false;
            btGuncelle.Visible = false;

            if (!IsPostBack)
            {
                SetTimeIntervals();
            }
        }

        private void SetTimeIntervals()
        {
            DateTime now = DateTime.Now;
            DateTime startTime = new DateTime(now.Year, now.Month, now.Day, 08, 0, 0);
            DateTime endTime = new DateTime(now.Year, now.Month, now.Day, 17, 0, 0);
            TimeSpan interval = TimeSpan.FromMinutes(10);

            while (startTime <= endTime)
            {
                string formattedTime = startTime.ToString("HH:mm");
                randevuSaat.Items.Add(new ListItem(formattedTime, formattedTime));
                startTime = startTime.Add(interval);
            }
        }
        protected void bul_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            string sqlBul = "sp_BulRandevu";
            SqlCommand cmd = new SqlCommand(sqlBul, baglanti);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@randevuID", randevuID.Text);
            cmd.Parameters.AddWithValue("@hastaID", Session["hastaID"].ToString());
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                poliklinik.Visible = true;
                doktor.Visible = true;
                randevuTarih.Visible = true;
                randevuSaat.Visible = true;
                btGuncelle.Visible = true;

                poliklinik.Enabled = false;
                doktor.Enabled = false;

                btBul.Visible = false;
                randevuID.Visible = false;

                poliklinik.Text = rdr["poliklinikAdi"].ToString();
                doktor.Text = rdr["doktorAdi"].ToString() + " " + rdr["doktorSoyadi"].ToString();
            }
            else
            {
                msg.Text = "Kayıt Yok";
            }

            rdr.Close();
            baglanti.Close();
        }

        protected void guncelle_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            string spGuncelle = "sp_GuncelleRandevu";

            if (randevuSaat.Text != "" && randevuTarih.Text != "")
            {
                SqlCommand cmd = new SqlCommand(spGuncelle, baglanti);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tarih", randevuTarih.Text);
                cmd.Parameters.AddWithValue("@saat", randevuSaat.Text);
                cmd.Parameters.AddWithValue("@randevuID", randevuID.Text);
                cmd.ExecuteNonQuery();
                mailGonder(poliklinik.Text + " Polikliniği, Doktor " + doktor.Text + " ile " + randevuTarih.Text + " Tarihinde Saat " + randevuSaat.Text + "'da " + randevuID.Text + " Nolu Randevu Kaydınız Güncellenmiştir.<br>Sağlıklı Günler Dileriz.");
                msg.Text = "Randevu Güncellendi.";
                randevuID.Visible = true;
                btBul.Visible = true;
            }
            else
            {
                msg.Text = "Güncelleme Başarısız.";
            }
        }
        protected void mailGonder(String mesaj)
        {
            MailMessage message = new MailMessage();
            message.To.Add(Session["hastaMail"].ToString());
            message.From = new MailAddress("bartinhastanesi@gmail.com", "Bartın Hastanesi");
            message.Subject = "Randevu Bilgisi";
            message.IsBodyHtml = true;
            message.Body = "Sayın " + Session["hastaAdiSoyadi"] + ",<br> Randevu Bilgileriniz Aşağıdaki Şekilde Güncellenmiştir.<br>" + mesaj;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Credentials = new System.Net.NetworkCredential("bartinhastanesi@gmail.com", "wdggfvhhltgismnw");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(message);
        }
    }
}