<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestAPI.aspx.cs" Inherits="LSA.TestAPI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="input-group">

                <div class="input-group-prepend">
                    <span class="input-group-text">HTTP Method:</span>
                </div>
                <asp:DropDownList ID="DdlHTTPMethod" runat="server" CssClass="form-control col-sm-1">
                    <asp:ListItem Selected="True" Text="GET" Value="GET" />
                    <asp:ListItem Text="POST" Value="POST" />
                    <asp:ListItem Text="PUT" Value="PUT" />
                    <asp:ListItem Text="DEL" Value="DEL" />
                </asp:DropDownList>
                <div class="input-group-append">
                    <span class="input-group-text">URL Request:</span>
                </div>
                <asp:TextBox ID="TbRestRequest" runat="server" CssClass="form-control" />
                <div class="input-group-append">
                    <button runat="server" ID="BtnSearch" onserverclick="BtnSearch_Click" class="btn btn-outline-primary" title="Search">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3 mb-3">
        <div class="col-12 text-sm-left text-dark font-weight-bold">
            <label>JSON Response:</label>
        </div>
        <div class="col-12">
            <asp:TextBox ID="TbReadingJSON" runat="server" CssClass="form-control" TextMode="MultiLine" Height="300"></asp:TextBox>
        </div>
    </div>
</asp:Content>
