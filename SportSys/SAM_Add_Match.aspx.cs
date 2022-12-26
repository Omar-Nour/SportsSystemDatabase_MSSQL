using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Xml.Linq;

namespace SportSys
{
    public partial class SAM_Add_Match : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            User_name.Text += Session["username"];
            string ConStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection con = new SqlConnection(ConStr);

        }

        protected void add_match(object sender, EventArgs e)
        {
            string ConStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection con = new SqlConnection(ConStr);

            string Hostname = Host_Club.Text;
            string Guestname = Guest_Club.Text;
            string Starttime = Start_Time.Text;
            string Endtime = End_Time.Text;

            SqlCommand AddMatch = new SqlCommand("addNewMatch", con);

            con.Open();

            AddMatch.CommandType = System.Data.CommandType.StoredProcedure;
            AddMatch.Parameters.AddWithValue("@HostName", Hostname);
            AddMatch.Parameters.AddWithValue("@GuestName", Guestname);
            AddMatch.Parameters.AddWithValue("@StartTime", Starttime);
            AddMatch.Parameters.AddWithValue("@EndTime", Endtime);

            AddMatch.ExecuteNonQuery();

            error_lbl.Text = "Match added successfully";
            error_lbl.Visible = true;

            con.Close();

        }
    }

}