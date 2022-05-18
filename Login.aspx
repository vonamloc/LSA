<%@ Page Title="" Language="C#" MasterPageFile="~/Authentication.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LSA.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <!-- Nested Row within Card Body -->
    <div class="row">
        <div class="col-lg-6 d-none d-lg-block bg-classroom-image">
        </div>
        <div class="col-lg-6">
            <div class="p-5">
                <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TbLoginID" runat="server" class="form-control form-control-user" Placeholder="Login ID" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TbPassword" runat="server" class="form-control form-control-user" Placeholder="Password" TextMode="Password" />
                </div>
                <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                <asp:Button ID="BtnLogin" runat="server" class="btn btn-primary btn-user btn-block" Text="Login" OnClick="BtnLogin_Click"></asp:Button>
                <hr>
                <div class="text-center">
                    <a class="small" href="/ForgotPassword">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
    <style>
        .bg-classroom-image {
            background-image: url('../Content/Images/modern-classroom.jpg');
            background-position: center;
            background-size: cover;
        }
    </style>
</asp:Content>
