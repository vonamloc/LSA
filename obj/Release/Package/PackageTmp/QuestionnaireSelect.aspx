<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionnaireSelect.aspx.cs" Inherits="LSA.QuestionnaireSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row mt-5">
        <div class="col">
        <asp:GridView ID="GvQuestionnaire" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true"
            OnPreRender="GvQuestionnaire_PreRender" OnRowCommand="GvQuestionnaire_RowCommand" OnRowDataBound="GvQuestionnaire_RowDataBound" CssClass="w-100">
            <Columns>
                <asp:BoundField DataField="QnsNo" ShowHeader="true" HeaderText="Qns No." />
                <asp:BoundField DataField="Category" ShowHeader="true" HeaderText="Category" />
                <asp:BoundField DataField="Desc" ShowHeader="true" HeaderText="Description" />
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbView" runat="server" Text="View" CommandName="View" CssClass="btn btn-info co-12" CommandArgument='<%# Eval("QnsID") %>'>
                                <i class="far fa-eye fa-lg"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbUpdate" runat="server" Text="View" CommandName="Update" CssClass="btn btn-primary col-12" CommandArgument='<%# Eval("QnsID") %>'>
                                <i class="fas fa-pencil-alt fa-lg"></i>
                                </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    </div>

    <div class="mt-3 mb-3">
        <asp:Button ID="BtnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAdd_Click" />
    </div>

    <script>
        $(document).ready(function () {
            $('#<%= GvQuestionnaire.ClientID %>').DataTable();
        });
    </script>
</asp:Content>
