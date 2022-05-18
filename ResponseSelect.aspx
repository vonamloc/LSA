<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResponseSelect.aspx.cs" Inherits="LSA.ResponseSelect" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Collapsable Card Example -->
    <div class="card border-left-primary shadow mb-3">
        <!-- Card Header - Accordion -->
        <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="true" aria-controls="collapseCardExample">
            <h6 class="m-0 font-weight-bold text-muted"><i class="fas fa-info-circle text-primary"></i>&nbsp;&nbsp;Instructions For Use</h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="collapseCardExample">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-9">
                        <h5 class="text-success font-weight-bold">&#10003; DOs </h5>
                        <ol>
                            <li class="text-dark">Upload only Excel file with the following supported extensions: <mark>.xlsx / .xlsm / .xltx / .xltm</mark></li>
                            <li class="text-dark">Upload only 1 file at a time.</li>
                            <li class="text-dark">Comply with <mark>format</mark> of Excel file sheet. <a href="samplefile/SampleExcel.xlsx" download="Sample">View Sample&nbsp;&nbsp;<i class="fas fa-file-download fa-lg"></i></a></li>

                        </ol>
                        <h5 class="text-danger font-weight-bold">&#10007; DON'Ts </h5>
                        <ol>
                            <li class="text-dark">Don't upload while opening the Excel file.</li>
                        </ol>
                    </div>
                    <div class="col-sm-3">
                        <img src="illustrations/undraw_instruction_manual_cyae.svg" alt="instructions manual illustration" class="w-100">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-3" id="divUploadCard" runat="server">
        <div class="col-sm-12">
            <div class="card border-bottom-primary">
                <div class="card-body text-center p-5">
                    <asp:UpdatePanel ID="upProjPhase" runat="server">
                        <ContentTemplate>
                            <div class="row d-flex justify-content-center">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-3">
                                        <div class="h4 mb-0 font-weight-bold text-gray-800">
                                            Academic Year/Sem.
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <asp:DropDownList ID="DdlSemester" runat="server" CssClass="form-control col-12" AutoPostBack="true" OnSelectedIndexChanged="DdlSemester_SelectedIndexChanged" />
                                    </div>
                                </div>
                            </div>
                            <div class="h6 mt-3">
                                <asp:Label ID="lblSemester" runat="server">31/5/2021 - 20/8/2021</asp:Label>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="row mt-3">
                        <div class="col display-4 text-dark">I am uploading for</div>
                    </div>
                    <div class="row mt-3">
                        <div class="col d-flex justify-content-center">
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="customRadioInline1" name="customRadioInline1" class="custom-control-input w-100 h-50" checked="checked" value="Student">
                                <label class="custom-control-label" for="customRadioInline1">Students</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="customRadioInline2" name="customRadioInline1" class="custom-control-input w-100" value="Lecturer">
                                <label class="custom-control-label" for="customRadioInline2">Lecturers</label>
                            </div>
                        </div>
                    </div>
                    <asp:HiddenField ID="hiddenRadioFieldValue" ClientIDMode="Static" runat="server" />
                    <div class="row d-flex justify-content-center mt-3">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-3">
                                <div class="h6 mb-0 text-gray-800">
                                    Occupying Facility:
                                </div>
                            </div>
                            <div class="col-auto">
                                <asp:DropDownList ID="DdlFacilityCodeName" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="row d-flex justify-content-center">
                        <asp:FileUpload ID="fuResponse" runat="server" AllowMultiple="True" CssClass="btn btn-primary mt-4 p-2" onchange="UploadFile(this)" />
                    </div>
                    <asp:Button ID="BtnUpload" runat="server" OnClick="BtnUpload_Click" CssClass="btn btn-primary d-none" Text="Upload" />
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="divSurveyResultsCard" runat="server">
        <div class="col mb-4">
            <div class="card shadow h-100 py-2">
                <div class="card-body p-3">
                    <div class="h2 text-dark text-center">
                        Survey Results
                    </div>
                    <div class="h5 text-center">
                        <asp:Label ID="lblChartsSummary" runat="server"></asp:Label>
                    </div>
                    <asp:Literal ID="litCharts" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="divSurveyInsightsCard" runat="server">
        <div class="col-xl-6 col-md-12 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Total Questions
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalQns" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                        </div>
                    </div>
                    <hr />
                    <div class="row no-gutters align-items-center" id="divNewQns" runat="server">
                        <div class="col">
                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
                                New Questions <span class="text-danger">*</span>
                            </div>
                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                These questions have not been created by Administrator. They will be auto-created upon form submission.
                            </div>
                            <div class="text-xs mb-0 font-weight-bold text-gray-800">
                                <asp:Literal ID="litNewQns" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-6 col-md-12 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Total Responses
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblTotalResp" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-poll fa-2x text-gray-300"></i>
                        </div>
                    </div>
                    <hr />
                    <div class="row no-gutters align-items-center">
                        <div class="col-4 pl-4">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Success Count
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblSuccessCount" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="col-3 border-left pl-4">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Error Count
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblErrorCount" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="col-5 border-left pl-4">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Unverified Response Count
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                <asp:Label ID="lblUnverifiedCount" runat="server" Text="0" />
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="row no-gutters align-items-center" id="divAddRemarks" runat="server">
                        <div class="col">
                            <div class="text-lg font-weight-bold text-success text-uppercase mb-1">
                                Additional Remarks
                            </div>
                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                The system has identified several responses that have failed to download or were unverified. They will be excluded from the final list of responses upon form submission.
                            </div>
                            <div class="text-xs font-weight-bold text-dark mb-1">
                                These errors had occured on the survey platform. For more clarification, please contact their support team at <a href="https://form.gov.sg/#!/5d6dd66ad6754c0012d7dc82" target="_blank" rel="noopener noreferrer">https://form.gov.sg/#!/5d6dd66ad6754c0012d7dc82</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-end mb-4" id="divFormButtons" runat="server">
        <div class="col-auto">
            <asp:Button ID="BtnUploadNew" runat="server" CssClass="btn btn-warning" Text="Upload New" OnClick="BtnUploadNew_Click" />
        </div>
        <div class="col-auto">
            <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary" Text="Save All Changes" OnClick="BtnSubmit_Click" />
        </div>
    </div>

    <script>
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
                var totalResponses = $('input[name="totalResponses"]').val().toString();
                DisplayMainSurveyChart(thisid, MainSurveyChartData.labels, MainSurveyChartData.datasets, totalResponses + " Response(s)");
            };

            if (datasets) {
                datasets[0].backgroundColor = ['#ff7f01', '#1cade4', '#da5af4', '#f1b015', '#d2c2f1', '#9d09d1'];
            }

            const config = {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    onClick: onClick,
                    responsive: true,
                    plugins: {
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
                                weight: 'bolder'
                            },
                            color: 'black',
                            padding: 10,
                            position: 'left'
                        },
                        datalabels: {
                            font: {
                                family: 'Nunito',
                                size: 18,
                                weight: 'bolder'
                            },
                            display: function (context) {
                                return context.dataset.data[context.dataIndex] !== 0; // or >= 1 or ...
                            },
                            anchor: 'center',
                            color: 'white',
                            formatter: function (value, context) {
                                //var total = 0;
                                //context.chart.data.datasets.forEach((element) => {
                                //    total += element.data[context.dataIndex];
                                //});
                                //return `${(value / total * 100).toFixed(1)}%`;

                                //For datasets whose data is represented as one whole list, E.g. Pie Charts
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

        function DisplayMainSurveyChart(chartid, labels, datasets, title) {
            var qnstype = chartid.split("_")[0];

            if (qnstype == "QUAL" || qnstype == "QUAN") {
                datasets[0].backgroundColor = ['#d7191c', '#fdae61', '#a6d96a', '#66bd63'];
            }
            if (qnstype == "CUSTOMEVER" || qnstype == "CUSTOMWILL") {
                datasets[0].backgroundColor = ['#ffffcc', '#a1dab4', '#41b6c4', '#2c7fb8', '#253494'];
            }
            if (qnstype == "FACTORSTU" || qnstype == "FACTORLEC") {
                datasets[0].backgroundColor = ['#4f6980', '#849db1', '#a2ceaa', '#638b66', '#bfbb60', '#f47942', '#fbb04e', '#b66353', '#d7ce9f', '#b9aa97', '#7e756d'];

            }
            if (qnstype == "OPEN") {
                datasets[0].backgroundColor = ['#4E79A7', '#A0CBE8', '#F28E2B', '#FFBE7D', '#59A14F', '#8CD17D', '#B6992D', '#F1CE63', '#499894', '#86BCB6', '#E15759', '#FF9D9A', '#79706E', '#BAB0AC', '#D37295', '#FABFD2', '#B07AA1', '#D4A6C8', '#9D7660', '#D7B5A6'];
            }

            const onClick = function clickHandler(evt) {
                const points = evt.chart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, true);
                if (points.length) {
                    const firstPoint = points[0];
                    //labelOption = evt.chart.data.datasets[firstPoint.datasetIndex].label; //useful if chart is multiseries pie
                    var label = evt.chart.data.labels[firstPoint.index];
                    var value = evt.chart.data.datasets[firstPoint.datasetIndex].data[firstPoint.index];
                }

                var SubChartId = [label.replace(/\s+/g, ''), evt.chart.canvas.id.split("_")[0], 'SubSurveyChartData', evt.chart.canvas.id.split("_")[2]].join('_');
                var SubSurveyChartData = JSON.parse($("#" + SubChartId).val());

                var thisid = evt.chart.canvas.id;
                evt.chart.destroy();
                DisplaySubSurveyChart(thisid, SubSurveyChartData.labels, SubSurveyChartData.datasets, label);
            };

            const config = {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    onClick: onClick,
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        },
                        title: {
                            display: true,
                            text: title,
                            font: {
                                family: 'Nunito',
                                size: 15,
                                weight: 'bolder'
                            },
                            color: 'black',
                            padding: 10,
                            position: 'left'
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
                                //var total = 0;
                                //context.chart.data.datasets.forEach((element) => {
                                //    total += element.data[context.dataIndex];
                                //});
                                //return `${(value / total * 100).toFixed(1)}%`;

                                //For datasets whose data is represented as one whole list, E.g. Pie Charts
                                var sum = context.dataset.data.reduce((a, b) => a + b, 0);
                                return (value / sum * 100).toFixed(1) + "%";
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
            var chart = new Chart(
                ctx,
                config
            );
        }

        function SweetAlert(errorMsg) {
            alert(errorMsg);
        }

        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                $("[id*=BtnUpload]").click();
            }
        }

        $(document).ready(function () {
            var checked = $('input[name="customRadioInline1"]:checked').val();
            $("[id*='hiddenRadioFieldValue']").val(checked);

            $('input[type=radio][name="customRadioInline1"]').change(function () {
                $("[id*='hiddenRadioFieldValue']").val(this.value);
            });

            var totalResponses = $('input[name="totalResponses"]').val().toString();
            $("[id*='SurveyChartCanvas']").each(function () {
                var qnstype = this.id.split("_")[0];
                var qnsid = this.id.split("_")[2];
                var MainSurveyChartData = JSON.parse($("#" + qnstype + "_MainSurveyChartData_" + qnsid).val());

                DisplayMainSurveyChart(this.id, MainSurveyChartData.labels, MainSurveyChartData.datasets, totalResponses + " Response(s)");
            });
        });
    </script>
</asp:Content>
