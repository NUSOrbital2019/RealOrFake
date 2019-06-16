<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="CreateNewAdmin.aspx.cs" Inherits="RealOrFake.AdminPanel.CreateNewAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-size: medium; font-weight: bold">
		Admin Registration
	</p>
	User Name:
	<asp:TextBox ID="TextBox1" runat="server" Height="25px" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID ="InsertName" runat="server" ErrorMessage="Name is required" ControlToValidate ="TextBox1" Text="*" ForeColor="Red">
        </asp:RequiredFieldValidator>
	<br />
	<br />
	Password:
	<asp:TextBox ID="TextBox2" runat="server" Height="25px" Width="200px"></asp:TextBox>
    <asp:RequiredFieldValidator ID ="InsertPassword" runat="server" ErrorMessage="Password is required" ControlToValidate ="TextBox2" Text="*" ForeColor="Red">
    </asp:RequiredFieldValidator>
	<br />
	<asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
	<br />
	<br />
	<asp:Button ID="SubmitButton" runat="server" OnClick="SubmitButton_Click" Text="Submit" Height="30px" Width="80px" />
&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="resetBtn" runat="server" Text="Reset" Height="30px" OnClick="resetBtn_Click" Width="80px" />
</asp:Content>
