using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Xml.Linq;

namespace SportSys
{
    public partial class SAM_Remove_Match : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#pragma warning disable CS0252
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252

            User_name.Text = Session["username"].ToString();
            string ConStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(ConStr);
        }

        protected void remove_match(object sender, EventArgs e)
        {
            string ConStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(ConStr);

            string Hostname = Host_Club.Text;
            string Guestname = Guest_Club.Text;
            string Starttime = Start_Time.Text;
            string Endtime = End_Time.Text;

            SqlCommand RemoveMatch = new SqlCommand("deleteMatch", conn);
            RemoveMatch.CommandType = System.Data.CommandType.StoredProcedure;
            
            SqlCommand CheckClubHost = new SqlCommand("checkClubExists", conn);
            CheckClubHost.CommandType = System.Data.CommandType.StoredProcedure;
            CheckClubHost.Parameters.AddWithValue("@clubname", Hostname);

            SqlCommand CheckClubGuest = new SqlCommand("checkClubExists", conn);
            CheckClubGuest.CommandType = System.Data.CommandType.StoredProcedure;
            CheckClubGuest.Parameters.AddWithValue("@clubname", Guestname);

            SqlParameter successHost = CheckClubHost.Parameters.Add("@success", SqlDbType.Int);
            successHost.Direction = ParameterDirection.Output;

            SqlParameter successGuest = CheckClubGuest.Parameters.Add("@success", SqlDbType.Int);
            successGuest.Direction = ParameterDirection.Output;

            conn.Open();

            CheckClubHost.ExecuteNonQuery();
            CheckClubGuest.ExecuteNonQuery();

            if (successHost.Value.ToString() == "1" && successGuest.Value.ToString() == "1") //clubs found
            {

                RemoveMatch.Parameters.AddWithValue("@HostClub", Hostname);
                RemoveMatch.Parameters.AddWithValue("@GuestClub", Guestname);

                RemoveMatch.ExecuteNonQuery();

                indicator.Text = "Match removed successfully";
                indicator.Visible = true;

                conn.Close();
            }

            else
            {
                indicator.Text = "NO CLUBS FOUND MATCHING THE INPUT NAMES";
                indicator.Visible = true;
            }

        }
    }
}