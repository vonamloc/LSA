<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SensorDatabase.aspx.cs" Inherits="LSA.SensorDatabase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="display_lbl" runat="server" Text=""></asp:Label>
    <asp:Button ID="BtnGenerateExcel" runat="server" Text="Download as Excel" OnClick="BtnGenerateExcel_Click" />
    <asp:UpdatePanel ID="upDevices" runat="server">
        <ContentTemplate>
            <div class="row" id="divDBData" runat="server">
                <div class="col-12 mt-5">
                    <asp:GridView ID="GvSensorReadingFromDB" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="w-100">
                        <Columns>
                            <asp:BoundField DataField="DateTimeStamp" ShowHeader="true" HeaderText="Date Time Stamp" Visible="true" />
                            <asp:BoundField DataField="Sound" ShowHeader="true" HeaderText="Sound Level (db)" Visible="true" />
                            <asp:BoundField DataField="Motion" ShowHeader="true" HeaderText="Motion" Visible="true" />
                            <asp:BoundField DataField="Humidity" ShowHeader="true" HeaderText="Humidity (%)" Visible="true" />
                            <asp:BoundField DataField="Temperature" ShowHeader="true" HeaderText="Temperature (°C)" Visible="true" />
                            <asp:BoundField DataField="DeviceID" ShowHeader="true" HeaderText="Device ID" Visible="true" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
