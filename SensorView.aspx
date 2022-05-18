<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SensorView.aspx.cs" Inherits="LSA.SensorView" %>

<%@ Register Src="UserControls/ViewFooter.ascx" TagName="ViewFooter" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />
    <asp:HiddenField ID="SoundData" runat="server" />
    <asp:HiddenField ID="TempData" runat="server" />
    <asp:HiddenField ID="HumidData" runat="server" />
    <asp:HiddenField ID="MotionData" runat="server" />
    <nav>
        <div class="nav nav-tabs" id="myTab" role="tablist">
            <button class="nav-link active" id="info-tab" data-toggle="tab" data-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">General Info</button>
            <button class="nav-link" id="readings_tab" data-toggle="tab" data-target="#readings" type="button" role="tab" aria-controls="readings" aria-selected="false" runat="server">Readings</button>
            <button class="nav-link" id="settings_tab" data-toggle="tab" data-target="#settings" type="button" role="tab" aria-controls="settings" aria-selected="false" runat="server">Device Settings</button>
        </div>
    </nav>

    <div class="tab-content bg-white clearfix" id="nav-tabContent">
        <div class="tab-pane show active" id="info" role="tabpanel" aria-labelledby="info-tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <asp:UpdatePanel ID="upInfo" runat="server">
                        <ContentTemplate>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Device ID:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbDeviceID" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Device MAC:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbDeviceMAC" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Device Name:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbDeviceName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Facility ID:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="DdlFacilityID" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlFacilityID_SelectedIndexChanged" />
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Facility Code/Name:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbFacilityCodeName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Sensor Position:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="DdlDevPosition" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" id="divActivateDate" runat="server">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Activated At:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbActivateDate" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" id="divLastHeard" runat="server">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Last Heard At:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbLastHeard" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" id="divLastBeat" runat="server">
                                <div class="col-sm-2 text-lg-right text-sm-left">
                                    <label>Last HeartBeat At:</label>
                                </div>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TbLastBeat" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <uc1:ViewFooter ID="ucViewFooter" runat="server" />
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="readings" role="tabpanel" aria-labelledby="readings_tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <asp:UpdatePanel ID="upReadings" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-12 h5 font-weight-bold">
                                    <asp:Label ID="lblLastReadingUpdate" runat="server" />
                                    <asp:Button ID="BtnGetLatestReading" runat="server" CssClass="btn btn-outline-primary float-sm-right" Text="Get Latest Readings From Minut Dashboard" OnClick="BtnGetLatestReading_Click" />
                                </div>
                            </div>

                            <div class="row mt-2 mb-2">
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
                                                    <asp:ListItem Text="1 min" Value="1" />
                                                    <asp:ListItem Text="5 min" Value="5" />
                                                    <asp:ListItem Text="10 min" Value="10" />
                                                    <asp:ListItem Text="15 min" Value="15" />
                                                    <asp:ListItem Text="30 min" Value="30" />
                                                    <asp:ListItem Selected="True" Text="60 min" Value="60" />
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
                                                <div class="input-group-append">
                                                    <button runat="server" ID="BtnGenerateChart" onserverclick="BtnGenerateChart_ServerClick" class="btn btn-success" title="Search">
                                                        <i class="fas fa-search"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row m-3">
                                <div class="col-sm-12 card h-100 shadow">
                                    <div class="card-body">
                                        <canvas id="SoundChart"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="row m-3">
                                <div class="col-sm-12 card h-100 shadow">
                                    <div class="card-body">
                                        <canvas id="TemperatureChart"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="row m-3">
                                <div class="col-sm-12 card h-100 shadow">
                                    <div class="card-body">
                                        <canvas id="HumidityChart"></canvas>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="BtnGenerateChart" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings_tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-3 text-lg-right text-sm-left">
                            <label>Listening Mode:</label>
                        </div>
                        <div class="col-sm-7">
                            <asp:DropDownList ID="DdlListenMode" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Text="Off" Value="off" />
                                <asp:ListItem Text="On" Value="on" />
                                <asp:ListItem Text="Interval" Value="interval" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-3 text-lg-right text-sm-left">
                            <label>Power Saving Mode:</label>
                        </div>
                        <div class="col-sm-7">
                            <asp:DropDownList ID="DdlPowerSaveMode" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Text="Off" Value="off" />
                                <asp:ListItem Text="On" Value="on" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-3 text-lg-right text-sm-left">
                            <label>Alarm Recognition:</label>
                        </div>
                        <div class="col-sm-7">
                            <asp:DropDownList ID="DdlAlarmRecog" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Text="Off" Value="off" />
                                <asp:ListItem Text="On" Value="on" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-sm-3 text-lg-right text-sm-left">
                            <label>Active Status:</label>
                        </div>
                        <div class="col-sm-7">
                            <asp:DropDownList ID="DdlActiveStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Text="Deactivated" Value="False" />
                                <asp:ListItem Text="Activated" Value="True" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <hr />
                    <div class="row mt-2 mb-2 d-flex justify-content-center">
                        <div class="col-sm-3">
                            <asp:Button ID="BtnDelete" runat="server" CssClass="btn btn-danger col-sm-12" Text="Delete Sensor" OnClick="BtnDelete_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3 mb-3">
        <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="BtnSubmit_Click" />
    </div>

    <script>

        function SetTab() {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "info";
            $('#myTab a[href="#' + tabName + '"]').tab('show');
        }

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            SetTab();

            $("#myTab a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });

            const SoundData = JSON.parse($("[id*=SoundData]").val() != "" ? $("[id*=SoundData]").val() : "{}");
            const MotionData = JSON.parse($("[id*=MotionData]").val() != "" ? $("[id*=SouData]").val() : "{}");

            const TempData = JSON.parse($("[id*=TempData]").val() != "" ? $("[id*=TempData]").val() : "{}");
            const HumidData = JSON.parse($("[id*=HumidData]").val() != "" ? $("[id*=HumidData]").val() : "{}");

            DisplaySoundChart('SoundChart', 'Sound Level (dB)', jQuery.isEmptyObject(SoundData) ? [] : SoundData.labels, jQuery.isEmptyObject(SoundData) ? [] : SoundData.datasets);
            DisplayTempChart('TemperatureChart', 'Temperature (°C)', jQuery.isEmptyObject(TempData) ? [] : TempData.labels, jQuery.isEmptyObject(TempData) ? [] : TempData.datasets);
            DisplayHumidChart('HumidityChart', 'Humidity (%)', jQuery.isEmptyObject(HumidData) ? [] : HumidData.labels, jQuery.isEmptyObject(HumidData) ? [] : HumidData.datasets);
        });

        $(document).ready(function () {
            SetTab();

            $("#myTab a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });

            const SoundData = JSON.parse($("[id*=SoundData]").val() != "" ? $("[id*=SoundData]").val() : "{}");
            const TempData = JSON.parse($("[id*=TempData]").val() != "" ? $("[id*=TempData]").val() : "{}");
            const HumidData = JSON.parse($("[id*=HumidData]").val() != "" ? $("[id*=HumidData]").val() : "{}");

            DisplaySoundChart('SoundChart', 'Sound Level (dB)', jQuery.isEmptyObject(SoundData) ? [] : SoundData.labels, jQuery.isEmptyObject(SoundData) ? [] : SoundData.datasets);
            DisplayTempChart('TemperatureChart', 'Temperature (°C)', jQuery.isEmptyObject(TempData) ? [] : TempData.labels, jQuery.isEmptyObject(TempData) ? [] : TempData.datasets);
            DisplayHumidChart('HumidityChart', 'Humidity (%)', jQuery.isEmptyObject(HumidData) ? [] : HumidData.labels, jQuery.isEmptyObject(HumidData) ? [] : HumidData.datasets);
        });

        function DisplaySoundChart(chartid, title, labels, datasets) {
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

        function DisplayTempChart(chartid, title, labels, datasets) {
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

        function DisplayHumidChart(chartid, title, labels, datasets) {
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
    </script>
</asp:Content>
