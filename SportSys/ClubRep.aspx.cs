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
    public partial class REP_view : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "clubrep")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Sys_User_name.Text = Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand Club_name = new SqlCommand("Fetch_Club_Rep_Club_Info", conn);
            Club_name.CommandType = System.Data.CommandType.StoredProcedure;
            Club_name.Parameters.AddWithValue("@Club_Rep_User", Session["username"].ToString());

            SqlParameter Club_name_value = Club_name.Parameters.Add("@Club_name", SqlDbType.VarChar,20);
            SqlParameter Club_location_value = Club_name.Parameters.Add("@Club_location", SqlDbType.VarChar,20);
            SqlParameter Club_id_value = Club_name.Parameters.Add("@Club_id", SqlDbType.Int);

            Club_name_value.Direction = ParameterDirection.Output;
            Club_location_value.Direction = ParameterDirection.Output;
            Club_id_value.Direction = ParameterDirection.Output;

            conn.Open();
            Club_name.ExecuteNonQuery();

            Rep_club.Text = "CLUB NAME: " + Club_name_value.Value.ToString();
            club_loc.Text = "CLUB LOCATION: " + Club_location_value.Value.ToString();
            club_id.Text = "CLUB ID: " + Club_id_value.Value.ToString();

            SqlCommand Upcoming_matches = new SqlCommand("select M.StartTime, M.EndTime, S.name, C1.name AS Host_name, C2.name AS Guest_name\r\n\r\nfrom Match M INNER JOIN Stadium S ON M.StadiumID = S.id\r\nINNER JOIN Club C1 ON M.HostClubID = C1.id\r\nINNER JOIN Club C2 ON M.GuestClubID = C2.id\r\n\r\nWhere C1.name = '" + Club_name_value.Value.ToString() + "' OR C2.name = '" + Club_name_value.Value.ToString() + "'", conn);
            SqlDataReader rd = Upcoming_matches.ExecuteReader();
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("Host Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Guest Club", typeof(string)));
            dt.Columns.Add(new DataColumn("Start time", typeof(string)));
            dt.Columns.Add(new DataColumn("End time", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Name", typeof(string)));

            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Host Club"] = rd[4];
                    dr["Guest Club"] = rd[3];
                    dr["Stadium Name"] = rd[2];
                    dr["Start Time"] = rd[0];
                    dr["End time"] = rd[1];
                    dt.Rows.Add(dr);
                    
                }
            }

            Upcoming_matches_view.DataSource = dt;
            Upcoming_matches_view.DataBind();


        }
    }
}