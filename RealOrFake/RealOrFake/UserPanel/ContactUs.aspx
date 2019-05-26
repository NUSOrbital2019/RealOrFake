<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="RealOrFake.UserPanel.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        input[type=text], select, textarea {
            width: 100%;
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
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 150px;
        }

            input[type=submit]:hover {
                background-color: #4f95ab;
            }
    </style>

    <style>
        h1 {
            font-size: 32px;
            color: #373435;
            font-family: 'source_sans_probold';
            letter-spacing: 3px;
            padding-bottom: 10px;
            text-transform: uppercase;
            text-align: center !important;
        }
    </style>

    <h1 class="main-title">Send Us A Message</h1>

    <div style="width: 50%; margin: auto;">

        <asp:Label ID="label_fname" runat="server">First Name</asp:Label>
        <asp:TextBox ID="textbox_fname" placeholder="Your first name.." runat="server"></asp:TextBox>


        <asp:Label ID="label_lname" runat="server">Last Name</asp:Label>
        <asp:TextBox ID="textbox_lname" placeholder="Your last name.." runat="server"></asp:TextBox>

        <asp:Label ID="label_email" runat="server">Email</asp:Label>
        <asp:TextBox ID="textbox_email" placeholder="Your email.." runat="server"></asp:TextBox>

        <asp:Label ID="label_message" runat="server">Message</asp:Label>
        <asp:TextBox ID="textbox_message" placeholder="Tell us about your problem.." runat="server" Style="height: 200px"></asp:TextBox>

        <div style="margin: auto; text-align: center;">
        <asp:Button ID="button_submit" runat="server" Text="Submit"  />
        </div>

    </div>
    <!--
    <div style="padding-top: 4%;">
        <table class="table" style="border-collapse: initial !important; border-spacing: 0;">
            <tr style="height: 5%;">
                <td style="background-color: #146882; color: #b1e3ed; font-family: 'Palatino Linotype'; font-size: 25px;">Get in Touch             
                    <br />
                    <span style="font-size: 12px; font-family: Arial; color: #5fa6c2;">let us know what you think</span>
                </td>

                <%-- Bookmark --%>
                <div style="z-index: 5; position: absolute; margin-left: 60%; padding-top: 1.3%;">
                    <div id="ribbon-head">
                    </div>
                    <div id="ribbon-tail">
                        <div id="left"></div>
                        <div id="right"></div>
                    </div>
                </div>
            </tr>

            <tr>
                <td>
                    <span class="numberCircle">
                        <span style="background-color: #4ea9da; color: white;">1</span>
                    </span>
                    <h4 style="float: left; color: #626b6e; font-family: Cambria;">Firstly, name your portfolio</h4>
                </td>
            </tr>

            <tr>
                <td>
                    <div style="padding: 10px; background-color: #f4f6f5;">
                        <asp:Label ID="Label1" runat="server" CssClass="toolbox">Username <span style="color: red;">*</span></asp:Label>
                        <br />
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="toolbox"></asp:TextBox>

                        <div style="float: right; margin-right: 5.5%;">
                            <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required" ForeColor="#da337a" ControlToValidate="txtUsername" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        </div>

                        <div style="clear: both;"></div>
                        <div style="float: right; margin-right: 5.5%;">
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUsername" ValidationExpression="(?!.*?[!#$%&'()*+,-.\/:;<=>?@[\]^_`{|}~ ])^.*$" ErrorMessage="Username is invalid. It contains special character." ForeColor="#da337a" Display="Dynamic">--%>
                            <%--</asp:RegularExpressionValidator>--%>

                            <%--<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtUsername" Display="Dynamic" OnServerValidate="restrictedWords_ServerValidate" ForeColor="#da337a"></asp:CustomValidator>--%>
                        </div>

                        <div style="margin-right: 5.5%; float: right;">
                            <%--<asp:CustomValidator ID="CustomValidator2" runat="server" OnServerValidate="Username_ServerValidate" Display="Dynamic" ErrorMessage="Username has been used." ForeColor="#da337a" ControlToValidate="txtUsername"></asp:CustomValidator>--%>
                        </div>

                        <div style="clear: both;"></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    -->
</asp:Content>
