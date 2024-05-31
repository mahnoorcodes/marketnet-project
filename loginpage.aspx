<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="MarketNet.L5.LoginPage" UnobtrusiveValidationMode="none"%>
<%@ Register Src="~/NavBar.ascx" TagPrefix="uc1" TagName="NavBar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
    
        }
        .container-fluid{
            border-radius:25px;
            background:white;
            padding-top:10px;
            padding-bottom:10px;
            padding-left:60px;
            padding-right:60px;
            width:fit-content;
        }
        .col-12{
            color: black;
            font-size: 15px; 
        }
        body{
            background-image: url(' https://res.cloudinary.com/djm2h1vqr/image/upload/v1707806637/Untitled_design_lgjing.png');
            background-size: cover;
            background-position: center;                   
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <header>
            <uc1:NavBar runat="server" ID="NavBar" />
        </header>
            <article class="mt-3">
                <div class="row justify-content-center" style="color:#65ad8a;font-weight:bold;text-align:center;font-size:40px;padding-top:0">
                    Good to see you again
                </div>

                <div class="container-fluid">
                    <div class="row justify-content">
                        <div class="col-12 text-center">
                            <h3> Login</h3>
                        </div>
                    </div>

                    <br />

                    <div class="row justify-content"> <%--Email label and field--%>
                        <div class="col-12 text-center">
                            <asp:Label runat="server" Text="Email" />
                        </div>
                    </div>

                    <div class="row justify-content">
                        <div class="col-12 d-flex justify-content-center flex-column">
                            <asp:TextBox runat="server" ID="idemail" textmode="Email" name="email" class="form-control" style="width: 300px; max-width: 100%;"/>
                            <asp:RequiredFieldValidator ID="rfvidemail" runat="server" ControlToValidate="idemail" ErrorMessage="Please enter valid email!" 
                            ValidationGroup="RegPartOne" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revidemail" runat="server" ControlToValidate="idemail" ValidationExpression="^((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[;]{0,1}\s*)+$"
                             ErrorMessage="Please enter valid email!" ValidationGroup="RegPartOne" Display="Dynamic" ForeColor="Red"/>
                        </div>
                    </div>

                    <br />

                    <div class="row justify-content"> <%--Password label and field--%>
                        <div class="col-12 text-center">
                            <asp:Label runat="server" Text="Password"/>
                        </div>
                    </div>

                    <div class="row justify-content">
                        <div class="col-12 d-flex justify-content-center flex-column">
                            <asp:TextBox runat="server" ID="idpass" textmode="Password" name="password" class="form-control" style="width: 300px; max-width: 100%;"/>
                            <asp:RequiredFieldValidator ID="rfvidpass" runat="server" ControlToValidate="idpass" ErrorMessage="Please enter correct password!" 
                             ValidationGroup="RegpartOne" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>     
                        </div>
                    </div>

                    <br /> 

                    <div class="row justify-content"> <%--Department label and field--%>
                        <div class="col-12 text-center">
                            <asp:Label runat="server" Text="Admin ID"/>
                        </div>
                    </div>

                    <div class="row justify-content">
                        <div class="col-12 d-flex justify-content-center">
                            <asp:TextBox runat="server" ID="iddept" name="department" class="form-control" style="width: 300px; max-width: 100%;"/>
                        </div>
                    </div>

                    <div class="row justify-content">  <%--Label message--%>
                        <div class="col-12 text-center">
                            <asp:label runat="server" id="lblmsg" style="color:red" />
                        </div>
                    </div>

                    <div class="row justify-content"> <%--Login Button--%>
                        <div class="col-12 text-center">
                            <asp:Button runat="server" ID="idbtnlogin" text="Login" onclick="btnlogin_click" CssClass="btn btn-primary"/>
                        </div>
                    </div>             
                </div>
            </article>
    </form>
    <!-- Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script> 
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
