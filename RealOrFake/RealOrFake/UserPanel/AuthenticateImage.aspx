<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="AuthenticateImage.aspx.cs" Inherits="RealOrFake.UserPanel.AuthenticateImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="main-title">Authenticate Image</h1>
    <div style="text-align: center !important; margin: auto !important">
        <p>Please ensure that you have look through the instructions before uploading an image.</p>

        <div style="margin: auto; display: inline !important">
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Button ID="Button1" runat="server" Text="Upload Image"/>
                 <%--OnClick="Button1_Click"--%> 
            </div>
        </div>
    </div>

</asp:Content>
