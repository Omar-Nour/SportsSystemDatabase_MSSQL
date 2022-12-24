using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class Fan : System.Web.UI.Page
    {
        StringBuilder matchesTable = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {

            Label1.Text = "username: " + Session["username"];

            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getMatches = new SqlCommand("availableMatchesToAttendProcedure",conn);
            getMatches.CommandType = System.Data.CommandType.StoredProcedure;
            getMatches.Parameters.AddWithValue("@date", DateTime.Now);

            //Reading output from db
            //SqlDataReader rd = getMatches.ExecuteReader();
            //matchesTable.Append("<table border='1'>");
            //matchesTable.Append("<tr><th>");




        }
    }


}