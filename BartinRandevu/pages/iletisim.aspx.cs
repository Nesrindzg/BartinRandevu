using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Data.SqlClient;

namespace BartinRandevu.pages
{
    public partial class iletisim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btGonder_Click(object sender, EventArgs e)
        {
            try
            {
                if (mesaj.Text!=""||konu.Text!="")
                {
                    MailMessage message = new MailMessage();
                    message.To.Add("bartinhastanesi@gmail.com");
                    message.From = new MailAddress(Session["hastaMail"].ToString(), Session["hastaAdiSoyadi"].ToString());
                    message.Subject = "Bize Ulaşın";
                    message.IsBodyHtml = true;
                    message.Body = "Gönderen: " + Session["hastaAdiSoyadi"] + "<br> Mail Adresi: " + Session["hastaMail"] + "<br><br> Konu: " + konu.Text + "<br> Mesaj: " + mesaj.Text;

                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "smtp.gmail.com";
                    smtp.Credentials = new System.Net.NetworkCredential("bartinhastanesi@gmail.com", "wdggfvhhltgismnw");
                    smtp.Port = 587;
                    smtp.EnableSsl = true;
                    smtp.Send(message);
                    msg.Text = "Geri bildiriminiz için teşekkürler.";
                }
                else
                {
                    msg.Text = "Tüm Alanları Doldurunuz.";
                }
            }
            catch (Exception hata)
            {
                msg.Text = "Gönderilemedi.";
            }
        }
    }
}