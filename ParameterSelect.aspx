<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ParameterSelect.aspx.cs" Inherits="LSA.ParameterSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mt-5">
        <asp:GridView ID="GvParameter" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="w-100"
            OnPreRender="GvParameter_PreRender" OnRowCommand="GvParameter_RowCommand" OnRowDataBound="GvParameter_RowDataBound">
            <Columns>
                <asp:BoundField DataField="ParaCode1" ShowHeader="true" HeaderText="Paracode 1" />
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbView" runat="server" Text="View" CommandName="View" CssClass="btn btn-info col-12" CommandArgument='<%# Eval("ParaCode1") %>'>
                            <i class="far fa-eye fa-lg"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbUpdate" runat="server" Text="Update" CommandName="Update" CssClass="btn btn-primary col-12" CommandArgument='<%# Eval("ParaCode1") %>'>
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
            $('#<%= GvParameter.ClientID %>').DataTable();
        });
    </script>
</asp:Content>
