<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="randevuSorgulama.aspx.cs" Inherits="BartinRandevu.pages.randevuSorgulama" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="overlay">
           <div class="box" style="width:65%">
               <div class="baslik">
                   <asp:Label Text="Randevu Sorgulama" Font-Size="X-Large" ForeColor="White" runat="server" />
                </div>
               <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
               <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" style="top: 0px; width: 100%">
                   <LocalReport ReportPath="Raporlar\Report2.rdlc">
                       <DataSources>
                           <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                       </DataSources>
                   </LocalReport>
               </rsweb:ReportViewer>
               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BartinRandevuConnectionString %>" SelectCommand="sp_HastaRandevulariListele" SelectCommandType="StoredProcedure">
                   <SelectParameters>
                       <asp:SessionParameter Name="hastaID" SessionField="hastaID" Type="Int32" />
                   </SelectParameters>
               </asp:SqlDataSource>
            </div>
        </div>
</asp:Content>
