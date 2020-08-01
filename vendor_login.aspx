<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="vendor_login.aspx.cs" Inherits="Tender.vendor_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="container" style="border: 2px solid black; box-sizing: border-box; border-radius: 20px; padding: 20px">
                    <p style="font-size: 18px; font-weight: bold; margin-left: 20px">Filter By</p>
                    <div class="row">
                        <div class="col">
                            <p>Department</p>
                            <asp:DropDownList ID="ddl1" runat="server" data-dropup-auto="false" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker"></asp:DropDownList>
                        </div>
                        <div class="col">
                            <p>Category</p>
                            <asp:DropDownList ID="ddl2" runat="server" CssClass="form-control"  OnSelectedIndexChanged="ddl2_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Goods" Value="tender_goods"></asp:ListItem>
                                <asp:ListItem Text="Services" Value="tender_services"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <p>Subject/Item</p>
                            <asp:DropDownList ID="ddl3" runat="server" data-dropup-auto="false" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddl2" EventName="SelectedIndexChanged" />
                            </Triggers>
        </asp:UpdatePanel>
    </div>
   <script type="text/javascript">
       $(function () {
           ApplySelectPicker();
       });
       //On UpdatePanel Refresh
       var prm = Sys.WebForms.PageRequestManager.getInstance();
       if (prm != null) {
           prm.add_endRequest(function (sender, e) {
               if (sender._postBackSettings.panelsToUpdate != null) {
                   ApplySelectPicker();
               }
           });
       };
       function ApplySelectPicker() {
           $('[id*=ddl3]').selectpicker();
           $('[id*=ddl1]').selectpicker();
       };
    </script>
</asp:Content>
