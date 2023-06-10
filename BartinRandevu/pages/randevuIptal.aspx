<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="randevuIptal.aspx.cs" Inherits="BartinRandevu.pages.randevuIptal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="overlay">
           <div class="box">
               <div class="baslik">
                   <asp:Label Text="Randevu İptal" Font-Size="X-Large" ForeColor="White" runat="server" />
                </div>
                <div class="inputs">
                     <asp:TextBox runat="server" CssClass="textbox" placeholder="Randevu No" ID="randevuID"/>
                  
                    <asp:Button Text="Randevu İptal" CssClass="button bgRed" runat="server" OnClick="iptal_Click" />
                    <asp:Label Text="" ID="msg" ForeColor="White" runat="server" />
                </div>
            </div>
        </div>
</asp:Content>
