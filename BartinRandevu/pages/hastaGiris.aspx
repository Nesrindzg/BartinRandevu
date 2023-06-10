<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hastaGiris.aspx.cs" Inherits="BartinRandevu.pages.hastaGiris" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Bartın Hastanesi Randevu Sistemi</title>
    <link href="../css/master.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="content" style="width:100%">
             <div class="overlay">
               <div class="box">
                   <div class="baslik">
                       <asp:Label Text="Hasta Girişi" Font-Size="X-Large" ForeColor="White" runat="server" />
                    </div>
                    <div class="inputs">
                        <asp:TextBox runat="server" CssClass="textbox" placeholder="T.C. Kimlik No" MaxLength="11" ID="hastaTC" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);"/>
                        <asp:TextBox runat="server" CssClass="textbox" placeholder="Parola" TextMode="Password" ID="hastaSifre"/>
                        <span><a href="parolaBilgisi.aspx">Parolamı Unuttum</a></span>
                        <asp:Button Text="Giriş Yap" CssClass="button bgGreen" runat="server" ID="btGiris" OnClick="btGiris_Click"/>
                        <asp:Button Text="Kayıt Ol" CssClass="button bgRed" runat="server" ID="btKayit" OnClick="btKayit_Click"/>
                        <asp:Label Text="" ID="msg" ForeColor="White" runat="server" />
                    </div>      
                </div>
            </div>
        </div>
    </form>
</body>
</html>
