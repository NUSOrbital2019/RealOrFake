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
