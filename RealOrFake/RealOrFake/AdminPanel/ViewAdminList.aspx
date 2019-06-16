<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="ViewAdminList.aspx.cs" Inherits="RealOrFake.AdminPanel.ViewAdminList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    &nbsp;<asp:Button ID="CreateButton" runat="server" Text="Create" OnClick="CreateButton_Click" Height="30px" Width="65px" />
	<br />
	<br />
	<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AdminUserName" DataSourceID="AdminData" Height="179px" Width="505px" OnRowDataBound="GridView1_RowDataBound">
		<Columns>
			<asp:BoundField DataField="AdminUserName" HeaderText="AdminUserName" ReadOnly="True" SortExpression="AdminUserName" />
			<asp:BoundField DataField="AdminPassword" HeaderText="AdminPassword" SortExpression="AdminPassword" />
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
	</asp:GridView>
	&nbsp;
	<asp:SqlDataSource ID="AdminData" runat="server" ConnectionString="<%$ ConnectionStrings:FileDatabaseConnectionString1 %>" SelectCommand="SELECT * FROM [Admin]" DeleteCommand="DELETE FROM [Admin] WHERE [AdminUserName] = @AdminUserName" InsertCommand="INSERT INTO [Admin] ([AdminUserName], [AdminPassword]) VALUES (@AdminUserName, @AdminPassword)" UpdateCommand="UPDATE [Admin] SET [AdminPassword] = @AdminPassword WHERE [AdminUserName] = @AdminUserName">
        <DeleteParameters>
            <asp:Parameter Name="AdminUserName" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="AdminUserName" Type="String" />
            <asp:Parameter Name="AdminPassword" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="AdminPassword" Type="String" />
            <asp:Parameter Name="AdminUserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
