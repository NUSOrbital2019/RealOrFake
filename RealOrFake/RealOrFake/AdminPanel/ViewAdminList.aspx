<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/Admin.master" AutoEventWireup="true" CodeBehind="ViewAdminList.aspx.cs" Inherits="RealOrFake.AdminPanel.ViewAdminList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        input.btn.btn-success {
            margin: 2%;
        }

        .textbox {
            border: 1px solid #c4c4c4;
            padding: 4px 4px 4px 4px;
            box-shadow: 0px 0px 8px #d9d9d9;
            -moz-box-shadow: 0px 0px 8px #d9d9d9;
            -webkit-box-shadow: 0px 0px 8px #d9d9d9;
            width: 100%;
            height: 100%;
            overflow: auto;
        }

        td:nth-child(3) input {
            margin: 2%;
            width: 100%;
        }
    </style>

    <!-- Pop up Modal for Session Timeout -->
    <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-sm" style="min-width: 37%; z-index: 200;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" style="text-align: center; margin: auto; font-weight: bold;">Your account has been locked</h3>
                </div>
                <div class="modal-body" style="text-align: center; margin: auto;">
                    <h4>To prove that you are <b><big><%: Context.User.Identity.Name  %></b></big>...</h4>
                    <p style="text-align: center;">Please enter your password in order to continue:</p>
                    <asp:TextBox ID="txtPasswordAuthenticate" runat="server" TextMode="Password" CssClass="textbox" Text=""></asp:TextBox>
                    <br />
                    <p style="text-align: center;">
                        <asp:Label ID="errormsgPasswordAuthenticate" runat="server" Text="Password is incorrect." Visible="false" ForeColor="#da337a"></asp:Label>
                    </p>
                </div>
                <div class="modal-footer" style="text-align: center; margin: auto;">
                    <asp:Button ID="btnAuthenticate" class="btn btn-primary" runat="server" Text="Authenticate" OnClick="btnAuthenticate_Click" CausesValidation="false" />
                    <%--  <asp:Button ID="btnLogout" class="btn btn-default" runat="server" Text="Logout" PostBackUrl="~/Account/Login.aspx" />--%>

                    <br />
                </div>
            </div>
        </div>
    </div>

    <div class="card-header">
        <h4 class="card-title">Admin Control Panel</h4>
    </div>

    <div class="card-body" style="padding: 1.25rem;">
        <div class="row">

            <div class="col-md-5 pr-1">
                <div class="form-group">

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AdminUserName" DataSourceID="AdminData"
                        Height="179px" Width="245%" OnRowDataBound="GridView1_RowDataBound" BorderColor="#F0F0F0" HeaderStyle-BackColor="#14827d" RowStyle-BackColor="#f3f3f3" HeaderStyle-HorizontalAlign="Center" CellPadding="15" Font-Names="Helvetica"
                        HeaderStyle-ForeColor="White" HeaderStyle-Wrap="true" RowStyle-BorderColor="white"
                        RowStyle-HorizontalAlign="Center" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>

                            <asp:TemplateField HeaderText="Username">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_AdminUserName" runat="server" Text='<%#Eval("AdminUserName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Password">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_AdminPassword" runat="server" Text='<%#Eval("AdminPassword") %>'></asp:Label>
                                </ItemTemplate>

                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_AdminPassword" runat="server" Text='<%#Eval("AdminPassword") %>' CssClass="textbox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button Text="Edit" ID="button_edit" runat="server"
                                        CssClass="btn btn-danger" CommandName="Edit"
                                        UseSubmitBehavior="False" Font-Size="Small" />

                                    <asp:Button Text="Delete" ID="button_delete" runat="server"
                                        CssClass="btn btn-danger" CommandName="Delete"
                                        UseSubmitBehavior="False" Font-Size="Small" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Button Text="Update" ID="button_update" runat="server"
                                        CssClass="btn btn-danger" CommandName="Update"
                                        UseSubmitBehavior="False" Font-Size="Small" />
                                    <asp:Button Text="Cancel" ID="button_cancel" runat="server"
                                        CssClass="btn btn-danger" CommandName="Cancel"
                                        UseSubmitBehavior="False" Font-Size="Small" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:BoundField DataField="AdminUserName" HeaderText="Username" ReadOnly="True" SortExpression="AdminUserName" />--%>
                            <%--<asp:BoundField DataField="AdminPassword" HeaderText="Password" SortExpression="AdminPassword" />--%>

                            <%--                            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True"
                                ControlStyle-CssClass="btn btn-success" ItemStyle-HorizontalAlign="left" />--%>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="AdminData" runat="server" ConnectionString="<%$ ConnectionStrings:FileDatabaseConnectionString1 %>"
                        SelectCommand="SELECT * FROM [Admin]">
                        <%-- DeleteCommand="DELETE FROM [Admin] WHERE [AdminUserName] = @AdminUserName"
                        InsertCommand="INSERT INTO [Admin] ([AdminUserName], [AdminPassword]) VALUES (@AdminUserName, @AdminPassword)"
                            UpdateCommand="UPDATE [Admin] SET [AdminPassword] = @AdminPassword WHERE [AdminUserName] = @AdminUserName" --%>

                        <%--             <DeleteParameters>
                            <asp:Parameter Name="AdminUserName" Type="String" />
                        </DeleteParameters>

                        <InsertParameters>
                            <asp:Parameter Name="AdminUserName" Type="String" />
                            <asp:Parameter Name="AdminPassword" Type="String" />
                        </InsertParameters>

                        <UpdateParameters>
                            <asp:Parameter Name="AdminPassword" Type="String" />
                            <asp:Parameter Name="AdminUserName" Type="String" />
                        </UpdateParameters>--%>

                    </asp:SqlDataSource>
                </div>

            </div>
        </div>

    </div>

    <div class="row" style="margin-left: 2.5%; margin-top: -3%">
        <div>
            <p style="font-size: small;">Note: Please update password in plain-text. However, password will be displayed otherwise for security purposes.</p>
        </div>
    </div>

    <div class="row" style="margin-left: 2.5%;">
        <div style="float: right;">
            <label style="font-size: 16px;">Admin not found here? </label>
            &nbsp; &nbsp; &nbsp;
            <asp:Button ID="CreateButton" runat="server" Text="Create New Admin" OnClick="CreateButton_Click" CssClass="btn btn-primary" />
        </div>
    </div>
    <br />
    <br />

</asp:Content>
