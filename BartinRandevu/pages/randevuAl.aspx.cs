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
    public partial class randevuAl : System.Web.UI.Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                baglanti.Open();

                SqlCommand cmdPol = new SqlCommand("sp_PoliklinikleriGetir", baglanti);
                cmdPol.CommandType = CommandType.StoredProcedure;
                SqlDataReader readerPol = cmdPol.ExecuteReader();

                while (readerPol.Read())
                {
                    poliklinikler.Items.Add(readerPol["poliklinikAdi"].ToString());
                }

                readerPol.Close();
                baglanti.Close();

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
        protected void poliklinikler_SelectedIndexChanged(object sender, EventArgs e)
        {
            string poliklinikAdi = poliklinikler.SelectedValue.Trim(); // Poliklinik adını alın

            SqlCommand komut = new SqlCommand("sp_PoliklinikDoktoruGetir", baglanti);
                
            komut.CommandType = CommandType.StoredProcedure;
            komut.Parameters.Add("@poliklinikAdi", SqlDbType.VarChar).Value = poliklinikAdi;

            baglanti.Open();
            using (SqlDataReader reader = komut.ExecuteReader())
            {
                DataTable dt = new DataTable();
                dt.Load(reader);

                doktorlar.DataTextField = "doktorAdSoyad";
                doktorlar.DataValueField = "doktorID";
                doktorlar.DataSource = dt;
                doktorlar.DataBind();
            }
        }

        protected void mailGonder(String mesaj)
        {
            MailMessage message = new MailMessage();
            message.To.Add(Session["hastaMail"].ToString());
            message.From = new MailAddress("bartinhastanesi@gmail.com", "Bartın Hastanesi");
            message.Subject = "Randevu Bilgisi";
            message.IsBodyHtml = true;
            message.Body = "Sayın "+Session["hastaAdiSoyadi"]+",<br> Randevu Bilgileriniz Aşağıda Belirtilmiştir. <br>"+mesaj;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Credentials = new System.Net.NetworkCredential("bartinhastanesi@gmail.com", "wdggfvhhltgismnw");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(message);
        }
        protected void btRandevuKayit_Click(object sender, EventArgs e)
        {
            if (poliklinikler.SelectedValue.Equals("") || doktorlar.SelectedValue.Equals("") || randevuTarih.Text == "" || randevuSaat.Text == "")
            {
                msg.Text = "Lütfen Tüm Alanları Doldurunuz.";
            }
            else
            {
                baglanti.Open();

                // Randevu kayıtlarını kontrol etmek için saklı yordam
                SqlCommand kontrol = new SqlCommand("sp_KontrolRandevu", baglanti);
                kontrol.CommandType = CommandType.StoredProcedure;
                kontrol.Parameters.AddWithValue("@doktorNo", doktorlar.SelectedValue);
                kontrol.Parameters.AddWithValue("@hastaNo", Session["hastaID"]);
                kontrol.Parameters.AddWithValue("@randevuTarihi", randevuTarih.Text.Trim());
                kontrol.Parameters.AddWithValue("@randevuSaati", randevuSaat.Text.Trim());

                SqlDataReader reader = kontrol.ExecuteReader();

                if (reader.Read())
                {
                    int doktorRandevuCount = (int)reader["doktorRandevuCount"];
                    int hastaRandevuCount = (int)reader["hastaRandevuCount"];

                    if (doktorRandevuCount == 0 && hastaRandevuCount == 0)
                    {
                        reader.Close();
                        // Yeni randevu kaydını eklemek için saklı yordam
                        SqlCommand ekle = new SqlCommand("sp_EkleRandevu", baglanti);
                        ekle.CommandType = CommandType.StoredProcedure;
                        ekle.Parameters.AddWithValue("@hastaNo", Session["hastaID"]);
                        ekle.Parameters.AddWithValue("@doktorNo", doktorlar.SelectedValue);
                        ekle.Parameters.AddWithValue("@randevuTarihi", randevuTarih.Text.Trim());
                        ekle.Parameters.AddWithValue("@randevuSaati", randevuSaat.Text.Trim());
                        int randevuID = Convert.ToInt32(ekle.ExecuteScalar());
                        Session["lastID"] = randevuID.ToString();

                        mailGonder(poliklinikler.Text + " Polikliniği, Doktor " + doktorlar.SelectedItem.Text + " ile " + randevuTarih.Text + " Tarihinde Saat " + randevuSaat.Text + "'da " + Session["lastID"] + " Nolu Randevu Kaydınız Yapılmıştır.<br>Sağlıklı Günler Dileriz.");

                        msg.Text = "Randevu Kaydınız Oluşturulmuş Olup E-Posta Adresinize Gönderilmiştir.";
                    }
                    else
                    {
                        msg.Text = "Randevu Saati Uygun Değil.";
                    }
                }
                baglanti.Close();
            }
        }
    }
}