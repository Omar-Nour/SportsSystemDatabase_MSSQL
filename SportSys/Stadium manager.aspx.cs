using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class Stadium_manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


#pragma warning disable CS0252 // Possible unintended reference comparison; left hand side needs cast
            if (Session["username"] == null || Session["type"] != "stadman")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            
            string username = Session["username"].ToString();
            //hardcoded username =Ahmed
            //string username = "Ahmed";

            UsernameLabel.Text = username;

            //initialy Stadium info does not appear
            GridView1.Visible = false;

        }





        protected void Viewstad(object sender, EventArgs e)
        {

            //hardcoded username =Ahmed

            string username = Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getstadiuminfo = new SqlCommand("StadiumINFO", conn);
            getstadiuminfo.CommandType = System.Data.CommandType.StoredProcedure;
            getstadiuminfo.Parameters.AddWithValue("@managername", username);

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
            GridView1.Visible = true;
            View.Visible = false;

        }

        protected void Viewhost(object sender, EventArgs e)
        {
            Response.Redirect("Hostrequests.aspx");
        }
    }
}