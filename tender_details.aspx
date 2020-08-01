<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tender_details.aspx.cs" Inherits="Tender.tender_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="mt-2 row form-inline">
            <div class="col form-inline">
                <p class="align-left control-label">Tender ID:</p>
            </div>
            <div class="col form-inline">
                <asp:TextBox ID="id" runat="server" CssClass="form-control" TextMode="SingleLine" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline">
            <div class="col form-inline">
                <p class="align-left control-label">Name of Work:</p>
            </div>
            <div class="col form-inline">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="SingleLine" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
        <div class="mt-2 row form-inline">
            <div class="col form-inline">
                <p class="align-left control-label">Department</p>
            </div>
            <div class="col form-inline">
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
        <div class="mt-4 row form-inline">
            <div class="col form-inline">
                <p class="align-left control-label">Current Lowest Bid</p>
            </div>
            <div class="col form-inline">
                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text="Rs5000000" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
        <div class="mt-4 row form-inline">
            <div class="col form-inline">
                <p class="align-left control-label">Enter New Bid</p>
            </div>
            <div class="col form-inline">
                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" Placeholder="Enter Bid amount less than the current lowest" TextMode="SingleLine" ></asp:TextBox>
            </div>
        </div>
        <div class="mt-4 row form-inline">
            <div class="col form-inline">
            </div>
            <div class="col form-inline">
                <asp:Button runat="server" CssClass="btn-submit" Text="Submit Bid" />
            </div>
            <div class="col form-inline">
            </div>
        </div>
    </div>
</asp:Content>
