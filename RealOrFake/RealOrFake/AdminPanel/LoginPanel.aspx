<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPanel.aspx.cs" Inherits="RealOrFake.AdminPanel.LoginPanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>

    <link href="../assets_AdminPanel/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../assets_AdminPanel/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
    <link href="../assets_AdminPanel/css/demo.css" rel="stylesheet" />
    
    <style>
        .loginPanel {
            width: 350px;
            height: 350px;
            background: white;
            margin: 4% auto 4% auto;
            box-shadow: 0 0 15px 1px rgb(164, 160, 160);
            background-color: #f4f6f5;
            position: relative;
        }

        .textbox {
            border: 1px solid #c4c4c4;
            font-size: large;
            padding: 4px 4px 4px 4px;
            border-radius: 20px;
            -moz-border-radius: 20px;
            -webkit-border-radius: 20px;
            box-shadow: 0px 0px 8px #d9d9d9;
            -moz-box-shadow: 0px 0px 8px #d9d9d9;
            -webkit-box-shadow: 0px 0px 8px #d9d9d9;
        }
    </style>

    <style>
        .loginCircle {
            width: 85px;
            height: 85px;
            padding: 10px;
            z-index: 2;
            background: #fcb341;
            border-radius: 50%;
            box-shadow: 0 0 2px rgba(0,0,0,0.1), 0 3px 2px rgba(0,0,0,0.1), inset 0 -3px 2px rgba(0,0,0,0.2);
            position: absolute;
            right: -40px;
            top: 35%;
            cursor: pointer;
        }

        .loginBtn {
            border: 0px solid #fcb341;
            margin-top: 30%;
            font-size: large;
            background: #fcb341;
            text-shadow: 1px 1px black;
            outline: none;
            cursor: pointer;
        }

        .loginCircle:hover .loginBtn {
            background: #f4c05e !important;
            transition: all 0.3s ease-out !important;
        }

        .loginCircle:hover, .loginBtn:hover .loginCircle {
            background: #f4c05e !important;
            transition: all 0.3s ease-out !important;
        }

        a.navbar-brand:hover {
            color: #1DC7EA;
        }
    </style>
</head>

<body style="background-color: #eff3f7; max-height:100vh !important; min-height:unset;">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg " color-on-scroll="500" style="background-color: #454d58;">
            <div class=" container-fluid  ">
                <a class="navbar-brand" href="#" style="color: white;">Real Or Fake's Admin Dashboard </a>
                <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-bar burger-lines"></span>
                    <span class="navbar-toggler-bar burger-lines"></span>
                    <span class="navbar-toggler-bar burger-lines"></span>
                </button>
            </div>
        </nav>
        <!-- End Navbar -->
        
        <div class="loginPanel" >
            <div style="text-align: center;">
                <br />
                <b style="font-family: copperplate gothic light; font-weight: bold; color: #f9bc6f; font-size: xx-large">LOGIN</b>

                <hr style="width: 50%; border-top: 1px solid #e1e1e1 !important; margin-top: 10px !important; margin-bottom: 15px !important">

                <br />
                <i style="font-family: Times New Roman; font-size: large;">Enter your username</i>

                <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox"></asp:TextBox>
                <br />
                <br />
                <i style="font-family: Times New Roman; font-size: large;">Enter your password</i>

                <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>

                <br />
                <br />

                <asp:RequiredFieldValidator ID="emptyUsername" runat="server" ErrorMessage="Please enter username." ForeColor="#da337a" Font-Names="Arial" Display="Dynamic" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>

                <div style="clear: both;"></div>

                <asp:RequiredFieldValidator ID="emptyPassword" runat="server" ErrorMessage="Please enter password." ForeColor="#da337a" Font-Names="Arial" Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>

                <div style="clear: both;"></div>

                <asp:CustomValidator ID="invalidUsernameOrPassword" runat="server" ErrorMessage="Invalid username or password." ForeColor="#da337a" Font-Names="Arial" ControlToValidate="txtPassword" Display="Dynamic"></asp:CustomValidator>

                <div class="loginCircle">
                    <asp:Button ID="BtnLogin" runat="server" Text="Login" OnClick="BtnLogin_Click" CssClass="loginBtn" />
                </div>

                <asp:Label ID="IncorrectInputLabel" runat="server" Text="" CssClass="text-danger"></asp:Label><br />
            </div>
        </div>
    </form>
</body>
</html>
