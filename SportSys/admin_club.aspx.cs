using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class admin_match : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            error_lbl.Visible = false;
            LoadTable();
        }

        protected void Addclub(object sender, EventArgs e)
        {
            if (club_n.Text == "" || club_l.Text == "")
            {
                error_lbl.Text = "enter both a name and location to add a club";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clubproc = new SqlCommand("checkClubExists", conn);
            clubproc.CommandType = System.Data.CommandType.StoredProcedure;
            clubproc.Parameters.AddWithValue("@clubname", club_n.Text);

            SqlParameter success_clubproc = clubproc.Parameters.Add("@success", SqlDbType.Int);

            success_clubproc.Direction = ParameterDirection.Output;

            conn.Open();
            clubproc.ExecuteNonQuery();

            if (success_clubproc.Value.ToString() == "1") // club exists
            {
                error_lbl.Text = "club with supplied name already exists";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("addClub", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@ClubName", club_n.Text);
            loginproc.Parameters.AddWithValue("@Location", club_l.Text);

            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }

        protected void deleteClub(object sender, EventArgs e)
        {
            if (d_club_n.Text == "")
            {
                error_lbl.Text = "enter a valid club name";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clubproc = new SqlCommand("checkClubExists", conn);
            clubproc.CommandType = System.Data.CommandType.StoredProcedure;
            clubproc.Parameters.AddWithValue("clubname", d_club_n.Text);

            SqlParameter success_clubproc = clubproc.Parameters.Add("@success", SqlDbType.Int);

            success_clubproc.Direction = ParameterDirection.Output;

            conn.Open();
            clubproc.ExecuteNonQuery();

            if (success_clubproc.Value.ToString() == "0") // club does not exist
            {
                error_lbl.Text = "club with supplied name doesn't exist";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("deleteClub", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@ClubName", d_club_n.Text);
            
            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }

        protected void LoadTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getClubs = new SqlCommand("SELECT * FROM Club", conn);
            conn.Open();

            SqlDataReader rd = getClubs.ExecuteReader();


            //create the DataTable that will be bound to GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Club id", typeof(string)));
            dt.Columns.Add(new DataColumn("Club Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Club Location", typeof(string)));
            dt.Columns.Add(new DataColumn("Club Rep. ID", typeof(string)));
            dt.Columns.Add(new DataColumn("Club Rep. Username", typeof(string)));


            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Club id"] = rd[0];
                    dr["Club Name"] = rd[1];
                    dr["Club Location"] = rd[2];
                    dr["Club Rep. ID"] = rd[3];
                    dr["Club Rep. Username"] = rd[4];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            ClubsGridView.DataSource = dt;
            ClubsGridView.DataBind();

            //Make the GridView visible
            ClubsGridView.Visible = true;
            conn.Close();


        }
    }
}