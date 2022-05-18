<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SensorSelect.aspx.cs" Inherits="LSA.SensorSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="upDevices" runat="server">
        <ContentTemplate>
            <div class="row d-flex justify-content-center">
                <div class="col-sm-3">
                    <asp:Button ID="BtnGetSensorsFromDB" runat="server" CssClass="btn btn-primary col-sm-12 mt-1 mb-1" Text="View Current Sensors" OnClick="BtnGetSensorsFromDB_Click" />
                </div>
                <div class="col-sm-3">
                    <asp:Button ID="BtnGetSensorsFromAPI" runat="server" CssClass="btn btn-outline-primary col-sm-12 mt-1 mb-1" Text="Get Sensor Updates" OnClick="BtnGetSensorsFromAPI_Click" />
                </div>
            </div>

            <div class="row" id="divDBData" runat="server">
                <div class="col-12 mt-5">
                    <asp:GridView ID="GvSensorDeviceFromDB" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="w-100"
                        OnPreRender="Gv_PreRender" OnRowCommand="GvSensorDeviceFromDB_RowCommand" OnRowDataBound="Gv_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="DeviceID" ShowHeader="true" HeaderText="Device ID" />
                            <asp:BoundField DataField="DeviceName" ShowHeader="true" HeaderText="Name" />
                            <asp:BoundField DataField="DevicePosition" ShowHeader="true" HeaderText="Position" />
                            <asp:BoundField DataField="FacilityCodeNameID" ShowHeader="true" HeaderText="Facility Code/Name (ID)" />
                            <asp:BoundField DataField="ActiveStatus" ShowHeader="true" HeaderText="Status" />
                            <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbView" runat="server" Text="View" CommandName="View" CssClass="btn btn-info col-12" CommandArgument='<%# Eval("DeviceID") %>'>
                                        <i class="far fa-eye fa-lg"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="false" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbUpdate" runat="server" Text="View" CommandName="Update" CssClass="btn btn-primary col-12" CommandArgument='<%# Eval("DeviceID") %>'>
                                        <i class="fas fa-pencil-alt fa-lg"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="col-2 mt-3 mb-3">
                    <asp:Button ID="BtnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAdd_Click" />
                </div>
            </div>
            <div class="row" id="divAPIData" runat="server">
                <div class="col-12 mt-3 mb-3">
                    <h5>
                        <asp:Label ID="lblCountUpdates" runat="server" Text="There are currently 0 updates." />
                    </h5>
                </div>
                <div class="col-12 mt-3 mb-3">
                    <asp:GridView ID="GvSensorUpdates" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="False" CssClass="w-100"
                        OnPreRender="Gv_PreRender" OnRowCommand="GvSensorUpdates_RowCommand" OnRowDataBound="Gv_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="UpdateMsg" ShowHeader="true" HeaderText="Update Message" />
                            <asp:TemplateField ShowHeader="false">
                                <ItemTemplate>
                                    <asp:Button ID="BtnCommitOne" runat="server" Text="Commit Changes" CssClass="btn btn-primary col-12" CommandName='<%#Eval("CRUDoperation")%>' CommandArgument='<%#Eval("DeviceObjJSON")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="col-sm-3">
                    <asp:Button ID="BtnCommitAll" runat="server" CssClass="btn btn-primary col-sm-12" Text="Commit All Changes" OnClick="BtnCommitAll_Click" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script>
        function SetDataTable() {
            $('#<%= GvSensorDeviceFromDB.ClientID %>').DataTable({
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
            $('#<%= GvSensorUpdates.ClientID %>').DataTable();
        }


        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            SetDataTable();
        });

        $(document).ready(function () {
            SetDataTable();
        });
    </script>
</asp:Content>
