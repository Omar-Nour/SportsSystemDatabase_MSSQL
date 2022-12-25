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
using System.Windows.Forms;

namespace SportSys
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = "shamekhjr";
            //string username = Session["username"].ToString();
            string nid = ""; //initially empty until it is fetched
            
            //initially make the label and gridview not visible since there 
            //is no data yet
            MatchesGridView.Visible = false;
            PurchaseTicketLabel.Visible = false;

            //display username
            UsernameLabel.Text = "username: "+ username;

            //fetch NationalID
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the NationalID 
            SqlCommand getNID = new SqlCommand("fetchNID", conn);
            getNID.CommandType = System.Data.CommandType.StoredProcedure;
            getNID.Parameters.AddWithValue("@username", username);

            //specify output
            SqlParameter NationalID = getNID.Parameters.Add("@NationalID", SqlDbType.VarChar,20);
            NationalID.Direction = ParameterDirection.Output;

            //open a connection and execute the procedure
            conn.Open();
            getNID.ExecuteNonQuery();
            nid = NationalID.Value.ToString();

            //display NationalID
            NIDLabel.Text = "NantionalID: " + nid;
            
        }

        protected void userInFunc(object sender, EventArgs e)
        {
            getTheTable(false);
        }


        protected void currTimeFunc(object sender, EventArgs e)
        {
            getTheTable(true);
        }

        protected void getTheTable(bool now)
        {
            string input = "";
            if (now)
            {
                input = DateTime.Now.ToString();
            } else
            {
                input = DateTimeBox.Text;
            }
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getMatches = new SqlCommand("availableMatchesToAttendProcedure", conn);
            getMatches.CommandType = System.Data.CommandType.StoredProcedure;
            getMatches.Parameters.AddWithValue("@date", input);

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

            //Create button column


            //Make the GridView visible
            MatchesGridView.Visible = true;
        }

        protected void MatchesGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "getTicket") return;

            //keep GridView Visible
            MatchesGridView.Visible = true;

            //Make label visible and display data of coressponding tuple (testing)
            PurchaseTicketLabel.Visible = true;
            PurchaseTicketLabel.Text = e.CommandArgument.ToString();
        }


    }
}