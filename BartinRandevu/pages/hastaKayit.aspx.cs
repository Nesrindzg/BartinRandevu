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
    public partial class hastaKayit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btKayıt_Click(object sender, EventArgs e)
        {
            if (hastaAdi.Text == ""||hastaSoyadi.Text==""||hastaTC.Text==""||hastaTel.Text==""||hastaDT.Text==""||hastaMail.Text==""||hastaSifre.Text==""||cinsiyet.SelectedValue.Equals(""))
            {
                msg.Text = "Lütfen Tüm Alanları Doldurunuz.";
            }
            else
            {
                SqlConnection baglanti = new SqlConnection();
                string strcon = ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString;
                baglanti.ConnectionString = strcon;
                baglanti.Open();
                SqlCommand komut = new SqlCommand("sp_HastaEkle", baglanti);
                komut.CommandType = CommandType.StoredProcedure;
                komut.Parameters.AddWithValue("@hastaAdi", hastaAdi.Text.Trim());
                komut.Parameters.AddWithValue("@hastaSoyadi", hastaSoyadi.Text.Trim());
                komut.Parameters.AddWithValue("@hastaCinsiyeti", cinsiyet.SelectedValue);
                komut.Parameters.AddWithValue("@hastaTC", hastaTC.Text.Trim());
                komut.Parameters.AddWithValue("@hastaDTarihi", DateTime.Parse(hastaDT.Text.Trim()));
                komut.Parameters.AddWithValue("@hastaTel", hastaTel.Text.Trim());
                komut.Parameters.AddWithValue("@hastaMail", hastaMail.Text.Trim());
                komut.Parameters.AddWithValue("@hastaSifre", hastaSifre.Text.Trim());

                SqlParameter messageParam = new SqlParameter("@Message", SqlDbType.VarChar, 50);
                messageParam.Direction = ParameterDirection.Output;
                komut.Parameters.Add(messageParam);

                komut.ExecuteNonQuery();

                string message = komut.Parameters["@Message"].Value.ToString();
                msg.Text = message;

                baglanti.Close();
           }
        }

        protected void btGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("hastaGiris.aspx");
        }
    }
}