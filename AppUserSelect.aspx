<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AppUserSelect.aspx.cs" Inherits="LSA.AppUserSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mt-5">
        <asp:GridView ID="GvAppUser" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true"
            OnPreRender="GvAppUser_PreRender" OnRowCommand="GvAppUser_RowCommand" OnRowDataBound="GvAppUser_RowDataBound" CssClass="w-100">
            <Columns>
                <asp:BoundField DataField="UsrShtName" ShowHeader="true" HeaderText="User Short Name" />
                <asp:BoundField DataField="UsrRole" ShowHeader="true" HeaderText="Usr Role" />
                <asp:BoundField DataField="UsrStatus" ShowHeader="true" HeaderText="Status" />
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbView" runat="server" Text="View" CommandName="View" CssClass="btn btn-info col-12" CommandArgument='<%# Eval("LoginID") %>'>
                                <i class="far fa-eye fa-lg"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbUpdate" runat="server" Text="View" CommandName="Update" CssClass="btn btn-primary col-12" CommandArgument='<%# Eval("LoginID") %>'>
                                <i class="fas fa-pencil-alt fa-lg"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div class="mt-3 mb-3">
        <asp:Button ID="BtnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAdd_Click" />
    </div>
    <script>
        $(document).ready(function () {
            $('#<%= GvAppUser.ClientID %>').DataTable();
        });
    </script>
</asp:Content>
