using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace SportSys
{
    public partial class SAM_view_unmatched : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Unmatched_User_name.Text = Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand View_Unmatched = new SqlCommand("SELECT C1.name as club1, C2.name as club2\r\n\tFROM Club C1, Club C2\r\n\tWHERE C1.id < C2.id \r\n\tAND NOT EXISTS (SELECT * FROM Match M \r\n\t\t\t\t\tWHERE  (M.HostClubID = C1.id AND M.GuestClubID = C2.id)\r\n\t\t\t\t\tOR (M.HostClubID = C2.id AND M.GuestClubID = C1.id) AND\r\n\t\t\t\t\tM.EndTime < CURRENT_TIMESTAMP\r\n\t);", conn);

            conn.Open();

            SqlDataReader rd = View_Unmatched.ExecuteReader();
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("Club 1", typeof(string)));
            dt.Columns.Add(new DataColumn("Club 2", typeof(string)));

            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr["Club 1"] = rd[0];
                    dr["Club 2"] = rd[1];
                    dt.Rows.Add(dr);
                }


            }
            else
            {
                Status.Text = "No unmatched clubs";
                Status.Visible = true;
            }

            View_played_view.DataSource = dt;
            View_played_view.DataBind();
            conn.Close();
        }
    }
}