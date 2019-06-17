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

    <style>
        main {
            min-width: 320px;
            max-width: 800px;
            margin: 0 auto;
            float: left;
            margin-left: -1%;
        }

            main input {
                display: none;
            }

            main label {
                display: inline-block;
                margin: 0 0 -1px;
                padding: 15px 25px;
                font-weight: 600;
                text-align: center;
                color: white;
                border: 1px solid transparent;
            }

                main label:before {
                    font-family: fontawesome;
                    font-weight: normal;
                    margin-right: 10px;
                }

                main label[for*='3']:before {
                    content: '\26A0';
                }

                main label[for*='1']:before {
                    content: '\270D';
                }

                main label[for*='2']:before {
                    content: '\2713';
                }

                main label:hover {
                    color: black;
                    cursor: pointer;
                }

            main input:checked + main label {
                color: #555;
                border: 1px solid #ddd;
                border-top: 3px solid white;
                border-bottom: 1px solid #fff;
            }

        #ContentPlaceHolder1_div_tab1, #ContentPlaceHolder1_div_tab2, #ContentPlaceHolder1_div_tab3 {
            /*border-top: 3px solid orange;*/
            /*border-bottom: 1px solid #fff;*/
            box-shadow: 5px 3px 3px black;
            border-radius: 5px;
            font-size: medium;
        }

        #tab1:checked ~ #content1,
        #tab2:checked ~ #content2,
        #tab3:checked ~ #content3,
        #tab4:checked ~ #content4 {
            display: block;
        }

        .card label {
            color: white;
            font-size: medium;
            font-weight: bold;
        }
    </style>

    <style>
        #ContentPlaceHolder1_txtPasswordAuthenticate {
            border: 1px solid #555;
        }

            #ContentPlaceHolder1_txtPasswordAuthenticate:focus {
                border: 3px solid #555;
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

    <div class="card-header" style="z-index: 100;">
        <%--   <h4 class="card-title">Pending Submissions</h4>--%>
        <main style="display: inline-flex;">
            <asp:RadioButton ID="tab1" runat="server" GroupName="tabs" Checked="true" />
            <div id="div_tab1" runat="server" style="z-index: 1050; background-color: #ff7558;">
                <asp:LinkButton ID="label_tab1_pending" runat="server" OnClick="label_tab1_pending_Click"><label for="tab1">Pending</label></asp:LinkButton>
            </div>

            <asp:RadioButton ID="tab2" runat="server" GroupName="tabs" />
            <div id="div_tab2" runat="server" style="background-color: #2087b0; opacity: 0.3;">
                <asp:LinkButton ID="label_tab2_approved" runat="server" OnClick="label_tab2_approved_Click"><label for="tab2">Approved</label></asp:LinkButton>
            </div>

            <asp:RadioButton ID="tab3" runat="server" GroupName="tabs" />
            <div id="div_tab3" runat="server" style="background-color: #e14654; opacity: 0.3;">
                <asp:LinkButton ID="label_tab3_rejected" runat="server" OnClick="label_tab3_rejected_Click"><label for="tab3">Rejected</label></asp:LinkButton>
            </div>
        </main>
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
                OnRowCommand="GridView1_RowCommand" Font-Size="Small" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="SubmissionDate" HeaderText="Submission Date" />
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
                                EnableViewState="true" ViewStateMode="Enabled" CssClass="btn btn-warning" Width="120" Font-Size="Small">
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
                                CssClass="btn btn-danger" CommandName="DeleteSubmission"
                                UseSubmitBehavior="False" CommandArgument='<%# Eval("imagePath") %>' Font-Size="Small" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
        </div>
    </div>
</asp:Content>
