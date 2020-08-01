<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="add_tender.aspx.cs" Inherits="Tender.add_tender" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="Content/bootstrap-datetimepicker.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <link href="Content/jquery-ui.structure.css" rel="stylesheet" />
    <link href="Content/jquery-ui.theme.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="infor">
        <div class="row form-inline required">
            <div class="col-3 form-inline">
                <p class="align-left control-label">Name of Work:</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="name" runat="server" CausesValidation="true" ValidationGroup="vg1" required="true" CssClass="form-control" placeholder="e.g. Construction of New School Building" TextMode="SingleLine" autofocus="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="name" ValidationGroup="vg1" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="container ">
                <div class="row form-inline required">
                    <div class="col-3 form-inline">
                        <p class="align-left control-label">Address for Tender Process:</p>
                    </div>
                    <div class="col-3 form-inline">
                        <label>Street&nbsp;&nbsp;&nbsp;</label>
                        <asp:TextBox ID="street" TextMode="SingleLine" CssClass="form-control" ValidationGroup="vg2" placeholder="e.g. 7th Avenue Street" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv2" runat="server" ValidationGroup="vg2" ControlToValidate="street" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="ml-2 col-3 form-inline">
                        <label>City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <asp:TextBox ID="city" TextMode="SingleLine" CssClass="form-control" ValidationGroup="vg2" placeholder="e.g. Kolkata" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv3" runat="server" ValidationGroup="vg2" ControlToValidate="city" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row form-inline required">
                    <div class="col-3"></div>
                    <div class="col-3 form-inline">
                        <label>State&nbsp;&nbsp;&nbsp;</label>
                        <asp:TextBox ID="state" TextMode="SingleLine" CssClass="form-control" ValidationGroup="vg2" placeholder="e.g. West Bengal" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv4" runat="server" ValidationGroup="vg2" ControlToValidate="state" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="ml-2 col-3 form-inline">
                        <label>Pincode</label>
                        <asp:TextBox ID="pincode" TextMode="SingleLine" CssClass="form-control" ValidationGroup="vg2" placeholder="e.g. 700700" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv5" runat="server" ValidationGroup="vg2" ControlToValidate="pincode" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev1" runat="server" ValidationGroup="vg2" ControlToValidate="pincode" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationExpression="^\d{6}$" Display="Dynamic" ErrorMessage="Should be 6 digits" SetFocusOnError="true"></asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>
        </div>

        <asp:UpdatePanel runat="server" ID="up1" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="mt-2 row form-inline required">
                    <div class="col-3">
                        <p class="align-left control-label">Subject:</p>
                    </div>
                    <div class="col-3">
                        <asp:RadioButtonList ID="rb1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" TextAlign="Right" CellPadding="10" CellSpacing="10" Width="30" AutoPostBack="true" OnSelectedIndexChanged="rb1_SelectedIndexChanged">
                            <asp:ListItem Text="Goods" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Services" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Both" Value="2"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rfv6" runat="server" ValidationGroup="vg3" ControlToValidate="rb1" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <div class="container">
                        <div class="row">
                            <div class="col-3"></div>
                            <div class="col-3" id="id1" runat="server">
                                <label>Goods</label>
                                <asp:DropDownList ID="ddl1" runat="server" data-dropup-auto="false" Width="200" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker"></asp:DropDownList>
                            </div>
                            <div class="col-3" id="id2" runat="server">
                                <label>Services</label>
                                <asp:DropDownList ID="ddl2" runat="server" data-dropup-auto="false" data-live-search="true" data-live-search-style="startsWith" CssClass="form-control selectpicker"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left">
                    Earnest Money Deposit: 
                </p>
            </div>
            <div class="col-3 form-inline">
                <label>For Goods</label>
                <asp:TextBox ID="goods_emd" TextMode="SingleLine" CssClass="form-control" placeholder="(in Rs.)" runat="server"></asp:TextBox>
            </div>
            <div class="ml-2 col-3 form-inline">
                <label>For Services</label>
                <asp:TextBox ID="services_emd" TextMode="SingleLine" CssClass="form-control" placeholder="(in Rs.)" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <p class="align-left control-label">
                    Estimated Cost of Project:
                </p>
            </div>
            <div class="col-3 form-inline">
                <asp:TextBox ID="ecp" TextMode="SingleLine" CssClass="form-control" placeholder="(in Rs.)" required="true" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv7" runat="server" ValidationGroup="vg4" ControlToValidate="ecp" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <p class="align-left control-label">
                    Project Duration:
                </p>
            </div>
            <div class="col-3 form-inline">
                <label>Years&nbsp;&nbsp;</label>
                <asp:TextBox ID="years" TextMode="SingleLine" CssClass="form-control" placeholder="No. of years (Enter 0 for year < 1)" required="true" runat="server"></asp:TextBox>
            </div>
            <div class="ml-2 col-3 form-inline">
                <label>Months</label>
                <asp:TextBox ID="months" TextMode="SingleLine" CssClass="form-control" placeholder="No. of months" required="true" runat="server"></asp:TextBox>
            </div>


        </div>
        <div class="mt-2 row form-inline required">
            <div class="container">
                <div class="row form-inline required">
                    <div class="col-3 form-inline">
                        <p class="align-left control-label">
                            Contact Person:
                        </p>
                    </div>
                    <div class="col-3 form-inline">
                        <label>Name&nbsp;&nbsp;&nbsp;</label>
                        <asp:TextBox ID="cp_name" TextMode="SingleLine" required="true" CssClass="form-control" placeholder="e.g. Joe Douglas" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv8" runat="server" ValidationGroup="vg5" ControlToValidate="cp_name" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="ml-2 col-3 form-inline">
                        <label style="display: inline-block;">Address&nbsp;&nbsp;&nbsp;</label><br />
                        <asp:TextBox ID="cp_address" TextMode="MultiLine" required="true" CssClass="form-control" Wrap="true" Style="resize: none" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv9" runat="server" ValidationGroup="vg5" ControlToValidate="cp_address" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row form-inline required">
                    <div class="col-3"></div>
                    <div class="col-3 form-inline">
                        <label>Telephone</label>
                        <asp:TextBox ID="cp_phone" TextMode="Phone" required="true" CssClass="form-control" placeholder="e.g. 9999988888" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv10" runat="server" ValidationGroup="vg5" ControlToValidate="cp_phone" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev3" runat="server" ValidationGroup="vg5" ControlToValidate="cp_phone" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationExpression="^\d{10}$" Display="Dynamic" ErrorMessage="Should be 10 digits" SetFocusOnError="true"></asp:RegularExpressionValidator>
                    </div>
                    <div class="ml-2 col-3 form-inline">
                        <label>Email&nbsp;&nbsp;</label>
                        <asp:TextBox ID="cp_email" TextMode="Email" required="true" CssClass="form-control" placeholder="e.g. John@gmail.com" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv11" runat="server" ValidationGroup="vg5" ControlToValidate="cp_email" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left control-label">Price of Tender Document</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="price_doc" TextMode="SingleLine" CssClass="form-control" placeholder="(in Rs.)" required="true" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left control-label">Start Date and Time for Sale of Tender Document</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="start_dt_sale" TextMode="SingleLine" CssClass="form-control" placeholder="Select Date and Time" required="true" runat="server"></asp:TextBox>
            </div>

        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left control-label">Last Date and Time for Sale of Tender Document</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="end_dt_sale" TextMode="SingleLine" CssClass="form-control" placeholder="Select Date and Time" required="true" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left control-label">Start Date and Time for Bidding</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="start_dt_bid" TextMode="SingleLine" CssClass="form-control" placeholder="Select Date and Time" required="true" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left control-label">Last Date and Time for Bidding</p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="end_dt_bid" TextMode="SingleLine" CssClass="form-control" placeholder="Select Date and Time" required="true" runat="server"></asp:TextBox>
            </div>
        </div>
        <asp:UpdatePanel runat="server" ID="up2" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="mt-2 row form-inline required">
                    <div class="col-3">
                        <p class="align-left control-label">Tender Document Downloadable</p>
                    </div>
                    <div class="col-3">
                        <asp:RadioButtonList ID="rb2" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" TextAlign="Right" OnSelectedIndexChanged="rb2_SelectedIndexChanged" AutoPostBack="true" CellPadding="10" CellSpacing="10" Width="30">
                            <asp:ListItem Text="Yes" Value="0"></asp:ListItem>
                            <asp:ListItem Text="No" Value="1"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rfv12" runat="server" ValidationGroup="vg7" ControlToValidate="rb2" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="mt-2 row form-inline required">
                    <div class="col-3">
                        <p class="align-left control-label">File to be Uploaded</p>
                    </div>
                    <div class="col-3">
                        <asp:FileUpload ID="fu1" runat="server" EnableTheming="true" />
                        
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left">
                    Other Details<br />
                    (Max. 1000 Chars)
                </p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="other_details" runat="server" TextMode="MultiLine" CssClass="form-control" Wrap="true" Style="resize: none"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3">
                <p class="align-left">
                    Special Conditions<br />
                    (Max. 1000 Chars)
                </p>
            </div>
            <div class="col-3">
                <asp:TextBox ID="spcl_cond" runat="server" TextMode="MultiLine" CssClass="form-control" Wrap="true" Style="resize: none"></asp:TextBox>
            </div>
        </div>
    </div>

    <div id='previewDiv'>
        &nbsp;
    </div>
    <div class="form-inline">
        <asp:Button ID="mysubmit" runat="server" Text="Submit" Width="81px"  OnClientClick="return false;" CausesValidation="true" />
        <asp:Button ID="reset" runat="server" Text="Reset" Width="81px" OnClientClick="this.form.reset();return false;" />
    </div>
    <div id="extra">
    <div class="extra_button" style="display:none">
        <asp:Button ID="final_submit" runat="server" Text="Submit" Width="81px" OnClick="final_submit_Click"/>
        <asp:Button ID="updateform" runat="server"  OnClientClick="return false;" Text="Update" Width="81px" />
    </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.21.0/moment.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/jquery-ui.js"></script>
    <script>
        function pageLoad() {
            $('.selectpicker').selectpicker();
        }
    </script>
    <script>
        $('#<%= start_dt_sale.ClientID %>').datetimepicker({
            format: 'DD-MM-YYYY hh:mm A',
            minDate: new Date(),
            showClose: true
        });
        $('#<%= end_dt_sale.ClientID %>').datetimepicker({
            useCurrent: false,
            format: 'DD-MM-YYYY hh:mm A',
            showClose: true
        });
        $('#<%= start_dt_sale.ClientID %>').on("dp.change", function (e) {
            $('#<%= end_dt_sale.ClientID %>').data("DateTimePicker").minDate(e.date);
        });
        $('#<%= end_dt_sale.ClientID %>').on("dp.change", function (e) {
            $('#<%= start_dt_sale.ClientID %>').data("DateTimePicker").maxDate(e.date);
            $('#<%= start_dt_bid.ClientID %>').data("DateTimePicker").minDate(e.date);
        });
        $('#<%= start_dt_bid.ClientID %>').datetimepicker({
            useCurrent: false,
            format: 'DD-MM-YYYY hh:mm A',
            showClose: true
        });
        $('#<%= end_dt_bid.ClientID %>').datetimepicker({
            useCurrent: false,
            format: 'DD-MM-YYYY hh:mm A',
            showClose: true
        });
        $('#<%= start_dt_bid.ClientID %>').on("dp.change", function (e) {
            $('#<%= end_dt_bid.ClientID %>').data("DateTimePicker").minDate(e.date);
        });
        $('#<%= end_dt_bid.ClientID %>').on("dp.change", function (e) {
            $('#<%= start_dt_bid.ClientID %>').data("DateTimePicker").maxDate(e.date);
        });
        $('#<%= start_dt_sale.ClientID %>').on("dp.show", function (e) {
            $(".day").on('click', function () {
                $("a[data-action='togglePicker']").trigger('click');
            });
        });
        $('#<%= end_dt_sale.ClientID %>').on("dp.show", function (e) {
            $(".day").on('click', function () {
                $("a[data-action='togglePicker']").trigger('click');
            });
        });
        $('#<%= start_dt_bid.ClientID %>').on("dp.show", function (e) {
            $(".day").on('click', function () {
                $("a[data-action='togglePicker']").trigger('click');
            });
        });
        $('#<%= end_dt_bid.ClientID %>').on("dp.show", function (e) {
            $(".day").on('click', function () {
                $("a[data-action='togglePicker']").trigger('click');
            });
        });
    </script>
    <script>
        $('#<%= mysubmit.ClientID %>').click(function () {
            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate();
            }
            if (Page_IsValid) {
                var clonetext = $('#infor').clone(true);
                var stateVisible = $("#extra").find(".extra_button").css("display");
                if (stateVisible == 'none') {
                    $("#extra").find(".extra_button").show();
                }
                var clonetext1 = $("#extra").find(".extra_button").clone(true);
                if (stateVisible == 'none') {
                    $("#extra").find(".extra_button").hide();
                }
                clonetext = clonetext.append(clonetext1);
                $('#previewDiv').html(clonetext);
                $('#previewDiv input:not(:submit)').attr('disabled', 'disabled');
                $('#previewDiv textarea').attr('readonly', 'readonly');
                $("#previewDiv").dialog("open");
                return false;
            }
        });
        $("#previewDiv").dialog({
            autoOpen: false,
            width: 'auto',
            autoResize: true,
            position: { my: "center", at: "top" },
            open: function () {
                $(this).parent().appendTo("form:first");
            },
            show: "blind",
            hide: "explode"
        });

        function openDialog() {

        }
        $('#<%= updateform.ClientID %>').click(function () {
            $("#previewDiv").dialog("close");
        });

    </script>

</asp:Content>
