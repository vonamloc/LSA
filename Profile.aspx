<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LSA.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-4">
            <div class="row mt-2 mb-2">
                <div class="col-12 text-sm-left small text-dark font-weight-bold">
                    <label>Login ID:</label>
                </div>
                <div class="col-12">
                    <asp:TextBox ID="TbLoginID" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-4">
            <div class="row mt-2 mb-2">
                <div class="col-12 text-sm-left small text-dark font-weight-bold">
                    <label>Email:</label>
                </div>
                <div class="col-12">
                    <asp:TextBox ID="TbEmail" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-4">
            <div class="row mt-2 mb-2">
                <div class="col-12 text-sm-left small text-dark font-weight-bold">
                    <label>Old Password:</label>
                </div>
                <div class="col-12">
                    <asp:TextBox ID="TbOldPwd" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-4">
            <div class="row mt-2 mb-2">
                <div class="col-12 text-sm-left small text-dark font-weight-bold">
                    <label>New Password:</label>
                </div>
                <div class="col-12">
                    <asp:TextBox ID="TbNewPwd" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-4">
            <div class="row mt-2 mb-2">
                <div class="col-12 text-sm-left small text-dark font-weight-bold">
                    <label>Confirm Password:</label>
                </div>
                <div class="col-12">
                    <asp:TextBox ID="TbCfmPwd" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-3 mb-3">
        <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="BtnSubmit_Click" />
    </div>
</asp:Content>
