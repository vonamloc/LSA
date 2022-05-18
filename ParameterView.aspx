<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ParameterView.aspx.cs" Inherits="LSA.ParameterView" %>

<%@ Register Src="UserControls/ViewFooter.ascx" TagName="ViewFooter" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="updParameter" runat="server">
        <ContentTemplate>
            <div class="row mt-2 mb-2">
                <div class="col-sm-2 text-lg-right text-sm-left">
                    <label>ParaCode 1:</label>
                </div>
                <div class="col-sm-8 d-flex align-items-center">
                    <asp:DropDownList ID="DdlParaCode1" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlParaCode1_SelectedIndexChanged" />
                    <asp:TextBox ID="TbParaCode1" runat="server" CssClass="form-control col-sm-9" OnKeyUp="let p=this.selectionStart;this.value=this.value.toUpperCase();this.setSelectionRange(p, p);" />
                </div>
            </div>

            <div class="row mt-2 mb-2">
                <div class="col-sm-2 text-lg-right text-sm-left">
                    <label>ParaCode 2:</label>
                </div>
                <div class="col-sm-8 d-flex align-items-center">
                    <asp:DropDownList ID="DdlParaCode2" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlParaCode2_SelectedIndexChanged" />
                    <asp:TextBox ID="TbParaCode2" runat="server" CssClass="form-control col-sm-9" />
                </div>
            </div>

            <div class="row mt-2 mb-2">
                <div class="col-sm-2 text-lg-right text-sm-left">
                    <label>ParaCode 3:</label>
                </div>
                <div class="col-sm-8 d-flex align-items-center">
                    <asp:DropDownList ID="DdlParaCode3" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlParaCode3_SelectedIndexChanged" />
                    <asp:TextBox ID="TbParaCode3" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mt-2 mb-2">
                <div class="col-sm-2 text-lg-right text-sm-left">
                    <label>Description 1:</label>
                </div>
                <div class="col-sm-8">
                    <asp:TextBox ID="TbDesc1" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
            </div>

            <div class="row mt-2 mb-2">
                <div class="col-sm-2 text-lg-right text-sm-left">
                    <label>Description 2:</label>
                </div>
                <div class="col-sm-8">
                    <asp:TextBox ID="TbDesc2" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
            </div>
            <div class="row mt-2 mb-2">
                <div class="col-sm-12">
                    <div class="row d-flex justify-content-center">
                        <div class="col-sm-8">
                            <uc1:ViewFooter ID="ucViewFooter" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3 mb-3">
                <div class="col-sm-12">
                    <div class="row d-flex justify-content-center">
                        <div class="col-sm-4 d-flex justify-content-start">
                            <asp:Button ID="BtnDeleteAll" runat="server" CssClass="btn btn-danger" Text="Delete All Parameters" OnClick="BtnDeleteAll_Click" />
                            <asp:Button ID="BtnDelete" runat="server" CssClass="btn btn-warning mr-1" Text="Delete Parameter" OnClick="BtnDelete_Click" />
                        </div>
                        <div class="col-sm-4 d-flex justify-content-end">
                            <asp:Button ID="BtnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="BtnSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>



    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            $("[id*=tbParaCode1]").on('input propertychange paste', function () {
                if ($("[id*=tbParaCode1]").val()) {
                    $("[id*=ddlParaCode1]").attr('disabled', true);
                    $("[id*=tbParaCode2]").attr('disabled', false);
                    $("[id*=tbParaCode3]").attr('disabled', false);
                    $("[id*=tbDesc1]").attr('disabled', false);
                    $("[id*=tbDesc2]").attr('disabled', false);
                    $("[id*=btnSubmit]").attr('disabled', false);
                }
                else {
                    $("[id*=ddlParaCode1]").attr('disabled', false);
                    $("[id*=tbParaCode2]").val('');
                    $("[id*=tbParaCode2]").attr('disabled', true);
                    $("[id*=tbParaCode3]").val('');
                    $("[id*=tbParaCode3]").attr('disabled', true);
                    $("[id*=tbDesc1]").val('');
                    $("[id*=tbDesc1]").attr('disabled', true);
                    $("[id*=tbDesc2]").val('');
                    $("[id*=tbDesc2]").attr('disabled', true);
                    $("[id*=btnSubmit]").attr('disabled', true);
                }

            });
        });

        $(document).ready(function () {
            $("[id*=tbParaCode1]").on('input paste', function () {
                if ($("[id*=tbParaCode1]").val()) {
                    $("[id*=ddlParaCode1]").attr('disabled', true);
                    $("[id*=tbParaCode2]").attr('disabled', false);
                    $("[id*=tbParaCode3]").attr('disabled', false);
                    $("[id*=tbDesc1]").attr('disabled', false);
                    $("[id*=tbDesc2]").attr('disabled', false);
                    $("[id*=btnSubmit]").attr('disabled', false);
                }
                else {
                    $("[id*=ddlParaCode1]").attr('disabled', false);
                    $("[id*=tbParaCode2]").val('');
                    $("[id*=tbParaCode2]").attr('disabled', true);
                    $("[id*=tbParaCode3]").val('');
                    $("[id*=tbParaCode3]").attr('disabled', true);
                    $("[id*=tbDesc1]").val('');
                    $("[id*=tbDesc1]").attr('disabled', true);
                    $("[id*=tbDesc2]").val('');
                    $("[id*=tbDesc2]").attr('disabled', true);
                    $("[id*=btnSubmit]").attr('disabled', true);
                }
            });
        });
    </script>
</asp:Content>
