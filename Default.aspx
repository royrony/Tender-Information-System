<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tender._Default"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 10px;">
        <div class="row">
            <div class="col links" style="height: 58px; width: 261px;">
                <img src="/Content/image/rdot.gif" />
                <a href="/add_tender.aspx">Submission of Tender Notice by Department/Bodies</a>
            </div>
            <div class="col" style="height: 58px; width: 261px;">
                <img src="/Content/image/rdot.gif" />
                <a href="/vendor_reg.aspx">Register for Suppliers/Vendors</a>
            </div>
            <div class="col" style="height: 58px; width: 121px;">
                <img src="/Content/image/rdot.gif" />
                <a href="#">Statistics</a>
            </div>
            <div class="col" style="height: 58px; width: 261px;">
                <img src="/Content/image/rdot.gif" />
                <a href="#">Circulars/Office orders issued by Delhi Govt.</a>
            </div>
            <div class="col" style="height: 58px; width: 261px;">
                <img src="/Content/image/rdot.gif" />
                <a href="#">Guidelines Issued by Central Vigilance Commission (CVC)</a>
            </div>
        </div>
    </div>
    <br />
    <br />
    <h4 class="font-weight-bold text-primary" style="text-align: center">Welcome to the <b>Tender Notice Information System</b> of Govt of Delhi</h4>
    <div class="container">
        <div class="row">
            <div class="col-xl-4">
                <h6><b>For Departments/Govt Bodies</b></h6>
                <p>The Tender Notice goes directly to the website</p>
                <p>No More follow up with the I.T Department or NIC</p>
                <p>Upload tender document in MS Word format or Pdf format</p>
            </div>
            <div class="col-xl-2">
                <img src="/Content/image/tender1.jpg" />
            </div>
            <div class="col-xl-4">
                <h6><b>For Suppliers/Vendors</b></h6>
                <p>Register free to get automatic email notification on new tenders</p>
                <p>You can download tender documents ,if department has kept the same</p>
                <p>Scroll through the notices based on filters. You can also sort on dates</p>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" >
         <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddl2" EventName="SelectedIndexChanged" />
        </Triggers>
        <ContentTemplate>
            <div class="container" style="border: 2px solid black; box-sizing: border-box; border-radius: 20px; padding: 20px">
                <p style="font-size: 18px; font-weight: bold; margin-left: 20px">Filter By</p>
                <div class="row">
                    <div class="col">
                        <p>Department</p>
                        <asp:DropDownList ID="ddl1" runat="server" data-dropup-auto="false" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker" OnSelectedIndexChanged="ddl1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <div class="col">
                        <p>Category</p>
                        <asp:DropDownList ID="ddl2" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddl2_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Goods" Value="tender_goods"></asp:ListItem>
                            <asp:ListItem Text="Services" Value="tender_services"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col">
                        <p>Subject/Item</p>
                        <asp:DropDownList ID="ddl3" runat="server" data-dropup-auto="false" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker" OnSelectedIndexChanged="ddl3_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </ContentTemplate>
         <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddl2" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>



    <asp:UpdatePanel ID="up1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddl1" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddl2" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddl2" EventName="SelectedIndexChanged" />
        </Triggers>
        <ContentTemplate>
            <div class="mt-2 table-responsive">
                <asp:GridView ID="gv1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped" AllowPaging="true" PageSize="2" OnPageIndexChanging="gv1_PageIndexChanging" OnSelectedIndexChanged="gv1_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField HeaderText="Tender No.">
                            <ItemTemplate><%#Eval("tender_id")%></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Work Name">
                            <ItemTemplate><%#Eval("work_name")%></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Issue Date">
                            <ItemTemplate><%#Eval("start_dt_tender_doc")%></ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Closing Date">
                            <ItemTemplate><%#Eval("end_dt_tender_doc")%></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="View Details">
                            <ItemTemplate><a href="<%#"tender_details.aspx?tenderno="+DataBinder.Eval(Container.DataItem,"tender_id") %>">View</a></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
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
            $('[id*=ddl1]').selectpicker();
            $('[id*=ddl3]').selectpicker();
        };
    </script>
</asp:Content>
