using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace MarketNet.L5
{
    public class DataComponent
    {
        string ConnStr, email, password, empid, deptID, fname, lname, gender, mobnum, desig,
        doj, dob, bldgrp, nationlty, visasts, address, emgcontname, emgcontrel, emgcontnum, emplsts,
        marsts, nodpn;

        int result;
        SqlParameter[] paramlist;
        public string ErrorMsg = String.Empty;
        DataSet DSEmployee = new DataSet();

        //CONSTRUCTORS
        public DataComponent()
        {
            ConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;

        }
        public DataComponent(string pemail, string ppassword, string pdeptID, string peid, string pfname, string plname, string pgender, string pmobnum, string pdesig,
        string pdoj, string pdob, string pbldgrp, string pnationlty, string pvisasts, string paddress, string pemgcontname, string pemgcontrel, string pemgcontnum, string pemplsts,
        string pmarsts, string pnodpn)
        {
            email = pemail;
            password = ppassword;
            deptID = pdeptID;
            empid = peid;
            fname = pfname;
            lname = plname;
            gender = pgender;
            mobnum = pmobnum;
            desig = pdesig;
            doj = pdoj;
            dob = pdob;
            bldgrp = pbldgrp;
            nationlty = pnationlty;
            visasts = pvisasts;
            address = paddress;
            emgcontname = pemgcontname;
            emgcontrel = pemgcontrel;
            emgcontnum = pemgcontnum;
            emplsts = pemplsts;
            marsts = pmarsts;
            nodpn = pnodpn;
        }
        //METHODS
        public bool UpdtEmpDtls()
        {
            try
            {
                paramlist = new SqlParameter[20];
                paramlist[0] = new SqlParameter("@EDID", empid);
                paramlist[1] = new SqlParameter("@EDFName", fname);
                paramlist[2] = new SqlParameter("@EDLName", lname);
                paramlist[3] = new SqlParameter("@EDGender", gender);
                paramlist[4] = new SqlParameter("@EDEmail", email);
                paramlist[5] = new SqlParameter("@EDMobNum", mobnum);
                paramlist[6] = new SqlParameter("@EDDesig", desig);
                paramlist[7] = new SqlParameter("@EDDMID", deptID);
                paramlist[8] = new SqlParameter("@EDDOJ", doj);
                paramlist[9] = new SqlParameter("@EDDOB", dob);
                paramlist[10] = new SqlParameter("@EDBldGrp", bldgrp);
                paramlist[11] = new SqlParameter("@EDNationlty", nationlty);
                paramlist[12] = new SqlParameter("@EDVisaSts", visasts);
                paramlist[13] = new SqlParameter("@EDAddress", address);
                paramlist[14] = new SqlParameter("@EDEmgContName", emgcontname);
                paramlist[15] = new SqlParameter("@EDEmgContRel", emgcontrel);
                paramlist[16] = new SqlParameter("@EDEmgContNum", emgcontnum);
                paramlist[17] = new SqlParameter("@EDEmplSts", emplsts);
                paramlist[18] = new SqlParameter("@EDMarSts", marsts);
                paramlist[19] = new SqlParameter("@EDNoDpn", nodpn);

                result = Convert.ToInt32(SqlHelper.ExecuteScalar(Global.ConnStr, CommandType.StoredProcedure, "SPUpdtEmpDtls", paramlist).ToString());
                return (result == 1 ? true : false);
            }
            catch (Exception e)
            {
                ErrorMsg = e.Message;
                return false;
            }
        }
        public bool LoginUser()
        {
            try
            {
                paramlist = new SqlParameter[3];
                paramlist[0] = new SqlParameter("@Email", email);
                paramlist[1] = new SqlParameter("@Password", password);
                paramlist[2] = new SqlParameter("@DeptID", Global.DeptID);

                empid = SqlHelper.ExecuteScalar(Global.ConnStr, CommandType.StoredProcedure, "SPMarketNetLogin", paramlist).ToString();
                Global.EmpID = empid;                
                return true;
            }
            catch (Exception e)
            {
                ErrorMsg = e.Message;
                Global.ErrorMsg = ErrorMsg;
                return false;
            }
        }

        public DataSet GetDSEmployee()
        {
            return DSEmployee;
        }


        public DataTable EmployeeDetails()
        {
            DataSet DSEmployee = null;
            DataTable DTEmployeeDetails = new DataTable();
            try
            {
                paramlist = new SqlParameter[2];
                paramlist[0] = new SqlParameter("@EmpID", Global.EmpID);
                paramlist[1] = new SqlParameter("@DeptID", Global.DeptID);

                DSEmployee = SqlHelper.ExecuteDataset(Global.ConnStr,CommandType.StoredProcedure, "SPGetEmpDtls", paramlist);
                //Global.EmpID = empid;
                //Global.DeptID = deptID;
            }
            catch (Exception ex)
            {
                ErrorMsg = ex.Message;
                Global.ErrorMsg = ErrorMsg;
                return null;
            }
            if (DSEmployee != null && DSEmployee.Tables.Count > 0)   //passed thru after declaring DSEmployee out of try block
            {
                return DSEmployee.Tables[0];  //no employee details avaliable
            }
            else
            {
                return null;
            }

        }

    }
}
