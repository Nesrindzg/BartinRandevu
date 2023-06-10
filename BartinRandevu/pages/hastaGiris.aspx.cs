using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BartinRandevu.pages
{
    public partial class hastaGiris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        protected void btGiris_Click(object sender, EventArgs e)
        {           
            if (hastaTC.Text=="" || hastaSifre.Text.Equals(""))
            {
                msg.Text = "Lütfen Tüm Alanları Doldurunuz.";
            }
            else
            {
                SqlConnection baglanti = new SqlConnection();
                string strcon = ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString;
                baglanti.ConnectionString = strcon;
                baglanti.Open();
                SqlCommand komut = new SqlCommand("sp_HastaKontrol", baglanti);
                komut.CommandType = CommandType.StoredProcedure;
                komut.Parameters.Add(new SqlParameter("@hastaTC", SqlDbType.VarChar)).Value = hastaTC.Text.ToString().Trim();
                komut.Parameters.Add(new SqlParameter("@hastaSifre", SqlDbType.VarChar)).Value = hastaSifre.Text.ToString().Trim();

                // Diğer işlemler...

                SqlDataReader oku = komut.ExecuteReader();

                if (oku.Read())
                {
                    Session["hastaID"] = oku["hastaID"].ToString();
                    Session["hastaMail"] = oku["hastaMail"].ToString();
                    Session["hastaAdiSoyadi"] = oku["hastaAdi"].ToString() + " " + oku["hastaSoyadi"].ToString();

                    msg.Text = "Giriş Başarılı.";
                    Response.AddHeader("Refresh", "1;url=randevuAl.aspx");
                }
                else
                {
                    msg.Text = "T.C. Kimlik Numarası veya Parola Hatalı.";
                }

                oku.Close();
                baglanti.Close();
            }
        }

        protected void btKayit_Click(object sender, EventArgs e)
        {
            Response.Redirect("hastaKayit.aspx");
        }
    }
}