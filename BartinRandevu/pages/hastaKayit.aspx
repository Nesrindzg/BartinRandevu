<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hastaKayit.aspx.cs" Inherits="BartinRandevu.pages.hastaKayit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Hasta Kayıt Sayfası</title>
    <link href="../css/master.css" rel="stylesheet" />
    <style>
        #cinsiyet{
            width:80%;
            display:flex;
            justify-content:space-around;
        }
        #cinsiyet > *{
            float:left;
            color:white;
            font-size:1.2rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content" style="width:100%">
             <div class="overlay">
               <div class="box">
                   <div class="baslik">
                       <asp:Label Text="Hasta Kayıt" Font-Size="X-Large" ForeColor="White" runat="server" />
                    </div>
                    <div class="inputs">
                        <asp:TextBox runat="server" placeholder="Adınız" ID="hastaAdi"/>
                        <asp:TextBox runat="server" placeholder="Soyadınız" ID="hastaSoyadi"/>
                        <asp:TextBox runat="server" placeholder="T.C. Kimlik No" MaxLength="11" ID="hastaTC" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);"/>
                        <asp:TextBox runat="server" TextMode="Date" ID="hastaDT" ToolTip="Doğum Tarihiniz" />
                        <asp:TextBox runat="server" placeholder="Telefon Numaranız" TextMode="Phone" ID="hastaTel" MaxLength="11" />
                        <asp:TextBox runat="server" placeholder="E-Posta Adresiniz" TextMode="Email" ID="hastaMail"/>
                        <asp:TextBox runat="server" placeholder="Parola" TextMode="Password" ID="hastaSifre"/>
                        <asp:RadioButtonList ID="cinsiyet" runat="server" RepeatLayout="Flow">
                            <asp:ListItem Value="Kadın">Kadın</asp:ListItem>
                            <asp:ListItem Value="Erkek">Erkek</asp:ListItem>
                        </asp:RadioButtonList>
                        
                        <asp:Button Text="Kaydı Onayla" CssClass="button bgGreen" runat="server" ID="Button1" OnClick="btKayıt_Click"/>
                        <asp:Button Text="Geri Dön" CssClass="button bgRed" runat="server" ID="btGeri" OnClick="btGeri_Click"/>
                        <asp:Label Text="" ID="msg" ForeColor="White" runat="server" />
                    </div>      
                </div>
            </div>
        </div>
    </form>
</body>
</html>
