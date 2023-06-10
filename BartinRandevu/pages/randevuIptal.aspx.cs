using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BartinRandevu.pages
{
    public partial class randevuIptal : System.Web.UI.Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["BartinRandevuConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void iptal_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            string spSil = "sp_SilRandevu";

            SqlCommand cmd = new SqlCommand(spSil, baglanti);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@randevuID", randevuID.Text.Trim());
            cmd.Parameters.AddWithValue("@hastaID", Session["hastaID"]);
            int sonuc = cmd.ExecuteNonQuery();

            if (sonuc == 1)
            {
                msg.Text = "Randevunuz İptal Edilmiştir.";
            }
            else
            {
                msg.Text = "Geçersiz Veya Hatalı Randevu Numarası.";
            }
        }
    }
}