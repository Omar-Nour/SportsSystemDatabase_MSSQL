using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace SportSys
{
    public partial class SAM_View_Played : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#pragma warning disable CS0252 // Possible unintended reference comparison; left hand side needs cast
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Played_Sys_User_name.Text = Session["username"].ToString();

            Int64 total = 0;

            View_played_view.Visible = true;

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand View_Played = new SqlCommand("select StartTime, EndTime, C1.name AS Host_Name, C2.name AS Guest_Name\r\nfrom Match INNER JOIN Club C1 ON Match.HostClubID = C1.id \r\nINNER JOIN Club C2 ON Match.GuestClubID = C2.id\r\nWHERE EndTime < CURRENT_TIMESTAMP", conn);
            
            conn.Open();
            SqlDataReader rd = View_Played.ExecuteReader();
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Start time", typeof(string)));
            dt.Columns.Add(new DataColumn("End time", typeof(string)));

            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Host Club"] = rd[2];
                    dr["Guest Club"] = rd[3];
                    dr["Start Time"] = rd[0];
                    dr["End time"] = rd[1];
                    dt.Rows.Add(dr);
                    total += 1;
                }
            }

            else
            {
                Status.Text = "No past matches found";
                Status.Visible = true;
            }

            View_played_view.DataSource = dt;
            View_played_view.DataBind();
            Status.Text = "Showing a total of " + total.ToString() + " matches";
            Status.Visible = true;
            conn.Close();

        }


    }
}