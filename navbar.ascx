<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="MarketNet.L5.NavBar" %>

    <header>
        <style>
            .header, .nav-link {
                display: inline;
                justify-content: flex-end;
                margin-inline: 50px;
                font-size: 20px;
                padding-top: 30px;
                margin-bottom:0;
                padding-bottom:0;
            }
            .navbar{
                display: flex; 
                justify-content: left;
                align-items:flex-start;
                background-color: white;
                margin-bottom:0;
                height: 120px;
                
            }
            #marketlogo {
                background-image: url('https://res.cloudinary.com/djm2h1vqr/image/upload/v1707735526/Market_bqokyv.png');
                background-size: contain;
                background-repeat: no-repeat;
                height: 200px;
                width: 160px;
                display: flex;
                align-items: flex-start;
                justify-content: left;
                margin-right: 200px;
            }
            .navbar-nav {
                margin: 0; /* Remove default margin */
                padding: 0; /* Remove default padding */
                margin-bottom:0;
                padding-left: 20px;
            }

        </style>
    </header>
   
            <nav class="navbar navbar-expand ">
                <div class="header" id="marketlogo">
                 </div>

                <div class="header"> 
                    <ul class="navbar-nav">
                
                        <li class="nav-item active">
                            <a class="nav-link" href="#">Home</a>
                        </li>
                 
                        <li class="nav-item active">
                            <a class="nav-link" href="LoginPage.aspx">Login</a>
                        </li>
                    </ul>
                </div>
            </nav> 
          
        
