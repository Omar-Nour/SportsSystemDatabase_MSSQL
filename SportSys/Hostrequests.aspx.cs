using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
	public partial class Hostrequests : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            //hardcoded username =Ahmed

            string username = Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getallreq = new SqlCommand("ALLREQ", conn);
            getallreq.CommandType = System.Data.CommandType.StoredProcedure;
            getallreq.Parameters.AddWithValue("@STADUSERNAME", username);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getallreq.ExecuteReader();


            //create the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Club representative", typeof(string)));
            dt.Columns.Add(new DataColumn("STADIUM MANAGER NAME", typeof(string)));
            dt.Columns.Add(new DataColumn("Status", typeof(string)));
            dt.Columns.Add(new DataColumn("Host", typeof(string)));
            dt.Columns.Add(new DataColumn("Start Time", typeof(string)));
            dt.Columns.Add(new DataColumn("End Time", typeof(string)));
            dt.Columns.Add(new DataColumn("HOST ID", typeof(string)));



            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr["Club representative"] = rd[0];
                    dr["STADIUM MANAGER NAME"] = rd[1];
                    dr["Status"] = rd[2];
                    dr["Host"] = rd[3];
                    dr["Start Time"] = rd[4];
                    dr["End Time"] = rd[5];
                    dr["HOST ID"] = rd[6];


                    dt.Rows.Add(dr);
                }
            }

            allreq.DataSource = dt;
            allreq.DataBind();
        }
        protected void Viewpend(object sender, EventArgs e)
        {
            Response.Redirect("pending requests.aspx");
        }
    }
}