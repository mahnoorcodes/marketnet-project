using System.Configuration;

namespace MarketNet.L5
{
    public static class Global
    {
        //Connection String variable
        static string vConnStr = ConfigurationManager.ConnectionStrings["MarketNet_Conn"].ConnectionString;

        public static string ConnStr
        {
            get { return vConnStr; }
            set { vConnStr = value; }
        }
        //DeptID
        static string vDeptID;
        public static string DeptID
        {
            get { return vDeptID; }
            set { vDeptID = value; }
        }
        //Employee ID
        static string vEmpID;
        public static string EmpID
        {
            get { return vEmpID; }
            set { vEmpID = value; }
        }
        //Error message
        static string vErrorMsg;
        public static string ErrorMsg
        {
            get { return vErrorMsg; }
            set { vErrorMsg = value; }
        }


    }

    
}
