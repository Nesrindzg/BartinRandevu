<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="randevuAl.aspx.cs" Inherits="BartinRandevu.pages.randevuAl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="overlay">
        <div class="box">
            <div class="baslik">
                <asp:Label Text="Randevu Al" Font-Size="X-Large" ForeColor="White" runat="server" />
            </div>
            <div class="inputs">
                <asp:DropDownList ID="poliklinikler" runat="server" AutoPostBack="True" OnSelectedIndexChanged="poliklinikler_SelectedIndexChanged">
                    <asp:ListItem Value="-1">Poliklinik Seçiniz</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="doktorlar" runat="server">
                    <asp:ListItem Value="-1">Doktor Seçiniz</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox runat="server" TextMode="Date" ID="randevuTarih" />
                <asp:DropDownList runat="server" ID="randevuSaat" AppendDataBoundItems="true">
                    <asp:ListItem Text="Saat Seçiniz" Value="" />
                </asp:DropDownList>
                <asp:Button Text="Randevuyu Onayla" CssClass="button bgGreen" ID="btRandevuKayit" runat="server" OnClick="btRandevuKayit_Click" />
                <asp:Label Text="" ForeColor="White" Font-Size="large" ID="msg" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
