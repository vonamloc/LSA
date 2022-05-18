<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionnaireView.aspx.cs" Inherits="LSA.QuestionnaireView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />
    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="info-tab" data-toggle="tab" data-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">General Info</button>
        </div>
    </nav>

    <div class="tab-content bg-white clearfix" id="nav-tabContent">
        <div class="tab-pane show active" id="info" role="tabpanel" aria-labelledby="info-tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <div class="row mt-2 mb-2">
                        <div class="col-3 text-right">
                            <label>Qns No:</label>
                        </div>
                        <div class="col-6 text-left">
                            <asp:TextBox ID="TbQnsNo" runat="server" CssClass="form-control" TextMode="Number" min="1" />
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-3 text-right">
                            <label>Type:</label>
                        </div>
                        <div class="col-6 text-left">
                            <asp:DropDownList ID="DdlType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Quantitative" Value="QUAN" />
                                <asp:ListItem Text="Qualitative" Value="QUAL" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2">
                        <div class="col-3 text-right">
                            <label>Description:</label>
                        </div>
                        <div class="col-6 text-left">
                            <asp:TextBox ID="TbDesc" runat="server" CssClass="form-control" TextMode="MultiLine" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
              
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3 mb-3">
        <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="BtnSubmit_Click" />
        <asp:Button ID="BtnDelete" runat="server" CssClass="btn btn-danger" Text="Delete Question" OnClick="BtnDelete_Click" />
    </div>

    <script>
        function SetTab() {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "info";
            $('#Tabs a[href="#' + tabName + '"]').tab('show');
        }

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            SetTab();
        });

        $(document).ready(function () {
            SetTab();
            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });

    </script>
</asp:Content>
