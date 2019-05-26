<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RealOrFake.UserPanel.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="banner" style="border-radius: 10px 10px 10px 10px;">
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../assets/img/news1.jpg" alt="" style="min-width: 100% !important; max-width: none; max-height: 600px;">
                    <div class="carousel-caption">
                        <h1>We help to identify whether a bag is real or fake.</h1>
                    </div>
                </div>
                <div class="item">
                    <img src="../assets/img/news2.jpg" alt="" style="min-width: 100% !important; max-width: none; max-height: 600px;">
                    <div class="carousel-caption">
                        <h1>We help to prevent you from being a victim of scams.</h1>
                    </div>
                </div>
                <div class="item">
                    <img src="../assets/img/news3.jpg" alt="" style="min-width: 100% !important; max-width: none; max-height: 600px;">
                    <div class="carousel-caption">
                        <h1>We help you to feel at ease shopping online.</h1>
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>
    <div class="content-wrap">
        <div class="main-title">
            <ul class="grid effect-8" id="grid">
                <li>
                    <h1>YOUR TRUSTED SERVICE</h1>
                    <h4>Strive to save you from being a victim.<br>
                        Stress-free purchases, with help of Real Or Fake.</h4>
                </li>
            </ul>

        </div>
    </div>

</asp:Content>
