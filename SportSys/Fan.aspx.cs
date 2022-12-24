using System;
using System.Collections.Generic;
using System.Data;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            UsernameLabel.Text = "username: " + Session["username"];
            NIDLabel.Text = "NantionalID: ";
            MatchesGridView.Visible = false;
            PurchaseTicketLabel.Visible = false;
        }

        protected void userInFunc(object sender, EventArgs e)
        {
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getMatches = new SqlCommand("availableMatchesToAttendProcedure", conn);
            getMatches.CommandType = System.Data.CommandType.StoredProcedure;
            getMatches.Parameters.AddWithValue("@date", DateTimeBox.Text);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getMatches.ExecuteReader();


            //create the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Start Time", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Location", typeof(string)));

            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Host Club"] = rd[0];
                    dr["Guest Club"] = rd[1];
                    dr["Start Time"] = rd[2];
                    dr["Stadium Name"] = rd[3];
                    dr["Stadium Location"] = rd[4];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            MatchesGridView.DataSource = dt;
            MatchesGridView.DataBind();
            MatchesGridView.Visible = true;
        }


        protected void currTimeFunc(object sender, EventArgs e)
        {
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getMatches = new SqlCommand("availableMatchesToAttendProcedure", conn);
            getMatches.CommandType = System.Data.CommandType.StoredProcedure;
            getMatches.Parameters.AddWithValue("@date", DateTime.Now);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getMatches.ExecuteReader();


            //create the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Start Time", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Location", typeof(string)));

            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Host Club"] = rd[0];
                    dr["Guest Club"] = rd[1];
                    dr["Start Time"] = rd[2];
                    dr["Stadium Name"] = rd[3];
                    dr["Stadium Location"] = rd[4];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            MatchesGridView.DataSource = dt;
            MatchesGridView.DataBind();
            MatchesGridView.Visible = true;
        }


    }
}