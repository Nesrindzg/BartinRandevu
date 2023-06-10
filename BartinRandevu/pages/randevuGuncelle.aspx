<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="randevuGuncelle.aspx.cs" Inherits="BartinRandevu.pages.randevuGuncelle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="overlay">
        <div class="box">
            <div class="baslik">
                <asp:Label Text="Randevu Güncelle" Font-Size="X-Large" ForeColor="White" runat="server" />
            </div>
            <div class="inputs">
                <asp:TextBox runat="server" CssClass="textbox" placeholder="Randevu No" ID="randevuID" />
                <asp:Button Text="Bul" CssClass="button bgGreen" runat="server" ID="btBul" OnClick="bul_Click" />

                <asp:TextBox runat="server" ID="poliklinik" />
                <asp:TextBox runat="server" ID="doktor" />

                <asp:TextBox runat="server" TextMode="Date" ID="randevuTarih"></asp:TextBox>
                <asp:DropDownList runat="server" ID="randevuSaat" AppendDataBoundItems="true">
                    <asp:ListItem Text="Saat Seçiniz" Value="" />
                </asp:DropDownList>
                <asp:Button Text="Randevu Güncelle" CssClass="button bgGreen" runat="server" ID="btGuncelle" OnClick="guncelle_Click" />
                <asp:Label Text="" ID="msg" Font-Size="Large" ForeColor="White" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
