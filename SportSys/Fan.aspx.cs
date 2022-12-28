﻿using System;
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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace SportSys
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#pragma warning disable CS0252 // Possible unintended reference comparison; left hand side needs cast
            if (Session["username"] == null || Session["type"] != "fan")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            //string username = "shamekhjr";
            string username = Session["username"].ToString();
            string nid = ""; //initially empty until it is fetched
            
            //initially make the labels and gridviews not visible since there 
            //is no data yet
            MatchesGridView.Visible = false;
            PurchaseTicketLabel.Visible = false;
            PurchaseHistoryGridView.Visible = false;
            PurchaseHistoryExistsLabel.Visible = false;
            Blocked_stat.Visible= false;

            //display username
            UsernameLabel.Text = "Username: "+ username;

            //fetch NationalID
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the NationalID 
            SqlCommand getNID = new SqlCommand("fetchNID", conn);
            getNID.CommandType = System.Data.CommandType.StoredProcedure;

            //add input params
            getNID.Parameters.AddWithValue("@username", username);

            //specify output params
            SqlParameter NationalID = getNID.Parameters.Add("@NationalID", SqlDbType.VarChar,20);
            NationalID.Direction = ParameterDirection.Output;

            //open a connection and execute the procedure
            conn.Open();
            getNID.ExecuteNonQuery();

            //store NID in string var
            nid = NationalID.Value.ToString();

            //display NationalID and close the connection
            NIDLabel.Text = "NationalID: " + nid;
            conn.Close();

            //show purchase history
            showPurchasedTickets();
        }

        protected void userInFunc(object sender, EventArgs e)
        {
            //fetch the matches table but using the input time from the user
            //as input to the procedure
            getTheTable(false);
        }


        protected void currTimeFunc(object sender, EventArgs e)
        {
            //fetch the matches table but using the current timestamp
            //as input to the procedure
            getTheTable(true);
        }

        protected void getTheTable(bool now)
        {
            //determine datetime input based on user choice
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

            //add input params
            getMatches.Parameters.AddWithValue("@date", input);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getMatches.ExecuteReader();


            //create the DataTable that will be bound to the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Kick-Off Time", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium", typeof(string)));
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
                    dr["Kick-Off Time"] = rd[2];
                    dr["Stadium"] = rd[3];
                    dr["Stadium Location"] = rd[4];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            MatchesGridView.DataSource = dt;
            MatchesGridView.DataBind();

            //Make the GridView visible and close the connection
            MatchesGridView.Visible = true;
            conn.Close();
        }

        protected void MatchesGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "getTicket") return;

            //keep GridView Visible
            MatchesGridView.Visible = true;

            //check first if the fan is blocked
            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getStatus = new SqlCommand("fetchStatus", conn);
            getStatus.CommandType = System.Data.CommandType.StoredProcedure;

            //add input params
            getStatus.Parameters.AddWithValue("@username", UsernameLabel.Text.Split(' ')[1]);

            //specify output params
            SqlParameter status = getStatus.Parameters.Add("@status", SqlDbType.VarChar, 20);
            status.Direction = ParameterDirection.Output;

            //open a connection and execute the procedure
            conn.Open();
            getStatus.ExecuteNonQuery();

            //if the fan is blocked, display an error message then exit the function
            if (status.Value.ToString() == "0") {
                Blocked_stat.Visible= true;
                Blocked_stat.Text = "You are blocked. Cannot purchase ticket";
                return; 
            } 

            //partition the data
            string hostClub= e.CommandArgument.ToString().Split(';')[0];
            string guestClub = e.CommandArgument.ToString().Split(';')[1];
            string startTime = e.CommandArgument.ToString().Split(';')[2];

            //initialize the command that purchases the ticket 
            SqlCommand purchaseTicket = new SqlCommand("purchaseTicket", conn);
            purchaseTicket.CommandType = System.Data.CommandType.StoredProcedure;
            purchaseTicket.Parameters.AddWithValue("@host_name", hostClub);
            purchaseTicket.Parameters.AddWithValue("@guest_name", guestClub);
            purchaseTicket.Parameters.AddWithValue("@nid", NIDLabel.Text.Split(' ')[1]);
            purchaseTicket.Parameters.AddWithValue("@start_time", startTime);

            //open a connection and execute the procedure
            purchaseTicket.ExecuteNonQuery();

            //make label visible and tell the user that the ticket has been purchased
            //then close the connection
            PurchaseTicketLabel.Visible = true;
            PurchaseTicketLabel.Text = "Purchased ticket for the match between "+
                hostClub+" and "+ guestClub+" on "+startTime;
            conn.Close();

            //update purchase history
            showPurchasedTickets();
        }

        protected void showPurchasedTickets()
        {
            PurchaseHistoryLabel.Visible = true;

            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getMatches = new SqlCommand("getTicketsOfFan", conn);
            getMatches.CommandType = System.Data.CommandType.StoredProcedure;

            //add input params
            getMatches.Parameters.AddWithValue("@username", UsernameLabel.Text.Split(' ')[1]);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getMatches.ExecuteReader();


            //create the DataTable that will be bound to the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("TicketID", typeof(string)));
            dt.Columns.Add(new DataColumn("Fan Username", typeof(string)));
            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Location", typeof(string)));
            dt.Columns.Add(new DataColumn("Kick-Off Time", typeof(string)));


            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["TicketID"] = rd[0];
                    dr["Fan Username"] = rd[1];
                    dr["Host Club"] = rd[2];
                    dr["Guest Club"] = rd[3];
                    dr["Stadium"] = rd[4];
                    dr["Stadium Location"] = rd[5];
                    dr["Kick-Off Time"] = rd[6];

                    dt.Rows.Add(dr);
                }
            } else
            {
                //the table is empty
                //then the user hasn't purchased any tickets yet
                //show this as output to the user
                PurchaseHistoryExistsLabel.Visible = true;
                PurchaseHistoryExistsLabel.Text = "No purchase history";
            }

            //Bind GridView to table
            PurchaseHistoryGridView.DataSource = dt;
            PurchaseHistoryGridView.DataBind();

            //Make the GridView visible and close the connection
            PurchaseHistoryGridView.Visible = true;
            conn.Close();
        }

    }
}