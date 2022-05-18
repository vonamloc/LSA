<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashboardAdmin.aspx.cs" Inherits="LSA.DashboardAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="SoundData" runat="server" />
    <asp:HiddenField ID="TempData" runat="server" />
    <asp:HiddenField ID="HumidData" runat="server" />
    <div class="row">
        <div class="col-3">
            <div class="card">
                <div class="card-body">
                    <label class="card-title font-weight-bold">Ongoing noise events</label>
                    <p class="card-text text-primary d-flex align-items-center">
                        <i class="fas fa-volume-down fa-2x"></i>
                        &nbsp;
                        &nbsp;
                        <asp:Label ID="lblNoiseCount" runat="server" Text="0"></asp:Label>
                    </p>
                </div>
                <div class="card-footer">
                    <small class="text-muted">No ongoing noise events</small>
                </div>
            </div>
        </div>

        <div class="col-3">
            <div class="card">
                <div class="card-body">
                    <label class="card-title font-weight-bold">Crowds Detected</label>
                    <p class="card-text text-primary d-flex align-items-center">
                        <i class="fas fa-users fa-2x"></i>
                        &nbsp;
                        &nbsp;
                        <asp:Label ID="lblCrowdCount" runat="server" Text="0"></asp:Label>
                    </p>
                </div>
                <div class="card-footer">
                    <small class="text-muted">No crowds detected</small>
                </div>
            </div>
        </div>

        <div class="col-3">
            <div class="card">
                <div class="card-body">
                    <label class="card-title font-weight-bold">Offline</label>
                    <p class="card-text text-primary d-flex align-items-center">
                        <i class="fas fa-wifi fa-2x"></i>
                        &nbsp;
                        &nbsp;
                        <asp:Label ID="lblOffCount" runat="server" Text="0"></asp:Label>
                    </p>
                </div>
                <div class="card-footer">
                    <small class="text-muted">All sensors are online</small>
                </div>
            </div>
        </div>

        <div class="col-3">
            <div class="card">
                <div class="card-body">
                    <label class="card-title font-weight-bold">Low Battery</label>
                    <p class="card-text text-primary d-flex align-items-center">
                        <i class="fas fa-battery-full fa-2x"></i>
                        &nbsp;
                        &nbsp;
                        <asp:Label ID="lblBattCount" runat="server" Text="0"></asp:Label>
                    </p>
                </div>
                <div class="card-footer">
                    <small class="text-muted">No sensors need recharging</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-12">
            <div class="card" style="height:300px;">
                <div class="card-body">
                    <h4 class="card-title font-weight-bold">Latest Events</h4>

                    <%--<div class="accordion" id="accordionExample">
                        <!--Sensor Data-->
                        <div class="card">
                            <div class="card-header bg-primary" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block shadow-none text-left text-light collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Sensor Data
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                <div class="card-body">
                                </div>
                            </div>
                        </div>
                        <!--Survey Responses-->
                        <div class="card">
                            <div class="card-header bg-primary" id="headingThree">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block shadow-none text-left text-light collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        Survey Responses
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                                <div class="card-body">
                                </div>
                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
