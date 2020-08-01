<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="vendor_reg.aspx.cs" Inherits="Tender.vendor_reg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row form-inline required">
            <div class="col-3 form-inline">
                <label class="control-label">Name:</label>
            </div>
            <div class="col-3 form-inline">
                <asp:TextBox ID="name" TextMode="SingleLine" CssClass="form-control" placeholder="e.g. John Doe" required="true" runat="server" autofocus="true" CausesValidation="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="vendor_cpass" ValidationGroup="vg1" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
            </div>
        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="mt-2 row form-inline required">
                    <div class="col-3 form-inline">
                        <label class="control-label">Email:</label>
                    </div>
                    <div class="col-3">
                        <asp:TextBox ID="vendor_email" TextMode="Email" CssClass="form-control" CausesValidation="true" placeholder="e.g. me@mymail.com" required="true" runat="server" AutoPostBack="true" OnTextChanged="vendor_email_TextChanged"></asp:TextBox>
                        <asp:CustomValidator ID="cv3" runat="server" ControlToValidate="vendor_email" Display="Dynamic" Enabled="true" ErrorMessage="" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ValidationGroup="vg2" OnServerValidate="cv3_ServerValidate" SetFocusOnError="true"></asp:CustomValidator>
                        <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="vendor_email" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ValidationGroup="vg2" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev1" runat="server" ControlToValidate="vendor_email" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationGroup="vg2" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" Display="Dynamic" ErrorMessage="Invalid email address" SetFocusOnError="true" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label class="control-label">Password:</label>
            </div>
            <div class="col-3 form-inline">
                <asp:TextBox ID="vendor_pass" TextMode="Password" CssClass="form-control" placeholder="Password" CausesValidation="true" required="true" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv3" runat="server" ValidationGroup="vg3" ControlToValidate="vendor_pass" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rev2" runat="server" ValidationGroup="vg3" ControlToValidate="vendor_pass" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" Display="Dynamic" ErrorMessage="Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label class="control-label">Confirm Password:</label>
            </div>
            <div class="col-3 form-inline">
                <asp:TextBox ID="vendor_cpass" TextMode="Password" CssClass="form-control" placeholder="Password" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                <asp:CustomValidator ID="cv2" runat="server" ValidationGroup="vg4" ControlToValidate="vendor_cpass" ClientValidationFunction="cp_check" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="" SetFocusOnError="true" EnableClientScript="true" />
                <asp:RequiredFieldValidator ID="rfv4" runat="server" ValidationGroup="vg4" ControlToValidate="vendor_cpass" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label class="control-label">Mobile No:</label>
            </div>
            <div class="col-3 form-inline">
                <asp:TextBox ID="vendor_mobile" TextMode="Phone" CssClass="form-control" placeholder="e.g. 9999999999" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv5" runat="server" ValidationGroup="vg5" ControlToValidate="vendor_mobile" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rev3" runat="server" ValidationGroup="vg5" ControlToValidate="vendor_mobile" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationExpression="^\d{10}$" Display="Dynamic" ErrorMessage="Should be 10 digits" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="container">
                <div class="row form-inline required">
                    <div class="col-3 form-inline">
                        <label>Address</label>
                    </div>
                    <div class="col-3 form-inline">
                        <label class="control-label">Streets:</label>
                        <asp:TextBox ID="street" TextMode="SingleLine" CssClass="form-control" placeholder="e.g. 7th Avenue Street" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv6" runat="server" ValidationGroup="vg6" ControlToValidate="street" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-3 form-inline">
                        <label class="control-label">City:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <asp:TextBox ID="city" TextMode="SingleLine" CssClass="form-control" placeholder="e.g. Kolkata" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv7" runat="server" ValidationGroup="vg6" ControlToValidate="city" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="mt-2 row form-inline required">
                    <div class="col-3 form-inline"></div>
                    <div class="col-3 form-inline">
                        <label class="control-label">State:</label>
                        <asp:TextBox ID="state" TextMode="SingleLine" CssClass="form-control" placeholder="e.g. West Bengal" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv8" runat="server" ValidationGroup="vg6" ControlToValidate="state" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-3 form-inline">
                        <label class="control-label">Pincode:</label>
                        <asp:TextBox ID="pincode" TextMode="SingleLine" CssClass="form-control" placeholder="e.g. 700700" required="true" runat="server" CausesValidation="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv9" runat="server" ValidationGroup="vg6" ControlToValidate="pincode" Display="Dynamic" ForeColor="red" Font-Names="verdana" Font-Size="10pt" ErrorMessage="Required" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev4" runat="server" ValidationGroup="vg6" ControlToValidate="pincode" ForeColor="Red" Font-Names="verdana" Font-Size="10pt" ValidationExpression="^\d{6}$" Display="Dynamic" ErrorMessage="Should be 6 digits" SetFocusOnError="true"></asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label>Criteria for email notification</label>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label>Estimated cost of project</label>
            </div>
            <div class="col-3 form-inline">
                <asp:DropDownList runat="server" ID="ecp" CssClass="form-control">
                    <asp:ListItem Text="--Any Amount--" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="1 Lakh and Above" Value="1"></asp:ListItem>
                    <asp:ListItem Text="5 Lakhs and Above" Value="5"></asp:ListItem>
                    <asp:ListItem Text="10 Lakhs and Above" Value="10"></asp:ListItem>
                    <asp:ListItem Text="50 Lakhs and Above" Value="50"></asp:ListItem>
                    <asp:ListItem Text="1 Crore and Above" Value="100"></asp:ListItem>
                    <asp:ListItem Text="5 Crores and Above" Value="500"></asp:ListItem>
                    <asp:ListItem Text="10 Crores and Above" Value="1000"></asp:ListItem>
                    <asp:ListItem Text="50 Crores and Above" Value="5000"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="mt-2 row form-inline required">
            <div class="col-3 form-inline">
                <label class="control-label">Please Select the Subjects for which Tender notices you are Interested</label>
            </div>
            <div class="col-3 form-inline">
                <asp:CheckBox ID="main_check" Checked="true" Text="Notify me for all tenders" runat="server" Onclick="main_check_changed(this)" />
            </div>
        </div>
        <div class="mt-4 row form-inline required">
            <div class="col-3 form-inline">
                <label><b>Goods</b></label>
            </div>
            <div class="col-lg-auto">
                <asp:CheckBoxList ID="goods" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" CssClass="CheckBoxListCssClass"></asp:CheckBoxList>
            </div>
        </div>
        <div class="mt-4 row form-inline required">
            <div class="col-3 form-inline">
                <label><b>Services</b></label>
            </div>
            <div class="col-lg-auto">
                <asp:CheckBoxList ID="services" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" CssClass="CheckBoxListCssClass"></asp:CheckBoxList>
            </div>
        </div>
        <div class="form-inline required">
            <asp:Button ID="mysubmit" runat="server" Text="Submit" Width="81px" OnClick="submit_Click" CausesValidation="true" />
            <asp:Button ID="reset" runat="server" Text="Reset" Width="81px" OnClientClick="this.form.reset();return false;" />
        </div>
    </div>

    <script>
        function cp_check(source, arguments) {
            if (document.getElementById("<%= vendor_cpass.ClientID %>").value != document.getElementById("<%= vendor_pass.ClientID %>").value && document.getElementById("<%= vendor_cpass.ClientID %>").value) {
                source.innerText = "Password does not match";
                arguments.IsValid = false;
            }
            else
                arguments.IsValid = true;

        }

        function checkedchanged(chkbox) {
            var goods = document.getElementById('<%= goods.ClientID %>').getElementsByTagName("input");
            var services = document.getElementById('<%= services.ClientID %>').getElementsByTagName("input");
            var count = 0;
            for (i = 0; i < goods.length; i++) {
                if (goods[i].checked == true) {
                    count++;
                }
            }
            for (i = 0; i < services.length; i++) {
                if (services[i].checked == true) {
                    count++;
                }
            }
            if (count < 50) {
                document.getElementById('<%= main_check.ClientID %>').removeAttribute("checked");
            }
            else {
                document.getElementById('<%= main_check.ClientID %>').setAttribute("checked", "checked");
            }
        }
        function main_check_changed(chkbox) {
            var main_check = document.getElementById('<%= main_check.ClientID %>');
            var goods = document.getElementById('<%= goods.ClientID %>').getElementsByTagName("input");
            var services = document.getElementById('<%= services.ClientID %>').getElementsByTagName("input");
            if (main_check.checked == true) {
                for (i = 0; i < goods.length; i++) {
                    goods[i].setAttribute("checked", "checked");
                }
                for (i = 0; i < services.length; i++) {
                    services[i].setAttribute("checked", "checked");
                }
            }
            else {
                for (i = 0; i < goods.length; i++) {
                    goods[i].removeAttribute("checked");
                }
                for (i = 0; i < services.length; i++) {
                    services[i].removeAttribute("checked");
                }

            }
        }
    </script>
</asp:Content>
