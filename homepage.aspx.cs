using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MarketNet.L5
{
    public partial class HomePage : System.Web.UI.Page
    {
        DataComponent ObjDC;
        DataTable DTEmployeeDetails;
        string edid, query, ConnStr, ErrorMsg;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ddlTheme_SelectedIndexChanged(object sender, EventArgs e)
        {
            string SelectedTheme = string.Empty;

            if (ddlTheme.SelectedValue.ToString() == "0")
            {
                SelectedTheme = "LightTheme.css";
            }
            else
            {
                SelectedTheme = "DarkTheme.css";
            }
            var themeLink = Page.Header.FindControl("PageTheme") as HtmlLink;
            themeLink.Attributes["href"] = SelectedTheme;
        }
        protected void btnlogout_click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");

        }
        protected void btnsearch_click(object sender, EventArgs e)
        {
            //idempl_TextChanged(sender, e);
            BindgvEmployeeSearch();
        }

        private void BindgvEmployeeSearch()
        {
            string searchidempl = idempl.Text.Trim();
            DataTable DTEmployeeDetails = new DataTable();
            ObjDC = new DataComponent();
            DTEmployeeDetails = ObjDC.EmployeeDetails();
            string ConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;
            SqlConnection sqlconn = new SqlConnection(ConnStr);
            SqlDataAdapter da;
            sqlconn.Open();
            SqlCommand cmd = new SqlCommand("Select * from EmployeeDetails where EDID =@EmpID", sqlconn); 
            cmd.Parameters.AddWithValue("@EmpID", idempl.Text);
            DataTable DTEmployeeSearch = new DataTable();
            da = new SqlDataAdapter(cmd);
            da.Fill(DTEmployeeSearch);
            gvEmployeeSearch.DataSource = DTEmployeeSearch;
            gvEmployeeSearch.DataBind();//from stackoverflow

            idbtnupdate.Visible = true;
            updtfname.Visible = true;
            updtfname.Text = DTEmployeeSearch.Rows[0]["EDFName"].ToString();
            updtlname.Visible = true;
            updtlname.Text = DTEmployeeSearch.Rows[0]["EDLName"].ToString();
            updtgender.Visible = true;
            updtgender.SelectedValue = (DTEmployeeSearch.Rows[0]["EDGender"].ToString());
            updtemail.Visible = true;
            updtemail.Text = DTEmployeeSearch.Rows[0]["EDEmail"].ToString();
            updtmobnum.Visible = true;
            updtmobnum.Text = DTEmployeeSearch.Rows[0]["EDMobNum"].ToString();
            updtdmid.Visible = true;
            updtdmid.Text = DTEmployeeSearch.Rows[0]["EDDMID"].ToString();
            updtvisasts.Visible = true;
            updtvisasts.Text = DTEmployeeSearch.Rows[0]["EDVisaSts"].ToString();
            updtaddress.Visible = true;
            updtaddress.Text = DTEmployeeSearch.Rows[0]["EDAddress"].ToString();
            updtemplsts.Visible = true;
            updtemplsts.Text = DTEmployeeSearch.Rows[0]["EDEmplSts"].ToString();
            LblMsg.Visible = true;
        }
        private bool IsValidEmployeeStatus(string status)
        {
            return status == "Active" || status == "InActive" || status == "Vacation" || status == "Emergency";
        }
        protected void btnupdate_click(object sender, EventArgs e)
        {
            string ConnStr = "MarketNet_Conn";
            string empid = idempl.Text.Trim(); //textbox from empl id search
            string fname = updtfname.Text.Trim();
            string lname = updtlname.Text.Trim();
            string gender = updtgender.SelectedValue;
            string email = updtemail.Text.Trim();   
            string mobnum = updtmobnum.Text.Trim();
            string dmid = updtdmid.Text.Trim();
            string visasts = updtvisasts.Text.Trim();
            string address = updtaddress.Text.Trim();
            string emplsts = updtemplsts.Text.Trim();
            if (string.IsNullOrEmpty(emplsts))
            {
                emplsts = "Active";
            }
            if (!IsValidEmployeeStatus(emplsts))
            {
                LblMsg.Text = "Invalid Status";
                return;
            }

            ConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;

            using (SqlConnection sqlconn = new SqlConnection(ConnStr))
            {
                sqlconn.Open();
                using (SqlCommand command = new SqlCommand("SPUpdtEmpDtls", sqlconn))
                {
                      command.CommandType = CommandType.StoredProcedure;
                      command.Parameters.AddWithValue("@EDDMID", dmid);     
                      command.Parameters.AddWithValue("@EDID", empid);
                      command.Parameters.AddWithValue("@EDFName", fname);
                      command.Parameters.AddWithValue("@EDLName", lname);
                      command.Parameters.AddWithValue("@EDGender", gender);
                      command.Parameters.AddWithValue("@EDEmail", email);
                      command.Parameters.AddWithValue("@EDMobNum", mobnum);
                      command.Parameters.AddWithValue("@EDVisaSts", visasts);
                      command.Parameters.AddWithValue("@EDAddress", address);
                      command.Parameters.AddWithValue("@EDEmplSts", emplsts);
                      int rowsAffected = command.ExecuteNonQuery(); //updates all at once
                   
                    if (rowsAffected > 0)
                    {
                        LblMsg.Text = "Update successful";
                        BindgvEmployeeSearch(); //refresh
                    }
                    else
                    {
                        Global.ErrorMsg = ErrorMsg;
                        LblMsg.Text = "Update failed. Please try again.";
                    }
                 
                }
            }
        }
    }
}
