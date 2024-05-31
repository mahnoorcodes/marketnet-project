<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="MarketNet.L5.HomePage" %>
<%@ Register Src="~/NavBar.ascx" TagPrefix="uc1" TagName="NavBar" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
        <link rel="stylesheet" href="LightTheme.css" type="text/css" id="PageTheme" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
    
        }
        img{
            position:absolute;
            right:0;
            padding-top:50px; 
            object-fit:contain;

        }
        .container-fluid{
            border-radius:20px; 
            background:white;
            padding-top:10px;
            padding-bottom:10px;
            padding-left:40px;
            padding-right:40px;
            width:fit-content;
        }
        .col-auto {
            color: white;
            font-weight: bold;
            padding-top: 10px;
            padding-left: 60px
        }
        .smallGridView{
            width:100%;
            height:100%;
            overflow:auto;
            font-size:10px;
            background-color:white;
            text-align: center;
            border: 1px solid black;
        }
        .smallGridView td, .smallGridView th{
            border: 1px solid black;
        }
        .updt{
            width: 200px;
            max-width: 100%;
            height: 40px;
            justify-content: flex-start;
            padding: 4px;
            margin-right: 20px
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <header>
            <uc1:NavBar runat="server" ID="NavBar" />    
        </header>
            <article class="mt-3">
                 <div class="row justify-content-between align-items-center" <%--style="background-color:#65ad8a"--%>>
                    <div class="col-auto">
                        <h1>Dashboard</h1>
                    </div>

                    <div class="col-auto" style="padding-left:500px"> <%--CHANGE THEME--%>
                        Change theme
                        <asp:DropDownList id="ddlTheme" runat="server" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled" CssClass="ddl">
                            <asp:ListItem Text="Light" Value="0" />
                            <asp:ListItem Text="Dark" Value="1" />
                        </asp:DropDownList>
                    </div> 

                    <div class="col-auto" style="padding-right:60px"> <%--LOGOUT--%>
                        <asp:Button runat="server" ID="idbtnlogout" Text="Logout" OnClick="btnlogout_click" CssClass="btn btn-primary"/>
                    </div>
                </div>  
                
                
              <%--  EMPLOYEE ID SEARCH--%>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 d-flex align-items-center" style="color:black; font-size:20px"> 
                            Employee ID
                            <asp:TextBox runat="server" ID="idempl" name="Employee ID" class="form-control" style="width: 150px; max-width: 100%;margin-left:60px"/>
                            <asp:Button runat="server" ID="idbtnsearch" Text="Search" OnClick="btnsearch_click" CssClass="btn btn-primary" style="margin-left:20px"/> <%--Search Button--%>
                        </div>
                    </div> 
                    <div class="row" >
                         <div class="col-12 d-flex align-items-center" style="padding-top:10px; padding:5px">
                              <asp:GridView runat="server" ID="gvEmployeeSearch" AutoGenerateColumns="true" cssclass="smallGridView" autofit="true" >
                                  <EmptyDataTemplate>No data available!</EmptyDataTemplate>
                              </asp:GridView> 
                         </div>
                    </div>
                    
              <%-- EMPLOYEE UPDATE --%>
                    <div class="row">
                        <div class="col-12 d-flex" style="padding:5px;justify-content:left"> 
                            <asp:TextBox runat="server" ID="updtfname" name="updtfname" class="form-control" CssClass="updt" Visible="false"/>
                            <asp:TextBox runat="server" ID="updtlname" name="updtlname" class="form-control" CssClass="updt" visible="false"/>
                            <asp:RadioButtonList runat="server" ID="updtgender" cssclass="form-control" visible="false" style="width: 200px;max-width: 100%;margin-right: 20px">
                                <asp:ListItem Text="Male" Value="M"/>
                                <asp:ListItem Text="Female" Value="F"/>
                            </asp:RadioButtonList>
                            <asp:TextBox runat="server" ID="updtemail" name="updtemail" class="form-control" CssClass="updt" Visible="false"/>
                            <asp:TextBox runat="server" ID="updtmobnum" name="updtmobnum" class="form-control" CssClass="updt" visible="false"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 d-flex" style="padding:10px; justify-content:left"> 
                            <asp:TextBox runat="server" ID="updtdmid" name="updtdmid" class="form-control" cssclass="updt" visible="false"/>
                            <asp:TextBox runat="server" ID="updtvisasts" name="updtvisasts" class="form-control" CssClass="updt" Visible="false"/>
                            <asp:TextBox runat="server" ID="updtaddress" name="updtaddress" class="form-control" CssClass="updt" visible="false"/>
                            <asp:TextBox runat="server" ID="updtemplsts" name="updtemplsts" class="form-control" CssClass="updt" visible="false"/>
                        </div>
                        <div class="col-12"> <%--Update Button--%>
                            <asp:Button runat="server" ID="idbtnupdate" Text="Update" OnClick="btnupdate_click" CssClass="btn btn-primary" visible="false" style="justify-items:flex-end"/>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 d-flex align-items-center"><%-- Label message--%>
                            <asp:Label ID="LblMsg" runat="server" Visible="false"  style="color:red"/>
                        </div>
                    </div>
                </div>           
        </article>
    </form>

            <!-- Bootstrap JS -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script> 
</body>
</html>


