<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewFooter.ascx.cs" Inherits="LSA.UserControls.ViewFooter" %>

<hr />
<div class="row mt-3 mb-3">
    <div class="col-sm-6">
        <div class="row mb-3">
            <div class="col-sm-12 text-sm-left">
                <label>Created By:</label>
            </div>
            <div class="col-sm-12">
                <asp:TextBox ID="TbCreateBy" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-sm-12 text-sm-left">
                <label>Created Date:</label>
            </div>
            <div class="col-sm-12">
                <asp:TextBox ID="TbCreateDate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="row mb-3">
            <div class="col-sm-12 text-sm-left">
                <label>Amended By:</label>
            </div>
            <div class="col-sm-12">
                <asp:TextBox ID="TbAmendBy" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-sm-12 text-sm-left">
                <label>Amended Date:</label>
            </div>
            <div class="col-sm-12">
                <asp:TextBox ID="TbAmendDate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
            </div>
        </div>
    </div>
</div>
