<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Tender.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container align-self-center" style="max-width:300px;">
           <div class="form-group">
               <label>Username</label>
               <asp:TextBox ID="textbox1" class="form-control" placeholder="Username" required="True" autofocus="True" runat="server"></asp:TextBox>
           </div>
           <div class="form-group">
               <label>Password</label>
               <asp:TextBox ID="textbox2" TextMode="Password" class="form-control" placeholder="Password" required="True" runat="server"></asp:TextBox>
           </div>
            <asp:Button ID="button1"  class="btn btn-lg btn-primary btn-block mb-1" Text="Sign In" runat="server" OnClick="button1_Click"></asp:Button>
       <asp:Label ID="label1" runat="server" ForeColor="red" Font-Names="verdana" Font-Size="10pt"></asp:Label>
   </div>
</asp:Content>
