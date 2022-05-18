<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="DashboardMain.aspx.cs" Inherits="LSA.DashboardMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="SoundData" runat="server" />
    <asp:HiddenField ID="TempData" runat="server" />
    <asp:HiddenField ID="HumidData" runat="server" />
    <asp:HiddenField ID="MotionData" runat="server" />

    <div class="row p-3 no-gutters align-items-center">
        <div class="col">
            <div class="h2 font-weight-bold text-white text-center" style="text-shadow: 2px 2px 10px #AAAAAA;">
                Learning Space Analytics Dashboard
            </div>
            <div class="h5 font-weight-light text-gray-200 text-center" style="text-shadow: 2px 2px 10px #AAAAAA;">
                Last Updated: <asp:Label ID="lblLastUpdate" runat="server" Text="-" />
            </div>
        </div>
        <div class="col-12">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" />
        </div>
    </div>

    <div class="row p-3 no-gutters position-fixed fixed-top">
        <div class="col d-flex justify-content-end">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-dark shadow" data-toggle="modal" data-target="#exampleModal">
                <h6 class="m-0 font-weight-bold text-light p-2"><i class="fas fa-filter"></i>&nbsp;&nbsp;Filters</h6>
            </button>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog mw-100 w-75" role="document">
            <div class="modal-content border-0">
                <asp:UpdatePanel ID="upDashboard" runat="server">
                    <ContentTemplate>
                        <div class="modal-header bg-primary">
                            <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <!--Facility Code/Name -->
                                <div class="col-12">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold required">
                                            <label>Facility Code/ Name:</label>
                                        </div>
                                        <div class="col-12">
                                            <asp:DropDownList ID="DdlFacilityCodeName" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlFacilityCodeName_SelectedIndexChanged" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="h6 font-weight-bold text-gray-900 mt-2"><u>Survey Responses</u></div>
                            <div class="row">
                                <!--Option Survey-->
                                <div class="col-2">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold required">
                                            <label>Submitted By:</label>
                                        </div>
                                        <div class="col-12">
                                            <asp:DropDownList ID="DdlSubmittedBy" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlSubmittedBy_SelectedIndexChanged">
                                                <asp:ListItem Text="Student" Value="STU" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Lecturer" Value="LEC"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <!--Questionnaire -->
                                <div class="col-10">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold required">
                                            <label>Questions:</label>
                                        </div>
                                        <div class="col-12">
                                            <asp:DropDownList ID="DdlQuestionnaire" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlQuestionnaire_SelectedIndexChanged" />
                                        </div>
                                    </div>
                                </div>
                                <!--Interval -->
                                <div class="col-12">
                                    <div class="row mt-2 mb-2 d-flex justify-content-center align-content-center">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">From Year:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlFromYear" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">To Year:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlToYear" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">For Semester:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlSemester" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="1 & 2" Value="Both" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="1 Only" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2 Only" Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="h6 font-weight-bold text-gray-900 mt-2"><u>Sensor Data</u></div>
                            <div class="row">
                                <!--Option -->
                                <div class="col-12">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold required">
                                            <label>View By:</label>
                                        </div>
                                        <div class="col-12">
                                            <asp:DropDownList ID="DdlOption" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlOption_SelectedIndexChanged">
                                                <asp:ListItem Text="Module/ Lesson" Value="MODULELESSON"></asp:ListItem>
                                                <asp:ListItem Text="Daily Readings" Value="DAILYREADINGS" Selected="True"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <!--Module Code/Name -->
                                <div class="col-5" id="divModule" runat="server">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold">
                                            <label>Show for Module:</label>
                                        </div>
                                        <div class="col-12">
                                            <asp:DropDownList ID="DdlModuleCodeName" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlModuleCodeName_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <!--Lesson -->
                                <div class="col-7" id="divLesson" runat="server">
                                    <div class="row mt-2 mb-2">
                                        <div class="col-12 text-sm-left text-xs text-dark font-weight-bold">
                                            <label>Show for Lesson:</label>
                                        </div>
                                        <div class="col-sm-12">
                                            <asp:DropDownList ID="DdlLesson" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlLesson_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <!--Interval -->
                                <div class="col-12">
                                    <div class="row mt-2 mb-2 d-flex justify-content-center align-content-center">
                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Show in Intervals of:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlInterval" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="5 min" Value="5" />
                                                    <asp:ListItem Text="10 min" Value="10" />
                                                    <asp:ListItem Text="15 min" Value="15" />
                                                    <asp:ListItem Selected="True" Text="30 min" Value="30" />
                                                    <asp:ListItem Text="60 min" Value="60" />
                                                </asp:DropDownList>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">From Week:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlWeekFrom" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <div class="input-group-append">
                                                    <span class="input-group-text">To Week:</span>
                                                </div>
                                                <asp:DropDownList ID="DdlWeekTo" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button runat="server" ID="BtnGenerateChart" onserverclick="BtnGenerateChart_ServerClick" class="btn btn-success w-100" title="Search">
                                Generate Charts
                            </button>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="BtnGenerateChart" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <div class="row mb-3 p-3">
        <div class="col-lg-12">
            <div class="card h-100 shadow">
                <div class="card-body">
                    <div class="h6 text-primary font-weight-bold">
                        Survey Responses
                    </div>
                    <div class="h1 font-weight-light text-dark">
                        <asp:Label ID="lblMainQns" runat="server"></asp:Label>
                    </div>
                    <div class="row">
                        <div id="SurveyChartCarousel" class="carousel slide col-lg-6 col-md-12 rounded shadow" data-ride="carousel" data-interval="false">
                            <div class="carousel-inner h-100 p-5">
                                <asp:Literal ID="litSurveyResponses" runat="server" />
                            </div>
                            <a class="carousel-control-prev text-primary ml-n4" href="#SurveyChartCarousel" role="button" data-slide="prev">
                                <i class="fas fa-chevron-left fa-3x" aria-hidden="true"></i>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next text-primary mr-n4" href="#SurveyChartCarousel" role="button" data-slide="next">
                                <i class="fas fa-chevron-right fa-3x" aria-hidden="true"></i>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                        <div id="AvgReadingChartCarousel" class="carousel slide col-lg-6 col-md-12 rounded shadow" data-ride="carousel" data-interval="false">
                            <div class="carousel-inner h-100 p-5">
                                <div class="carousel-item active">
                                    <div class="h6 font-weight-bold text-center" style="color: black;">
                                        Average Sound Reading per Academic Year/Sem
                                    </div>
                                    <div class="position-relative">
                                        <canvas id="SoundAvgChart"></canvas>
                                    </div>
                                    <asp:Literal ID="litSoundAvgChartData" runat="server" />
                                </div>
                                <div class="carousel-item">
                                    <div class="h6 font-weight-bold text-center" style="color: black;">
                                        Average Temperature Reading per Academic Year/Sem
                                    </div>
                                    <div class="position-relative">
                                        <canvas id="TempAvgChart"></canvas>
                                    </div>
                                    <asp:Literal ID="litTempAvgChartData" runat="server" />
                                </div>
                                <div class="carousel-item">
                                    <div class="h6 font-weight-bold text-center" style="color: black;">
                                        Average Humidity Reading per Academic Year/Sem
                                    </div>
                                    <div class="position-relative">
                                        <canvas id="HumidAvgChart"></canvas>
                                    </div>
                                    <asp:Literal ID="litHumidAvgChartData" runat="server" />
                                </div>
                            </div>
                            <a class="carousel-control-prev text-primary ml-n4" href="#AvgReadingChartCarousel" role="button" data-slide="prev">
                                <i class="fas fa-chevron-left fa-3x" aria-hidden="true"></i>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next text-primary mr-n4" href="#AvgReadingChartCarousel" role="button" data-slide="next">
                                <i class="fas fa-chevron-right fa-3x" aria-hidden="true"></i>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-3 p-3">
        <div class="col-lg-12">
            <div class="card h-100 shadow">
                <div class="card-body">
                    <div class="h6 text-primary font-weight-bold">
                        Sensor Data
                    </div>
                    <div class="row mb-3 p-3">
                        <div class="col-lg-8">
                            <div id="SensorDataChartCarousel" class="carousel slide col-sm-12 border rounded shadow h-100" data-ride="carousel" data-interval="false">
                                <div class="carousel-inner p-5">
                                    <div class="carousel-item active">
                                        <input type="hidden" id="SoundDataChartPrevSelectedIndex" name="SoundDataChartPrevSelectedIndex" value="">
                                        <div class="row">
                                            <div class="col-12">
                                                <canvas id="SoundDataChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="carousel-item">
                                        <input type="hidden" id="TempDataChartPrevSelectedIndex" name="TempDataChartPrevSelectedIndex" value="">
                                        <div class="row">
                                            <div class="col-12">
                                                <canvas id="TempDataChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="carousel-item">
                                        <input type="hidden" id="HumidDataChartPrevSelectedIndex" name="HumidDataChartPrevSelectedIndex" value="">
                                        <div class="row">
                                            <div class="col-12">
                                                <canvas id="HumidDataChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <a class="carousel-control-prev text-primary ml-n4" href="#SensorDataChartCarousel" role="button" data-slide="prev">
                                    <i class="fas fa-chevron-left fa-3x" aria-hidden="true"></i>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next text-primary mr-n4" href="#SensorDataChartCarousel" role="button" data-slide="next">
                                    <i class="fas fa-chevron-right fa-3x" aria-hidden="true"></i>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card h-100 shadow">
                                <div class="card-body">
                                    <div id="divModules" runat="server">
                                        <asp:Literal ID="litModules" runat="server" />
                                    </div>
                                    <asp:Literal ID="litLessonDetails" runat="server" />
                                    <div id="divLessonDetails" runat="server">
                                        <h5 class="card-title font-weight-bold" style="color: black" id="h5LessonDetails">Lesson Overview</h5>
                                        <h4 class="small font-weight-bold">Attendance Rate <span class="float-right" id="spanAttendanceRatePercentage">Info Unavailable</span></h4>
                                        <div class="progress mb-4">
                                            <div class="progress-bar bg-info" id="divAttendanceRateBar" runat="server" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                                <div class="text-xs font-weight-bold" id="divAttendanceRatePercentage">Info Unavailable</div>
                                            </div>
                                        </div>
                                        <div class="h6 font-weight-bold text-dark mb-4" id="divTopicsCovered"></div>
                                        <h4 class="small font-weight-bold">Remarks</h4>
                                        <div class="h6 font-weight-bold text-dark mb-4" id="divRemarks">-</div>
                                    </div>

                                    <h4 class="small font-weight-bold">Average Noise</h4>
                                    <div><span class="display-4 font-weight-bold text-dark" id="spanAverageNoise" runat="server">0</span><span class="h2 font-weight-bold text-dark">dB</span></div>
                                    <h4 class="small font-weight-bold">Average Temperature</h4>
                                    <div><span class="display-4 font-weight-bold text-dark" id="spanAverageTemp" runat="server">0</span><span class="h2 font-weight-bold text-dark">°C</span></div>
                                    <h4 class="small font-weight-bold">Average Humidity</h4>
                                    <div><span class="display-4 font-weight-bold text-dark" id="spanAverageHumid" runat="server">0</span><span class="h2 font-weight-bold text-dark">%</span></div>
                                    <h4 class="small font-weight-bold">Average Motion</h4>
                                    <div><span class="display-4 font-weight-bold text-dark" id="spanAverageMotion" runat="server">0</span><span class="h2 font-weight-bold text-dark">%</span></div>
                                    <div id="divLecturers" runat="server">
                                        <asp:Literal ID="litLecturers" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            const SoundData = JSON.parse($("[id*=SoundData]").val());
            const TempData = JSON.parse($("[id*=TempData]").val());
            const HumidData = JSON.parse($("[id*=HumidData]").val());
            $("#SoundDataChartPrevSelectedIndex").val("");

            var subtitle = "";
            if ($("[id*=DdlOption] :selected").text() == "Daily Readings") {
                subtitle = "Daily Weekday Readings from Week " + $("[id*=DdlWeekFrom] :selected").text() + ' to Week ' + $("[id*=DdlWeekTo] :selected").text();
            } else if ($("[id*=DdlOption] :selected").text() == "Module/ Lesson") {
                subtitle = $("[id*=DdlModuleCodeName] :selected").text() + ', ' + $("[id*=DdlLesson] :selected").text();
            }
            DisplaySoundChart('SoundDataChart', 'Noise Level in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, SoundData.labels, SoundData.datasets);
            DisplayTempChart('TempDataChart', 'Temperature in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, TempData.labels, TempData.datasets);
            DisplayHumidChart('HumidDataChart', 'Humidity in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, HumidData.labels, HumidData.datasets);

            $("[id*='SurveyChartCanvas']").each(function () {
                var qnstype = this.id.split("_")[0];
                //for QUAL, QUAN, CUSTOMEVER, CUSTOMWILL, FACTORSTU, FACTORLEC
                var qnsid = this.id.split("_")[2];
                var MainSurveyChartData = JSON.parse($("#" + qnstype + "_MainSurveyChartData_" + qnsid).val());
                DisplayMainSurveyChart(this.id, MainSurveyChartData.labels, MainSurveyChartData.datasets, 'Survey Responses on ' + $("[id*=DdlFacilityCodeName] :selected").text());
            });

            const SoundAvgChartData = JSON.parse($("[id*=SoundAvgChartData]").val());
            const TempAvgChartData = JSON.parse($("[id*=TempAvgChartData]").val());
            const HumidAvgChartData = JSON.parse($("[id*=HumidAvgChartData]").val());
            DisplayAvgChart('SoundAvgChart', SoundAvgChartData.labels, SoundAvgChartData.datasets, 'Avg Sound Level (dB)', 'Sound Level (dB)');
            DisplayAvgChart('TempAvgChart', TempAvgChartData.labels, TempAvgChartData.datasets, 'Avg Temperature (°C)', 'Temperature (°C)');
            DisplayAvgChart('HumidAvgChart', HumidAvgChartData.labels, HumidAvgChartData.datasets, 'Avg Humidity (%)', 'Humidity (%)');
        });

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            const SoundData = JSON.parse($("[id*=SoundData]").val());
            const TempData = JSON.parse($("[id*=TempData]").val());
            const HumidData = JSON.parse($("[id*=HumidData]").val());
            $("#SoundDataChartPrevSelectedIndex").val("");

            var subtitle = "";
            if ($("[id*=DdlOption] :selected").text() == "Daily Readings") {
                subtitle = "Daily Weekday Readings from Week " + $("[id*=DdlWeekFrom] :selected").text() + ' to Week ' + $("[id*=DdlWeekTo] :selected").text();
            } else if ($("[id*=DdlOption] :selected").text() == "Module/ Lesson") {
                subtitle = $("[id*=DdlModuleCodeName] :selected").text() + ', ' + $("[id*=DdlLesson] :selected").text();
            }
            DisplaySoundChart('SoundDataChart', 'Noise Level in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, SoundData.labels, SoundData.datasets);
            DisplayTempChart('TempDataChart', 'Temperature in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, TempData.labels, TempData.datasets);
            DisplayHumidChart('HumidDataChart', 'Humidity in ' + $("[id*=DdlFacilityCodeName] :selected").text(), subtitle, HumidData.labels, HumidData.datasets);

            $("[id*='SurveyChartCanvas']").each(function () {
                var qnstype = this.id.split("_")[0];
                //for QUAL, QUAN, CUSTOMEVER, CUSTOMWILL, FACTORSTU, FACTORLEC
                var qnsid = this.id.split("_")[2];
                var MainSurveyChartData = JSON.parse($("#" + qnstype + "_MainSurveyChartData_" + qnsid).val());
                DisplayMainSurveyChart(this.id, MainSurveyChartData.labels, MainSurveyChartData.datasets, 'Survey Responses on ' + $("[id*=DdlFacilityCodeName] :selected").text());
            });

            const SoundAvgChartData = JSON.parse($("[id*=SoundAvgChartData]").val());
            const TempAvgChartData = JSON.parse($("[id*=TempAvgChartData]").val());
            const HumidAvgChartData = JSON.parse($("[id*=HumidAvgChartData]").val());
            DisplayAvgChart('SoundAvgChart', SoundAvgChartData.labels, SoundAvgChartData.datasets, 'Avg Sound Level (dB)', 'Sound Level (dB)');
            DisplayAvgChart('TempAvgChart', TempAvgChartData.labels, TempAvgChartData.datasets, 'Avg Temperature (°C)', 'Temperature (°C)');
            DisplayAvgChart('HumidAvgChart', HumidAvgChartData.labels, HumidAvgChartData.datasets, 'Avg Humidity (%)', 'Humidity (%)');
        });

        function DisplaySoundChart(chartid, title, subtitle, labels, datasets) {
            var defaultLegendClickHandler = Chart.defaults.plugins.legend.onClick;
            var pieDoughnutLegendClickHandler = Chart.controllers.doughnut.overrides.plugins.legend.onClick;

            var OnClick = function (e, legendItem, legend) {
                const CurrSelectedIndex = legendItem.datasetIndex;
                const SoundDataChartPrevSelectedIndex = $("#SoundDataChartPrevSelectedIndex").val();
                var FocusOnWeek = true;
                var NotSelectedFromAnotherIndex = true;
                if (SoundDataChartPrevSelectedIndex == "") {
                    $("#SoundDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                } else {
                    if (SoundDataChartPrevSelectedIndex == CurrSelectedIndex) {
                        $("#SoundDataChartPrevSelectedIndex").val("");
                        FocusOnWeek = false;
                    }
                    else {
                        NotSelectedFromAnotherIndex = false;
                    }
                }

                const ci = legend.chart;

                legend.legendItems.forEach((element) => {
                    var index = element.datasetIndex;
                    if (index != CurrSelectedIndex) {
                        if (ci.isDatasetVisible(index)) {
                            ci.hide(index);
                        } else {
                            if (NotSelectedFromAnotherIndex) {
                                ci.show(index);
                                element.hidden = false;
                            }
                        }
                    } else {
                        ci.show(index);
                        element.hidden = false;
                    }
                });

                if (!NotSelectedFromAnotherIndex) {
                    $("#SoundDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                }

                if (FocusOnWeek) {
                    var WeekNo = legendItem.text.split(" ")[1];
                    var LessonDetailsData = JSON.parse($("#LessonDetailsData").val());
                    var LessonDetails = LessonDetailsData[WeekNo];

                    var backgroundColor = 'bg-success';
                    if (LessonDetails.difficulty == "Medium") {
                        backgroundColor = "bg-warning";
                    }
                    if (LessonDetails.difficulty == "Hard") {
                        backgroundColor = "bg-danger";
                    }
                    if (LessonDetails.difficulty == "Not Applicable") {
                        backgroundColor = "bg-info";
                    }

                    var TopicsCoveredHTMLMarkup = '<h4 class="small font-weight-bold text-muted">Topic(s) Covered</h4>' + LessonDetails.topic
                    var TopicDifficultyHTMLMarkup = '<h4 class=\"small font-weight-bold text-muted mt-2">Topic Difficulty <span class="float-right">' + LessonDetails.difficulty + '</span></h4><div class="progress mb-4"><div class="progress-bar ' + backgroundColor + '"style="width:100%" role="progressbar" aria-valuemin="0" aria-valuemax="100"><div class="text-xs font-weight-bold">' + LessonDetails.difficulty + '</div></div></div>';

                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (' + legendItem.text + ')';
                    document.querySelector("#divTopicsCovered").innerHTML = TopicsCoveredHTMLMarkup + TopicDifficultyHTMLMarkup;
                    document.querySelector("#divRemarks").innerHTML = LessonDetails.remark;
                    document.querySelector("#spanAverageNoise").innerHTML = LessonDetails.averageNoise;
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = LessonDetails.attendanceRate.toString() + "%";
                    $("#divLecturers").hide();
                }
                else {
                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (All Weeks)';
                    document.querySelector("#divTopicsCovered").innerHTML = '';
                    document.querySelector("#divRemarks").innerHTML = '-';
                    document.querySelector("#spanAverageNoise").innerHTML = '68';
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = "93%";
                    $("#divLecturers").show();
                }
            };

            const HueCircle19 = ['#1ba3c6', '#2cb5c0', '#30bcad', '#21B087', '#33a65c', '#57a337', '#a2b627', '#d5bb21', '#f8b620', '#f89217', '#f06719', '#e03426', '#f64971', '#fc719e', '#eb73b3', '#ce69be', '#a26dc2', '#7873c0', '#4f7cba'];

            const footer = (tooltipItems) => {
                let sum = 0;
                let totalItems = tooltipItems.length;

                tooltipItems.forEach(function (tooltipItem) {
                    sum += tooltipItem.parsed.y;
                    if (tooltipItem.parsed.y == 0) {
                        //Exclude outlier from calculation of average
                        totalItems -= 1;
                    }
                });

                let average = 0;
                if (totalItems != 0) {
                    average = (sum / totalItems).toFixed(1)
                }
                return '________________\n(Excluding outliers)\nAverage: ' + average + ' dB';
            };

            datasets.forEach((element) => {
                var color = HueCircle19[datasets.indexOf(element)];
                element.backgroundColor = color;
                element.borderColor = color;
                element.borderWidth = 2;
                element.radius = 0;
                element.fill = false;
                element.pointBackgroundColor = color;
            });


            var config = {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    scales: {
                        y: {
                            suggestedMin: 60,
                            suggestedMax: 84,
                            title: {
                                display: true,
                                text: 'Sound Level (dB)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                stepSize: 2
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Timestamp (24 Hr)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            }
                        }

                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                footer: footer,
                            }
                        },
                        title: {
                            display: true,
                            text: title,
                            font: {
                                family: 'Nunito',
                                size: 20,
                                weight: 'bolder'
                            },
                            color: 'black',
                            padding: 10
                        },
                        subtitle: {
                            display: true,
                            text: subtitle,
                            font: {
                                family: 'Nunito',
                                size: 14,
                                weight: 'normal'
                            },
                            color: 'grey',
                            padding: 10
                        },
                        legend: {
                            display: true,
                            onClick: OnClick
                        },
                        annotation: {
                            annotations: {
                                line1: {
                                    type: 'line',
                                    label: {
                                        backgroundColor: 'rgba(255, 0, 0, 0.4)',
                                        content: 'Unhealthy >= 78 dB',
                                        enabled: true,
                                        font: {
                                            family: 'Nunito',
                                            size: 12,
                                            weight: 'bolder'
                                        },
                                        position: 'center',
                                        textAlign: 'center',
                                        yAdjust: -10
                                    },
                                    yMin: 78,
                                    yMax: 78,
                                    borderColor: 'rgba(255, 0, 0, 0.4)',
                                    borderWidth: 2,
                                    borderDash: [5, 5]
                                },
                                box1: {
                                    type: 'box',
                                    yMin: 78,
                                    yMax: 100,
                                    backgroundColor: 'rgba(255, 0, 0, 0.1)',
                                    borderColor: 'rgba(255, 0, 0, 0.1)'
                                }
                            }
                        }
                    }
                }
            };

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }

            var ctx = document.getElementById(chartid);
            var newChart = new Chart(
                ctx,
                config
            );
        }

        function DisplayTempChart(chartid, title, subtitle, labels, datasets) {
            var defaultLegendClickHandler = Chart.defaults.plugins.legend.onClick;
            var pieDoughnutLegendClickHandler = Chart.controllers.doughnut.overrides.plugins.legend.onClick;

            var OnClick = function (e, legendItem, legend) {
                const CurrSelectedIndex = legendItem.datasetIndex;
                const TempDataChartPrevSelectedIndex = $("#TempDataChartPrevSelectedIndex").val();
                var FocusOnWeek = true;
                var NotSelectedFromAnotherIndex = true;
                if (TempDataChartPrevSelectedIndex == "") {
                    $("#TempDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                } else {
                    if (TempDataChartPrevSelectedIndex == CurrSelectedIndex) {
                        $("#TempDataChartPrevSelectedIndex").val("");
                        FocusOnWeek = false;
                    }
                    else {
                        NotSelectedFromAnotherIndex = false;
                    }
                }

                const ci = legend.chart;

                legend.legendItems.forEach((element) => {
                    var index = element.datasetIndex;
                    if (index != CurrSelectedIndex) {
                        if (ci.isDatasetVisible(index)) {
                            ci.hide(index);
                        } else {
                            if (NotSelectedFromAnotherIndex) {
                                ci.show(index);
                                element.hidden = false;
                            }
                        }
                    } else {
                        ci.show(index);
                        element.hidden = false;
                    }
                });

                if (!NotSelectedFromAnotherIndex) {
                    $("#TempDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                }

                if (FocusOnWeek) {
                    var WeekNo = legendItem.text.split(" ")[1];
                    var LessonDetailsData = JSON.parse($("#LessonDetailsData").val());
                    var LessonDetails = LessonDetailsData[WeekNo];

                    var backgroundColor = 'bg-success';
                    if (LessonDetails.difficulty == "Medium") {
                        backgroundColor = "bg-warning";
                    }
                    if (LessonDetails.difficulty == "Hard") {
                        backgroundColor = "bg-danger";
                    }
                    if (LessonDetails.difficulty == "Not Applicable") {
                        backgroundColor = "bg-info";
                    }

                    var TopicsCoveredHTMLMarkup = '<h4 class="small font-weight-bold text-muted">Topic(s) Covered</h4>' + LessonDetails.topic
                    var TopicDifficultyHTMLMarkup = '<h4 class=\"small font-weight-bold text-muted mt-2">Topic Difficulty <span class="float-right">' + LessonDetails.difficulty + '</span></h4><div class="progress mb-4"><div class="progress-bar ' + backgroundColor + '"style="width:100%" role="progressbar" aria-valuemin="0" aria-valuemax="100"><div class="text-xs font-weight-bold">' + LessonDetails.difficulty + '</div></div></div>';

                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (' + legendItem.text + ')';
                    document.querySelector("#divTopicsCovered").innerHTML = TopicsCoveredHTMLMarkup + TopicDifficultyHTMLMarkup;
                    document.querySelector("#divRemarks").innerHTML = LessonDetails.remark;
                    document.querySelector("#spanAverageNoise").innerHTML = LessonDetails.averageNoise;
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = LessonDetails.attendanceRate.toString() + "%";
                    $("#divLecturers").hide();
                }
                else {
                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (All Weeks)';
                    document.querySelector("#divTopicsCovered").innerHTML = '';
                    document.querySelector("#divRemarks").innerHTML = '-';
                    document.querySelector("#spanAverageNoise").innerHTML = '68';
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = "93%";
                    $("#divLecturers").show();
                }
            };

            const HueCircle19 = ['#1ba3c6', '#2cb5c0', '#30bcad', '#21B087', '#33a65c', '#57a337', '#a2b627', '#d5bb21', '#f8b620', '#f89217', '#f06719', '#e03426', '#f64971', '#fc719e', '#eb73b3', '#ce69be', '#a26dc2', '#7873c0', '#4f7cba'];

            const footer = (tooltipItems) => {
                let sum = 0;
                let totalItems = tooltipItems.length;

                tooltipItems.forEach(function (tooltipItem) {
                    sum += tooltipItem.parsed.y;
                    if (tooltipItem.parsed.y == 0) {
                        //Exclude outlier from calculation of average
                        totalItems -= 1;
                    }
                });

                let average = 0;
                if (totalItems != 0) {
                    average = (sum / totalItems).toFixed(1)
                }
                return '________________\n(Excluding outliers)\nAverage: ' + average + ' °C';
            };

            datasets.forEach((element) => {
                var color = HueCircle19[datasets.indexOf(element)];
                element.backgroundColor = color;
                element.borderColor = color;
                element.borderWidth = 2;
                element.radius = 0;
                element.fill = false;
                element.pointBackgroundColor = color;
            });


            var config = {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    scales: {
                        y: {
                            suggestedMin: 18,
                            suggestedMax: 25,
                            title: {
                                display: true,
                                text: 'Temperature (°C)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                stepSize: 0.5
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Timestamp (24 Hr)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            }
                        }

                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                footer: footer,
                            }
                        },
                        title: {
                            display: true,
                            text: title,
                            font: {
                                family: 'Nunito',
                                size: 20,
                                weight: 'bolder'
                            },
                            color: 'black',
                            padding: 10
                        },
                        subtitle: {
                            display: true,
                            text: subtitle,
                            font: {
                                family: 'Nunito',
                                size: 14,
                                weight: 'normal'
                            },
                            color: 'grey',
                            padding: 10
                        },
                        legend: {
                            display: true,
                            onClick: OnClick
                        }
                    }
                }
            };

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }

            var ctx = document.getElementById(chartid);
            var newChart = new Chart(
                ctx,
                config
            );
        }

        function DisplayHumidChart(chartid, title, subtitle, labels, datasets) {
            var defaultLegendClickHandler = Chart.defaults.plugins.legend.onClick;
            var pieDoughnutLegendClickHandler = Chart.controllers.doughnut.overrides.plugins.legend.onClick;

            var OnClick = function (e, legendItem, legend) {
                const CurrSelectedIndex = legendItem.datasetIndex;
                const HumidDataChartPrevSelectedIndex = $("#HumidDataChartPrevSelectedIndex").val();
                var FocusOnWeek = true;
                var NotSelectedFromAnotherIndex = true;
                if (HumidDataChartPrevSelectedIndex == "") {
                    $("#HumidDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                } else {
                    if (HumidDataChartPrevSelectedIndex == CurrSelectedIndex) {
                        $("#HumidDataChartPrevSelectedIndex").val("");
                        FocusOnWeek = false;
                    }
                    else {
                        NotSelectedFromAnotherIndex = false;
                    }
                }

                const ci = legend.chart;

                legend.legendItems.forEach((element) => {
                    var index = element.datasetIndex;
                    if (index != CurrSelectedIndex) {
                        if (ci.isDatasetVisible(index)) {
                            ci.hide(index);
                        } else {
                            if (NotSelectedFromAnotherIndex) {
                                ci.show(index);
                                element.hidden = false;
                            }
                        }
                    } else {
                        ci.show(index);
                        element.hidden = false;
                    }
                });

                if (!NotSelectedFromAnotherIndex) {
                    $("#HumidDataChartPrevSelectedIndex").val(CurrSelectedIndex);
                }

                if (FocusOnWeek) {
                    var WeekNo = legendItem.text.split(" ")[1];
                    var LessonDetailsData = JSON.parse($("#LessonDetailsData").val());
                    var LessonDetails = LessonDetailsData[WeekNo];

                    var backgroundColor = 'bg-success';
                    if (LessonDetails.difficulty == "Medium") {
                        backgroundColor = "bg-warning";
                    }
                    if (LessonDetails.difficulty == "Hard") {
                        backgroundColor = "bg-danger";
                    }
                    if (LessonDetails.difficulty == "Not Applicable") {
                        backgroundColor = "bg-info";
                    }

                    var TopicsCoveredHTMLMarkup = '<h4 class="small font-weight-bold text-muted">Topic(s) Covered</h4>' + LessonDetails.topic
                    var TopicDifficultyHTMLMarkup = '<h4 class=\"small font-weight-bold text-muted mt-2">Topic Difficulty <span class="float-right">' + LessonDetails.difficulty + '</span></h4><div class="progress mb-4"><div class="progress-bar ' + backgroundColor + '"style="width:100%" role="progressbar" aria-valuemin="0" aria-valuemax="100"><div class="text-xs font-weight-bold">' + LessonDetails.difficulty + '</div></div></div>';

                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (' + legendItem.text + ')';
                    document.querySelector("#divTopicsCovered").innerHTML = TopicsCoveredHTMLMarkup + TopicDifficultyHTMLMarkup;
                    document.querySelector("#divRemarks").innerHTML = LessonDetails.remark;
                    document.querySelector("#spanAverageNoise").innerHTML = LessonDetails.averageNoise;
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = LessonDetails.attendanceRate.toString() + "%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = LessonDetails.attendanceRate.toString() + "%";
                    $("#divLecturers").hide();
                }
                else {
                    document.querySelector("#h5LessonDetails").innerHTML = 'Lesson Overview (All Weeks)';
                    document.querySelector("#divTopicsCovered").innerHTML = '';
                    document.querySelector("#divRemarks").innerHTML = '-';
                    document.querySelector("#spanAverageNoise").innerHTML = '68';
                    document.querySelector("#spanAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("#divAttendanceRatePercentage").innerHTML = "93%";
                    document.querySelector("[id*=divAttendanceRateBar]").style.width = "93%";
                    $("#divLecturers").show();
                }
            };

            const HueCircle19 = ['#1ba3c6', '#2cb5c0', '#30bcad', '#21B087', '#33a65c', '#57a337', '#a2b627', '#d5bb21', '#f8b620', '#f89217', '#f06719', '#e03426', '#f64971', '#fc719e', '#eb73b3', '#ce69be', '#a26dc2', '#7873c0', '#4f7cba'];

            const footer = (tooltipItems) => {
                let sum = 0;
                let totalItems = tooltipItems.length;

                tooltipItems.forEach(function (tooltipItem) {
                    sum += tooltipItem.parsed.y;
                    if (tooltipItem.parsed.y == 0) {
                        //Exclude outlier from calculation of average
                        totalItems -= 1;
                    }
                });

                let average = 0;
                if (totalItems != 0) {
                    average = (sum / totalItems).toFixed(1)
                }
                return '________________\n(Excluding outliers)\nAverage: ' + average + ' %';
            };

            datasets.forEach((element) => {
                var color = HueCircle19[datasets.indexOf(element)];
                element.backgroundColor = color;
                element.borderColor = color;
                element.borderWidth = 2;
                element.radius = 0;
                element.fill = false;
                element.pointBackgroundColor = color;
            });


            var config = {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    scales: {
                        y: {
                            min: 0,
                            suggestedMin: 50,
                            max: 100,
                            title: {
                                display: true,
                                text: 'Humidity (%)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                stepSize: 10
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Timestamp (24 Hr)',
                                font: {
                                    family: 'Nunito',
                                    size: 20,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            }
                        }

                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                footer: footer,
                            }
                        },
                        title: {
                            display: true,
                            text: title,
                            font: {
                                family: 'Nunito',
                                size: 20,
                                weight: 'bolder'
                            },
                            color: 'black',
                            padding: 10
                        },
                        subtitle: {
                            display: true,
                            text: subtitle,
                            font: {
                                family: 'Nunito',
                                size: 14,
                                weight: 'normal'
                            },
                            color: 'grey',
                            padding: 10
                        },
                        legend: {
                            display: true,
                            onClick: OnClick
                        }
                    }
                }
            };

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }

            var ctx = document.getElementById(chartid);
            var newChart = new Chart(
                ctx,
                config
            );
        }

        function DisplaySubSurveyChart(chartid, labels, datasets, title) {
            const onClick = function clickHandler(evt) {
                const points = evt.chart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, true);
                if (points.length) {
                    const firstPoint = points[0];
                    //labelOption = evt.chart.data.datasets[firstPoint.datasetIndex].label; //useful if chart is multiseries pie
                    var label = evt.chart.data.labels[firstPoint.index];
                    var value = evt.chart.data.datasets[firstPoint.datasetIndex].data[firstPoint.index];
                    //alert(label + ": " + value);
                }

                var MainChartId = [evt.chart.canvas.id.split("_")[0], 'MainSurveyChartData', evt.chart.canvas.id.split("_")[2]].join('_');
                var MainSurveyChartData = JSON.parse($("#" + MainChartId).val());

                var thisid = evt.chart.canvas.id;
                evt.chart.destroy();
                DisplayMainSurveyChart(thisid, MainSurveyChartData.labels, MainSurveyChartData.datasets, 'Survey Responses on ' + $("[id*=DdlFacilityCodeName] :selected").text());
            };

            if (datasets) {
                datasets[0].backgroundColor = ['#ff7f01', '#1cade4', '#da5af4', '#f1b015', '#d2c2f1', '#9d09d1'];
            }

            const data = {
                //labels: ['Overall Yay', 'Overall Nay', 'Overall Z', 'Group A Yay', 'Group A Nay', 'Group A Z', 'Group B Yay', 'Group B Nay', 'Group B Z', 'Group C Yay', 'Group C Nay', 'Group C Z'],
                //datasets: [
                //    {
                //        backgroundColor: ['#AAA', '#777', '#EEE'],
                //        data: [21, 70, 9]
                //    },
                //    {
                //        backgroundColor: ['hsl(0, 100%, 60%)', 'hsl(0, 100%, 35%)', 'hsl(0, 100%, 85%)'],
                //        data: [33, 57, 10]
                //    },
                //    {
                //        backgroundColor: ['hsl(100, 100%, 60%)', 'hsl(100, 100%, 35%)', 'hsl(100, 100%, 85%)'],
                //        data: [20, 40, 40]
                //    },
                //    {
                //        backgroundColor: ['hsl(180, 100%, 60%)', 'hsl(180, 100%, 35%)', 'hsl(180, 100%, 85%)'],
                //        data: [10, 75, 15]
                //    }
                //]
                labels: labels,
                datasets: datasets
            };

            const config = {
                type: 'pie',
                data: data,
                options: {
                    onClick: onClick,
                    responsive: true,
                    plugins: {
                        //legend: {
                        //    labels: {
                        //        generateLabels: function (chart) {
                        //            // Get the default label list
                        //            const original = Chart.overrides.pie.plugins.legend.labels.generateLabels;
                        //            const labelsOriginal = original.call(this, chart);

                        //            // Build an array of colors used in the datasets of the chart
                        //            var datasetColors = chart.data.datasets.map(function (e) {
                        //                return e.backgroundColor;
                        //            });
                        //            datasetColors = datasetColors.flat();

                        //            // Modify the color and hide state of each label
                        //            labelsOriginal.forEach(label => {
                        //                // There are thrice as many labels as there are datasets. This converts the label index into the corresponding dataset index
                        //                label.datasetIndex = (label.index - label.index % 3) / 3;

                        //                // The hidden state must match the dataset's hidden state
                        //                label.hidden = !chart.isDatasetVisible(label.datasetIndex);

                        //                // Change the color to match the dataset
                        //                label.fillStyle = datasetColors[label.index];
                        //            });

                        //            return labelsOriginal;
                        //        }
                        //    },
                        //    onClick: function (mouseEvent, legendItem, legend) {
                        //        // toggle the visibility of the dataset from what it currently is
                        //        legend.chart.getDatasetMeta(
                        //            legendItem.datasetIndex
                        //        ).hidden = legend.chart.isDatasetVisible(legendItem.datasetIndex);
                        //        legend.chart.update();
                        //    }
                        //},
                        tooltip: {
                            callbacks: {
                                label: function (context) {
                                    const labelIndex = (context.datasetIndex * 3) + context.dataIndex;
                                    return context.chart.data.labels[labelIndex] + ': ' + context.formattedValue;
                                }
                            }
                        },
                        title: {
                            display: true,
                            text: title,
                            font: {
                                family: 'Nunito',
                                size: 15,
                                weight: 'normal'
                            },
                            color: 'black',
                            padding: 10,
                            position: 'left'
                        },
                        datalabels: {
                            font: {
                                family: 'Nunito',
                                size: 20,
                                weight: 'bolder'
                            },
                            display: function (context) {
                                return context.dataset.data[context.dataIndex] !== 0; // or >= 1 or ...
                            },
                            anchor: 'center',
                            color: 'white',
                            formatter: function (value, context) {
                                var sum = context.dataset.data.reduce((a, b) => a + b, 0);
                                return context.chart.data.labels[context.dataIndex] + ":\n" + (value / sum * 100).toFixed(1) + "%";
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels]
            }

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }

            var ctx = document.getElementById(chartid);
            var newchart = new Chart(
                ctx,
                config
            );
        }

        function DisplayMainSurveyChart(chartid, labels, datasets, subtitle) {
            var qnstype = chartid.split("_")[0];
            let QUAL_QUAN = ['#d7191c', '#fdae61', '#a6d96a', '#66bd63'], //4
                CUSTOMEVER_CUSTOMWILL = ['#ffffcc', '#a1dab4', '#41b6c4', '#2c7fb8', '#253494'], //5
                FACTORSTU_FACTORLEC = ['#4f6980', '#849db1', '#a2ceaa', '#638b66', '#bfbb60', '#f47942', '#fbb04e', '#b66353', '#d7ce9f', '#b9aa97', '#7e756d'], //11
                OPEN = ['#4E79A7', '#A0CBE8', '#F28E2B', '#FFBE7D', '#59A14F', '#8CD17D', '#B6992D', '#F1CE63', '#499894', '#86BCB6', '#E15759', '#FF9D9A', '#79706E', '#BAB0AC', '#D37295', '#FABFD2', '#B07AA1', '#D4A6C8', '#9D7660', '#D7B5A6']; //As Many As Possible

            if (qnstype == "QUAL" || qnstype == "QUAN") {
                datasets.forEach((element) => {
                    var color = QUAL_QUAN[datasets.indexOf(element)];
                    element.backgroundColor = color;
                });
            }
            if (qnstype == "CUSTOMEVER" || qnstype == "CUSTOMWILL") {
                datasets.forEach((element) => {
                    var color = CUSTOMEVER_CUSTOMWILL[datasets.indexOf(element)];
                    element.backgroundColor = color;
                });
            }
            if (qnstype == "FACTORSTU" || qnstype == "FACTORLEC") {
                datasets.forEach((element) => {
                    var color = FACTORSTU_FACTORLEC[datasets.indexOf(element)];
                    element.backgroundColor = color;
                });
            }
            if (qnstype == "OPEN") {
                datasets.forEach((element) => {
                    var color = OPEN[datasets.indexOf(element)];
                    element.backgroundColor = color;
                });
            }

            const onClick = function clickHandler(evt) {
                const points = evt.chart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, true);
                var labelOption = "";
                if (points.length) {
                    const firstPoint = points[0];
                    labelOption = evt.chart.data.datasets[firstPoint.datasetIndex].label;
                    var label = evt.chart.data.labels[firstPoint.index];
                    var value = evt.chart.data.datasets[firstPoint.datasetIndex].data[firstPoint.index];
                }

                var SubChartId = [labelOption.replace(/\s+/g, ''), evt.chart.canvas.id.split("_")[0], 'SubSurveyChartData', evt.chart.canvas.id.split("_")[2]].join('_');
                var SubSurveyChartData = JSON.parse($("#" + SubChartId).val());

                var thisid = evt.chart.canvas.id;
                evt.chart.destroy();
                DisplaySubSurveyChart(thisid, SubSurveyChartData.labels, SubSurveyChartData.datasets, labelOption);
            };

            const config = {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    onClick: onClick,
                    plugins: {
                        subtitle: {
                            display: true,
                            text: subtitle,
                            font: {
                                family: 'Nunito',
                                size: 14,
                                weight: 'normal'
                            },
                            color: 'grey',
                            padding: 10
                        },
                        datalabels: {
                            font: {
                                family: 'Nunito',
                                size: 15,
                                weight: 'bolder'
                            },
                            display: function (context) {
                                return context.dataset.data[context.dataIndex] !== 0; // or >= 1 or ...
                            },
                            anchor: 'center',
                            color: 'white',
                            formatter: function (value, context) {
                                var total = 0;
                                context.chart.data.datasets.forEach((element) => {
                                    total += element.data[context.dataIndex];
                                });
                                return `${(value / total * 100).toFixed(1)}%`;

                                //For datasets whose data is represented as one whole list
                                //var sum = context.dataset.data.reduce((a, b) => a + b, 0);
                                //return (value / sum * 100).toFixed(0) + "%";
                            }
                        }
                    },
                    responsive: true,
                    maintainAspectRatio: true,
                    aspectRatio: 1,
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Academic Year/Sem',
                                font: {
                                    family: 'Nunito',
                                    size: 15,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                font: {
                                    family: 'Nunito',
                                    size: 15,
                                    weight: 'bolder'
                                },
                                color: 'black',
                            }
                        },
                        y: {
                            stacked: true,
                            min: 0,
                            suggestedMax: 20,
                            title: {
                                display: true,
                                text: 'No. of Responses',
                                font: {
                                    family: 'Nunito',
                                    size: 15,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                stepSize: 5
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels]
            };

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }

            var ctx = document.getElementById(chartid);
            var newChart = new Chart(
                ctx,
                config
            );
        }

        function DisplayAvgChart(chartid, labels, datasets, datasetLabel, yScaleTitle) {
            const borderPlugin = {
                id: 'chartAreaBorder',
                beforeDraw(chart, args, options) {
                    const { ctx, chartArea: { left, top, width, height } } = chart;
                    if (chart.options.plugins.zoom.zoom.wheel.enabled) {
                        ctx.save();
                        ctx.strokeStyle = 'black';
                        ctx.lineWidth = 2;
                        ctx.strokeRect(left, top, width, height);
                        ctx.restore();
                    }
                }
            };

            const zoomOptions = {
                limits: {
                    y: { min: 'original', max: 'original' }
                },
                pan: {
                    enabled: true,
                    mode: 'xy',
                },
                zoom: {
                    wheel: {
                        enabled: false,
                    },
                    pinch: {
                        enabled: false
                    },
                    mode: 'xy',
                }
            };

            const SoundZoomYLimit = { min: 0, max: 100, minRange: 20 };
            const TempZoomYLimit = { min: 10, max: 40, minRange: 20 };
            const HumidZoomYLimit = { min: 0, max: 100, minRange: 20 };

            const SoundAnnotation = {
                line1: {
                    type: 'line',
                    label: {
                        backgroundColor: 'rgba(255, 0, 0, 0.4)',
                        content: 'Unhealthy >= 78 dB',
                        enabled: true,
                        font: {
                            family: 'Nunito',
                            size: 12,
                            weight: 'bold'
                        },
                        position: 'center',
                        textAlign: 'center',
                        yAdjust: -10
                    },
                    yMin: 78,
                    yMax: 78,
                    borderColor: 'rgba(255, 0, 0, 0.4)',
                    borderWidth: 2,
                    borderDash: [5, 5]
                },
                box1: {
                    type: 'box',
                    yMin: 78,
                    yMax: 100,
                    backgroundColor: 'rgba(255, 0, 0, 0.1)',
                    borderColor: 'rgba(255, 0, 0, 0.1)'
                }
            };

            //There should only be 1 dataset
            datasets[0].label = datasetLabel;
            datasets[0].backgroundColor = '#a6d96a';

            const data = {
                // define label tree
                labels: labels,
                datasets: datasets
            };

            const config = {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    aspectRatio: 1,
                    plugins: {
                        datalabels: {
                            display: function (context) {
                                return context.dataset.data[context.dataIndex] !== 0; // or >= 1 or ...
                            },
                            color: 'black',
                            anchor: 'end',
                            font: {
                                family: 'Nunito',
                                size: 15,
                                weight: 'bold'
                            }
                        },
                        zoom: {
                            limits: {
                                y: function () {
                                    if (chartid.includes("Sound")) {
                                        return SoundZoomYLimit;
                                    } else if (chartid.includes("Temp")) {
                                        return TempZoomYLimit;
                                    } else if (chartid.includes("Humid")) {
                                        return HumidZoomYLimit;
                                    }
                                }
                            },
                            pan: {
                                enabled: true,
                                mode: 'xy',
                            },
                            zoom: zoomOptions
                        },
                        legend: {
                            position: 'top',
                        },
                        annotation: {
                            annotations: function () {
                                if (chartid.includes("Sound")) {
                                    return SoundAnnotation;
                                }
                                else {
                                    return null;
                                }
                            }
                        }
                    },
                    layout: {
                        padding: {
                            // add more space at the bottom for the hierarchy
                            bottom: 100,
                        },
                    },
                    scales: {
                        y: {
                            suggestedMin: chartid.includes("Sound") ? 60 : (chartid.includes("Temp") ? 15 : 0),
                            suggestedMax: chartid.includes("Sound") ? 96 : (chartid.includes("Temp") ? 40 : 100),
                            title: {
                                display: true,
                                text: yScaleTitle,
                                font: {
                                    family: 'Nunito',
                                    size: 15,
                                    weight: 'bolder'
                                },
                                color: 'black',
                                padding: 10
                            },
                            ticks: {
                                stepSize: chartid.includes("Sound") ? 10 : (chartid.includes("Humid") ? 20 : 5)
                            }
                        },
                        x: {
                            type: 'hierarchical',
                            ticks: {
                                font: {
                                    family: 'Nunito',
                                    size: 12,
                                    weight: 'bold'
                                },
                                color: 'black',
                            }
                        }
                    },
                    onClick(e) {
                        const chart = e.chart;
                        chart.options.plugins.zoom.zoom.wheel.enabled = !chart.options.plugins.zoom.zoom.wheel.enabled;
                        chart.options.plugins.zoom.zoom.pinch.enabled = !chart.options.plugins.zoom.zoom.pinch.enabled;
                        chart.update();
                    }
                },
                plugins: [borderPlugin, ChartDataLabels]
            };

            var oldChart = Chart.getChart(chartid);
            if (oldChart) {
                oldChart.destroy();
            }
            var ctx = document.getElementById(chartid);
            var newChart = new Chart(
                ctx,
                config
            );
        }

    </script>
</asp:Content>
