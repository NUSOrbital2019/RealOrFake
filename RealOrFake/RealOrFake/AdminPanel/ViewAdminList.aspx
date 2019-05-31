<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="ViewAdminList.aspx.cs" Inherits="RealOrFake.AdminPanel.ViewAdminList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="CreateButton" runat="server" Text="Create" OnClick="CreateButton_Click" />
	<br />
	<br />
	<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AdminUserName" DataSourceID="AdminData" Height="179px" Width="505px" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
		<Columns>
			<asp:BoundField DataField="AdminUserName" HeaderText="AdminUserName" ReadOnly="True" SortExpression="AdminUserName" />
			<asp:BoundField DataField="AdminPassword" HeaderText="AdminPassword" SortExpression="AdminPassword" />
		</Columns>
	</asp:GridView>
	&nbsp;
	<asp:SqlDataSource ID="AdminData" runat="server" ConnectionString="<%$ ConnectionStrings:FileDatabaseConnectionString1 %>" SelectCommand="SELECT * FROM [Admin]"></asp:SqlDataSource>
</asp:Content>
