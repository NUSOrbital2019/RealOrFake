<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RealOrFake.AdminPanel.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        td {
            /*max-width: 300px;*/
            overflow: auto;
        }

        table {
            box-sizing: inherit;
            max-width: 100%;
        }
    </style>
    <div class="card-header">
        <h4 class="card-title">Pending Submissions</h4>
    </div>

    <div class="card-body" style="padding: 1.25rem;">

        <div class="row">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ConnectionStrings:FileDatabaseConnectionString1 %>"
                SelectCommand="SELECT [SubmissionId], [Email], [Name], [ImagePath], [SubmissionDate] FROM [Customer]
        WHERE (SubmissionStatus = 'Pending');"></asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" BorderColor="#F0F0F0" HeaderStyle-BackColor="#146882" RowStyle-BackColor="#f3f3f3" RowStyle-Font-Size="Small"
                HeaderStyle-HorizontalAlign="Center" CellPadding="15" Font-Names="Helvetica"
                HeaderStyle-ForeColor="White" HeaderStyle-Wrap="true" RowStyle-BorderColor="white"
                RowStyle-HorizontalAlign="Center" DataSourceID="SqlDataSource1" Width="100%" AutoGenerateColumns="false"
                EmptyDataText="There is currently no pending submissions." OnRowCommand="GridView1_RowCommand" Font-Size="Small">
                <%-- OnPageIndexChanging="GridView1_PageIndexChanging" --%>
                <%--<PagerStyle CssClass="pagerStyle" />--%>
                <Columns>
                    <asp:BoundField DataField="SubmissionDate" HeaderText="Date of Submission" />
                    <asp:BoundField DataField="SubmissionId" HeaderText="Submission Id" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageBtn_ImagePath" runat="server" Width="100" Height="100"
                                ImageUrl='<%# "/Resources/ImagesForAuthentication/" + Eval("SubmissionId") + "-" + Eval("Email") + ".jpg" %>'
                                CommandName="SelectImage"
                                CommandArgument='<%# "/Resources/ImagesForAuthentication/" + Eval("SubmissionId") + "-" + Eval("Email") + ".jpg" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Submission Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="dropdown_status" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropdown_status_SelectedIndexChanged"
                                EnableViewState="true" ViewStateMode="Enabled" CssClass="btn btn-primary" Width="120">
                                <asp:ListItem Text="Pending" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Approved" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Rejected" Value="3"></asp:ListItem>
                                <%--<asp:ListItem Text="Irrelevant" Value="4"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete Submisson">
                        <ItemTemplate>
                            <asp:Button Text="Delete Submission" ID="button_deleteSubmission" runat="server"
                                CssClass="btn btn-warning" CommandName="DeleteSubmission"
                                UseSubmitBehavior="False" CommandArgument='<%# Eval("imagePath") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
        </div>
    </div>
</asp:Content>
