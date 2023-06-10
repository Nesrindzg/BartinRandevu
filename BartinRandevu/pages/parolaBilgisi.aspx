<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="parolaBilgisi.aspx.cs" Inherits="BartinRandevu.pages.parolaBilgisi" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../css/master.css" rel="stylesheet" />
    <title>Parola Bilgisi Gönder</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content w-100" style="width:100%">
             <div class="overlay">
               <div class="box">
                   <div class="baslik">
                       <asp:Label Text="Parola Bilgisi Gönder" Font-Size="X-Large" ForeColor="White" runat="server" />
                    </div>
                    <div class="inputs">
                        <asp:TextBox runat="server" CssClass="textbox" placeholder="T.C. Kimlik No" MaxLength="11" ID="hastaTC" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);"/>
                        <asp:TextBox runat="server" CssClass="textbox" placeholder="E-Posta"  ID="hastaMail" TextMode="Email" />
                        <asp:Button Text="Gönder" CssClass="button bgGreen" runat="server" OnClick="btGonder_Click" ID="Button1"/>
                        <asp:Button Text="Geri Dön" CssClass="button bgRed" runat="server" ID="btGeriDon" OnClick="btGeriDon_Click"/>
                        <asp:Label Text="" ID="msg" ForeColor="White" runat="server" />
                    </div>      
                </div>
            </div>
        </div>
    </form>
</body>
</html>
