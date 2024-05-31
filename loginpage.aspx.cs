using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MarketNet.L5
{
    public partial class LoginPage : System.Web.UI.Page
    {
        string email, password, deptID, ConnStr, ErrorMsg;
        DataComponent ObjDC;
        protected void Page_Load(object sender, EventArgs e)
        {
            ConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;
            SqlConnection sqlconn = new SqlConnection(ConnStr);
            try
            {
                sqlconn.Open();
                lblmsg.Text = "SQL Connection was successful!";
            }
            catch (Exception ex)
            {
                lblmsg.Text = "Exception Caught! Details" + ex.Message.ToString();
            }
            sqlconn.Close();
        }
        protected void btnlogin_click(object sender, EventArgs e)
        {
            string email = idemail.Text.Trim(); //admin table 
            string password = idpass.Text.Trim();
            Global.DeptID = iddept.Text.Trim().ToString();
            string ConnStr = "MarketNet_Conn";

            if (email == string.Empty || password == string.Empty || Global.DeptID == string.Empty)
            {
                lblmsg.Text = "Please complete this field!";
                return;
            }
            /*ObjDC = new.DataComponent();*/

            ConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;
            using (SqlConnection sqlconn = new SqlConnection (ConnStr))
            {
                using (SqlCommand command = new SqlCommand("SPMarketNetLogin", sqlconn))
                {
                    sqlconn.Open();
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@DeptID", Global.DeptID);
                    
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        string userId = result.ToString();

                        if (!string.IsNullOrEmpty(userId))
                        {
                            // User authenticated successfully
                            Response.Redirect("HomePage.aspx");
                        }
                    }
                }
            }
            Global.ErrorMsg = ErrorMsg;
            lblmsg.Text = "Invalid Details. Please try again!";

        }
    }
}
