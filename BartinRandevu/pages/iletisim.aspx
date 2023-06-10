<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="BartinRandevu.pages.iletisim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="overlay">
           <div class="box">
               <div class="baslik">
                   <asp:Label Text="Bize Ulaşın" Font-Size="X-Large" ForeColor="White" runat="server" />
                </div>
                <div class="inputs">
                    <asp:TextBox runat="server" CssClass="textbox" placeholder="Konu" ID="konu" />
                    <asp:TextBox runat="server" CssClass="textbox" placeholder="Lütfen Mesajınızı Buraya Yazın" TextMode="MultiLine" ID="mesaj" Rows="5"/>                
                    <asp:Button Text="Gönder" CssClass="button bgGreen" runat="server" ID="btGonder" OnClick="btGonder_Click" />
                    <asp:Label Text="" ID="msg" ForeColor="White" runat="server" />
                </div>
            </div>
        </div>
</asp:Content>
