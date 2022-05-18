<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FacilitySelect.aspx.cs" Inherits="LSA.FacilitySelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView ID="GvFacility" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="w-100"
        OnPreRender="GvFacility_PreRender" OnRowCommand="GvFacility_RowCommand" OnRowDataBound="GvFacility_RowDataBound">
        <Columns>
            <asp:BoundField DataField="FacilityID" ShowHeader="true" HeaderText="Facility ID" />
            <asp:BoundField DataField="FacilityCode" ShowHeader="true" HeaderText="Code" />
            <asp:BoundField DataField="FacilityName" ShowHeader="true" HeaderText="Name" />
            <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:LinkButton ID="lbView" runat="server" Text="View" CommandName="View" CssClass="btn btn-info col-12" CommandArgument='<%# Eval("FacilityID") %>'>
                                <i class="far fa-eye fa-lg"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                <ItemTemplate>
                    <div>
                        <asp:LinkButton ID="lbUpdate" runat="server" Text="View" CommandName="Update" CssClass="btn btn-primary col-12" CommandArgument='<%# Eval("FacilityID") %>'>
                                <i class="fas fa-pencil-alt fa-lg"></i>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="mt-3 mb-3">
        <asp:Button ID="BtnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAdd_Click" />
    </div>

    <script>
        function SetDataTable() {
            $('#<%= GvFacility.ClientID %>').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        text: 'Download Excel',
                        messageTop: "List of Facilities"
                    },
                    {
                        extend: 'pdfHtml5',
                        text: 'Download PDF',
                        messageTop: "List of Facilities"
                    }
                ]
            });
        }

        $(document).ready(function () {
            SetDataTable();
        });
    </script>
</asp:Content>
