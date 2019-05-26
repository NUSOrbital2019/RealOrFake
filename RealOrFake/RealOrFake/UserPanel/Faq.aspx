<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/User.Master" AutoEventWireup="true" CodeBehind="Faq.aspx.cs" Inherits="RealOrFake.UserPanel.Faq" %>
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

    <h1 class="main-title">Frequently Asked Questions</h1>
  
    <div style="width: 50%; margin: auto;">
<p class="accordion">How can I tell if a bag is authentic?</p>
<div class="panel">There are many factors that determine authenticity and this is a difficult question to answer.  What we can tell you, is that online research is not enough and self authenticating is not a good idea. Authenticators take years to learn the trade and have seen hundreds, if not thousands, of authentic and non authentic items.  They know what things have changed on a particular item or design, and when.  More often than not, the information found online is old, outdated or plain incorrect.</div>

<p class="accordion">Can I take this into a boutique and get an authentication?</p>
<div class="panel">You can try, but they will not put anything in writing.  They are actually told not to authenticate, because they are often wrong and are not trained to do so. This is a very big misconception. Unless they take a personal interest in authentication, they really have no clue and are just guessing/going off limited knowledge. It's really not worth the gamble.</div>

<p class="accordion">If I send you pictures of my bag, could you tell me if it’s real?</p>
<div class="panel">We have experts that cover many brands.  We have not had an instance yet where a determination was unable to be made.  If this were to happen, we would notify you immediately.</div>

<p class="accordion">How can you tell a well-made fake purse/wallet from an authentic one from just a visual digital inspection?</p>
<div class="panel">Sometimes telling an authentic from a non authentic is like solving a puzzle.  We must go over multiple aspects of the item, looking for the minute differences, piecing the evidence together to make a determination.  The so called "super fakes" aren't so super when you know what to look for, and more importantly, what is wrong.</div>
</div>

    <style>
/* Style the element that is used to open and close the accordion class */
p.accordion {
    background-color: #eee;
    color: #444;
    cursor: pointer;
    padding: 18px;
    width: 100%;
    text-align: left;
    border: none;
    outline: none;
    transition: 0.4s;
    margin-bottom:10px;
}

/* Add a background color to the accordion if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
p.accordion.active, p.accordion:hover {
    background-color: #ddd;
}

/* Unicode character for "plus" sign (+) */
p.accordion:after {
    content: '\2795'; 
    font-size: 13px;
    color: #777;
    float: right;
    margin-left: 5px;
}

/* Unicode character for "minus" sign (-) */
p.accordion.active:after {
    content: "\2796"; 
}

/* Style the element that is used for the panel class */

div.panel {
    padding: 0 18px;
    background-color: white;
    max-height: 0;
    overflow: hidden;
    transition: 0.4s ease-in-out;
    opacity: 0;
    margin-bottom:10px;
}

div.panel.show {
    opacity: 1;
    max-height: 500px; /* Whatever you like, as long as its more than the height of the content (on all screen sizes) */
}
</style>

<script>
/* Toggle between adding and removing the "active" and "show" classes when the user clicks on one of the "Section" buttons. The "active" class is used to add a background color to the current button when its belonging panel is open. The "show" class is used to open the specific accordion panel */
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        this.nextElementSibling.classList.toggle("show");
};
}

</script>
</asp:Content>
