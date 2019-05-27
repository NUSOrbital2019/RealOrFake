<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="CreateNewAdmin.aspx.cs" Inherits="RealOrFake.AdminPanel.CreateNewAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<p>
		Admin Registration
	</p>
	IUser Name:
	<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
	<br />
	<br />
	Password:
	<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
	<br />
	<br />
	<br />
	<asp:Button ID="SubmitButton" runat="server" OnClick="SubmitButton_Click" Text="Submit" />
</asp:Content>
