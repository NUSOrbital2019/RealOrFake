<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="CreateNewAdmin.aspx.cs" Inherits="RealOrFake.AdminPanel.CreateNewAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .textbox {
            border: 1px solid #c4c4c4;
            font-size: large;
            padding: 4px 4px 4px 4px;
            /*border-radius: 20px;
            -moz-border-radius: 20px;
            -webkit-border-radius: 20px;*/
            box-shadow: 0px 0px 8px #d9d9d9;
            -moz-box-shadow: 0px 0px 8px #d9d9d9;
            -webkit-box-shadow: 0px 0px 8px #d9d9d9;
        }
    </style>
    <div class="card-header">
        <h4 class="card-title">Admin Registration</h4>
    </div>

    <div class="card-body" style="padding: 1.25rem;">
        Username:
         <br />
        <asp:TextBox ID="TextBox1" runat="server" Height="25px" Width="200px" CssClass="textbox"></asp:TextBox>
        <asp:RequiredFieldValidator ID="InsertName" runat="server" ErrorMessage="Name is required" ControlToValidate="TextBox1" Text="*" ForeColor="Red">
        </asp:RequiredFieldValidator>
        <br />
        <br />
        Password:
         <br />
        <asp:TextBox ID="TextBox2" runat="server" Height="25px" Width="200px" CssClass="textbox"></asp:TextBox>
        <asp:RequiredFieldValidator ID="InsertPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="TextBox2" Text="*" ForeColor="Red">
        </asp:RequiredFieldValidator>
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <br />
        <br />
        <asp:Button ID="SubmitButton" runat="server" OnClick="SubmitButton_Click" Text="Submit" CssClass="btn btn-success" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" CausesValidation="false" CssClass="btn btn-primary" />

    </div>
</asp:Content>
