<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AppUserView.aspx.cs" Inherits="LSA.AppUserView" %>

<%@ Register Src="UserControls/ViewFooter.ascx" TagName="ViewFooter" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />
    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button class="nav-link active" id="info-tab" data-toggle="tab" data-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">General Info</button>
            <button class="nav-link" id="accrgt-tab" data-toggle="tab" data-target="#accrgt" type="button" role="tab" aria-controls="accrgt" aria-selected="false">Access Rights</button>
        </div>
    </nav>

    <div class="tab-content bg-white clearfix" id="nav-tabContent">
        <div class="tab-pane show active" id="info" role="tabpanel" aria-labelledby="info-tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                    <asp:UpdatePanel ID="upResponse" runat="server">
                        <ContentTemplate>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label> Login ID:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="TbLoginID" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" id="divEmail" runat="server">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Email:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="TbEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>User Name:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="TbUsrName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>User Short Name:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="TbUsrShtName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>User Type:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlUsrType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlUsrType_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Text="Individual" Value="I" />
                                        <asp:ListItem Text="Group" Value="G" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>User Role:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlUsrRole" runat="server" CssClass="form-control" OnSelectedIndexChanged="DdlUsrRole_SelectedIndexChanged" />
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>User Status:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlUsrStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="True" Text="Active" Value="A" />
                                        <asp:ListItem Text="Inactive" Value="I" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Lock Status:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlLockStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="True" Text="Lock" Value="L" />
                                        <asp:ListItem Text="Unlock" Value="U" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Access Right:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlAccessRgt" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlAccessRgt_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Text="Individual" Value="I" />
                                        <asp:ListItem Text="Group" Value="G" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" id="divAccessRgtGrp" runat="server">
                                <div class="col-sm-2 text-lg-right text-sm-left required">
                                    <label>Access Right Group:</label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="DdlAccessRgtGrp" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <uc1:ViewFooter ID="ucViewFooter" runat="server" />
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="accrgt" role="tabpanel" aria-labelledby="accrgt-tab">
            <div class="card border-top-0 rounded-0 rounded-bottom">
                <div class="card-body">
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3 mb-3">
        <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="BtnSubmit_Click" />
        <asp:Button ID="BtnReset" runat="server" CssClass="btn btn-warning ml-1" Text="Reset Password" OnClick="BtnReset_Click" />
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
