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
    public partial class Stadium_manager : System.Web.UI.Page
    {
        protected void Page_Load1(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getstadiuminfo = new SqlCommand("StadiumINFO", conn);
            getstadiuminfo.CommandType = System.Data.CommandType.StoredProcedure;
            getstadiuminfo.Parameters.AddWithValue("@managername", "Ahmed");

            //Get table from db
            conn.Open();
            SqlDataReader rd = getstadiuminfo.ExecuteReader();


            //create the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Capacity", typeof(string)));
            dt.Columns.Add(new DataColumn("Location", typeof(string)));
            dt.Columns.Add(new DataColumn("Staduim manager id", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Status", typeof(string)));

            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr["Capacity"] = rd[0];
                    dr["Location"] = rd[1];
                    dr["Staduim manager id"] = rd[2];
                    dr["Stadium Name"] = rd[3];
                    dr["Status"] = rd[4];
                    dt.Rows.Add(dr);
                }
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
    }

       

        

        
    
}