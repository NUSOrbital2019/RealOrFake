<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="AuthenticateImage.aspx.cs" Inherits="RealOrFake.UserPanel.AuthenticateImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        input[type=text], select, textarea {
            width: 60%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 6px;
            margin-bottom: 16px;
            resize: vertical;
        }

        input[type=submit] {
            background-color: #146882;
            color: white;
            padding: 6px 6px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 110px;
        }

            input[type=submit]:hover {
                background-color: #4f95ab;
            }
    </style>
    <style>
        .errorMessages {
        }
    </style>
    <h1 class="main-title">Authenticate Image</h1>
    <div style="text-align: center !important; margin: auto !important; max-width: 50%;">
        <p>Please look through the instructions before submitting a request.</p>

        <div>
            <asp:Label ID="label_name" runat="server">Name</asp:Label>
            <asp:TextBox ID="textbox_name" placeholder="Your name.." runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ControlToValidate="textbox_name" ErrorMessage="Name is required." ForeColor="red" runat="server"></asp:RequiredFieldValidator>
            <br />

            <asp:Label ID="label_email" runat="server">Email</asp:Label>
            <asp:TextBox ID="textbox_email" placeholder="Your email.." runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Email is required." ForeColor="red" ControlToValidate="textbox_email" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" ValidationExpression="^([\w][\w\.\-]+)@([a-z]+)(((\.[A-z]{2,3}))+)$" ControlToValidate="textbox_email" ForeColor="red" ErrorMessage="Email address is invalid." Display="Dynamic"></asp:RegularExpressionValidator>
            <br />

            <asp:Label ID="label_notes" runat="server">Notes</asp:Label>
            <asp:TextBox ID="textbox_notes" placeholder="Additional information.. (Optional)" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />

            <div style="margin: auto; display: inline !important">
                <div>
                    <asp:FileUpload ID="FileUpload1" runat="server" accept="image/*" />
                    <asp:Button ID="Button1" runat="server" Text="Upload Image" OnClick="Button1_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
