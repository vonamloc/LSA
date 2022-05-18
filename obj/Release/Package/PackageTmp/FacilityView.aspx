<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FacilityView.aspx.cs" Inherits="LSA.FacilityView" %>

<%@ Register Src="UserControls/ViewFooter.ascx" TagName="ViewFooter" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />

    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="info-tab" data-toggle="tab" data-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">General Info</button>
            <button class="nav-link" id="sensors_tab" data-toggle="tab" data-target="#readings" type="button" role="tab" aria-controls="readings" aria-selected="false" runat="server">Sensors Installed</button>
            <button class="nav-link" id="lessons_tab" data-toggle="tab" data-target="#lessons" type="button" role="tab" aria-controls="settings" aria-selected="false" runat="server">Lessons</button>
        </div>
    </nav>

    <div class="tab-content bg-white clearfix" id="nav-tabContent">
        <div class="tab-pane show active" id="info" role="tabpanel" aria-labelledby="info-tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-2 text-lg-right text-sm-left">
                            <label>Facility ID:</label>
                        </div>
                        <div class="col-sm-10">
                            <asp:TextBox ID="TbFacilityID" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-2 text-lg-right text-sm-left">
                            <label>Facility Code/ Name:</label>
                        </div>
                        <div class="col-sm-10">
                            <asp:DropDownList ID="DdlFacilityCodeName" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <uc1:ViewFooter ID="ucViewFooter" runat="server" />
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="readings" role="tabpanel" aria-labelledby="sensors_tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <h5>
                                <asp:Label ID="lblTotalSensors" runat="server" />
                            </h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 mt-3">
                            <asp:GridView ID="GvSensorDevice" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="col-12"
                                OnPreRender="Gv_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="DeviceID" ShowHeader="true" HeaderText="DeviceID" />
                                    <asp:BoundField DataField="DeviceMAC" ShowHeader="true" HeaderText="Device MAC" />
                                    <asp:BoundField DataField="DeviceName" ShowHeader="true" HeaderText="Device Name" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="lessons" role="tabpanel" aria-labelledby="lessons_tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <asp:UpdatePanel ID="upLesson" runat="server">
                        <ContentTemplate>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-12 d-flex justify-content-center">
                                    <asp:Label ID="lblLessonWarning" runat="server" CssClass="text-danger">You can only add lessons when Facility Code has been updated.</asp:Label>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-9">
                                    <h5>
                                        <asp:Label ID="lblTotalLessons" runat="server" />
                                    </h5>
                                </div>
                                <div class="col-sm-3 d-flex justify-content-end" id="divAddNew" runat="server">
                                    <button class="btn btn-outline-primary" type="button" data-toggle="collapse" data-target="#collapseAddLesson" aria-expanded="false" aria-controls="collapseAddLesson">
                                        Add New +
                                    </button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="collapse" id="collapseAddLesson">
                                        <div class="card card-body">
                                            <div id="divAddLesson" runat="server">
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-sm-2 text-lg-right text-sm-left">
                                                        <label>Lesson Type:</label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <asp:DropDownList ID="DdlLessonType" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-sm-2 text-lg-right text-sm-left">
                                                        <label>Module Code/ Name:</label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <asp:DropDownList ID="DdlModuleCode" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-6">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 1:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp1" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 2:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp2" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 3:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp3" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 4:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp4" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 5:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp5" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 6:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp6" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 7:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp7" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-3 text-lg-right text-sm-left">
                                                                <label>Mod Grp 8:</label>
                                                            </div>
                                                            <div class="col-sm-9">
                                                                <asp:TextBox ID="TbModuleGrp8" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-6">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-2 text-lg-right text-sm-left">
                                                                <label>TIC 1:</label>
                                                            </div>
                                                            <div class="col-sm-10">
                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-2 text-lg-right text-sm-left">
                                                                <label>TIC 2:</label>
                                                            </div>
                                                            <div class="col-sm-10">
                                                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-2 text-lg-right text-sm-left">
                                                                <label>TIC 3:</label>
                                                            </div>
                                                            <div class="col-sm-10">
                                                                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-2 text-lg-right text-sm-left">
                                                                <label>TIC 4:</label>
                                                            </div>
                                                            <div class="col-sm-10">
                                                                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-5">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-4 text-lg-right text-sm-left">
                                                                <label>Held on every:</label>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <asp:DropDownList ID="DdlDayOfWeek" runat="server" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-7">
                                                        <div class="row mt-2 mb-2 d-flex justify-content-end align-content-center">
                                                            <div class="col">
                                                                <div class="input-group date">
                                                                    <div class="input-group-prepend">
                                                                        <span class="input-group-text">Time Start:</span>
                                                                    </div>
                                                                    <asp:TextBox ID="TbTimeFrom" runat="server" CssClass="form-control" TextMode="Time" />
                                                                    <div class="input-group-append">
                                                                        <span class="input-group-text">Time End:</span>
                                                                    </div>
                                                                    <asp:TextBox ID="TbTimeTo" runat="server" CssClass="form-control" TextMode="Time" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-5">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-sm-4 text-lg-right text-sm-left">
                                                                <label>E-Learning<br />
                                                                    (Even Weeks):</label>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Text="true" Value="true"></asp:ListItem>
                                                                    <asp:ListItem Text="false" Value="false"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-7">
                                                        <div class="row mt-2 mb-2 d-flex justify-content-end align-content-center">
                                                            <div class="col">
                                                                <div class="input-group">
                                                                    <div class="input-group-prepend">
                                                                        <span class="input-group-text">Week Start:</span>
                                                                    </div>
                                                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" TextMode="Number" Min="1" MaxLength="18" />
                                                                    <div class="input-group-append">
                                                                        <span class="input-group-text">Week End:</span>
                                                                    </div>
                                                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" TextMode="Number" Min="1" MaxLength="18" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2 mb-2">
                                                    <div class="col-sm-2 text-lg-right text-sm-left">
                                                        <label>Semester:</label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <asp:DropDownList ID="DdlSemester" runat="server" CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12 d-flex justify-content-end">
                                                        <asp:Button ID="BtnSaveLesson" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="BtnSaveLesson_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12 mt-3">
                                    <asp:GridView ID="GvLesson" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="col-12"
                                        OnPreRender="Gv_PreRender" OnRowCommand="GvLesson_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="ModuleCodeName" ShowHeader="true" HeaderText="Module Code" />
                                            <asp:BoundField DataField="LessonType" ShowHeader="true" HeaderText="Type" />
                                            <asp:BoundField DataField="ModuleGrps" ShowHeader="true" HeaderText="Module Grp(s)" />
                                            <asp:BoundField DataField="TICs" ShowHeader="true" HeaderText="Teacher(s)-In-Charge" />
                                            <asp:BoundField DataField="DayOfWeek" ShowHeader="true" HeaderText="Held every" />
                                            <asp:BoundField DataField="TimeStart" ShowHeader="true" HeaderText="Start At" />
                                            <asp:BoundField DataField="TimeEnd" ShowHeader="true" HeaderText="End At" />
                                            <asp:BoundField DataField="WeekStart" ShowHeader="true" HeaderText="From Week" />
                                            <asp:BoundField DataField="WeekEnd" ShowHeader="true" HeaderText="To Week" />
                                            <asp:BoundField DataField="Semester" ShowHeader="true" HeaderText="Semester" />
                                            <asp:TemplateField ShowHeader="false">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="BtnDeleteFacility" runat="server" Text="Delete" CommandName="Delete" CssClass="btn btn-danger col-12" CommandArgument='<%# Eval("LessonID") %>'>
                                                        <i class="fas fa-trash-alt"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="BtnSaveLesson" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3 mb-3">
        <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="BtnSubmit_Click" />
        <asp:Button ID="BtnDelete" runat="server" CssClass="btn btn-danger mr-1" Text="Delete Facility" OnClick="BtnDelete_Click" />
    </div>

    <script>

        function SetTab() {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "info";
            $('#Tabs a[href="#' + tabName + '"]').tab('show');
        }

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            SetTab();

            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });

        $(document).ready(function () {
            SetTab();

            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });

    </script>
</asp:Content>
