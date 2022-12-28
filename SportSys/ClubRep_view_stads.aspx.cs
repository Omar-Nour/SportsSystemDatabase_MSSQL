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
    public partial class ClubRep_view_stads : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null || Session["type"] != "clubrep")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Sys_User_name.Text = "Viewing available stadiums as " +Session["username"].ToString();

            Int64 total = 0;

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand View_stads = new SqlCommand("select name, capacity, location from Stadium where stadium.status = '1'", conn);

            conn.Open();
            SqlDataReader rd = View_stads.ExecuteReader();
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Capacity", typeof(string)));
            dt.Columns.Add(new DataColumn("Location", typeof(string)));


            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Name"] = rd[0];
                    dr["Capacity"] = rd[1];
                    dr["Location"] = rd[2];
                    dt.Rows.Add(dr);
                    total += 1;

                }
            }

            else
            {
                status.Text = "No available stadiums";
                status.Visible = true;
            }

            View_stads_view.DataSource = dt;
            View_stads_view.DataBind();
            status.Text = "Showing a total of " + total.ToString() + " stadiums";
            status.Visible = true;
            conn.Close();

        }
    }
}