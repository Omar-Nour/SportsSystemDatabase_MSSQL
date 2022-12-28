using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class admin_stadium : System.Web.UI.Page
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

        protected void LoadTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getStadiums = new SqlCommand("SELECT * FROM Stadium", conn);
            conn.Open();

            SqlDataReader rd = getStadiums.ExecuteReader();


            //create the DataTable that will be bound to GridView
            DataTable dt = new DataTable();

            //id int IDENTITY PRIMARY KEY,
            //name VARCHAR(20),
            //capacity int,
            //location VARCHAR(20),
            //status bit,
            //StadiumManagerID int,
            //StadiumManagerUserName VARCHAR(20),

            //Add columns 
            dt.Columns.Add(new DataColumn("Stadium ID", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Capacity", typeof(string)));
            dt.Columns.Add(new DataColumn("Location", typeof(string)));
            dt.Columns.Add(new DataColumn("Status", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Manager ID", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium Manager User Name", typeof(string)));


            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Stadium ID"] = rd[0];
                    dr["Stadium Name"] = rd[1];
                    dr["Capacity"] = rd[2];
                    dr["Location"] = rd[3];
                    dr["Status"] = (rd[4].ToString().Equals("True")) ? "available" : "unavailable";
                    dr["Stadium Manager ID"] = rd[5];
                    dr["Stadium Manager User Name"] = rd[6];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            StadiumsGridView.DataSource = dt;
            StadiumsGridView.DataBind();

            //Make the GridView visible
            StadiumsGridView.Visible = true;
            conn.Close();
        }

        protected void AddStadium(object sender, EventArgs e)
        {
            if (stadium_n.Text == "" || stadium_l.Text == "" || stadium_c.Text == "")
            {
                error_lbl.Text = "enter a name, location and capacity to add a stadium";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand stadiumproc = new SqlCommand("checkStadExists", conn);
            stadiumproc.CommandType = System.Data.CommandType.StoredProcedure;
            stadiumproc.Parameters.AddWithValue("@stadname", stadium_n.Text);

            SqlParameter success_stadiumproc = stadiumproc.Parameters.Add("@success", SqlDbType.Int);

            success_stadiumproc.Direction = ParameterDirection.Output;

            conn.Open();
            stadiumproc.ExecuteNonQuery();

            if (success_stadiumproc.Value.ToString() == "1") // stadium exists
            {
                error_lbl.Text = "stadium with supplied name already exists";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("addStadium", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@Name", stadium_n.Text);
            loginproc.Parameters.AddWithValue("@Location", stadium_l.Text);
            loginproc.Parameters.AddWithValue("@Cap", Int64.Parse(stadium_c.Text));

            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }

        protected void deleteStadium(object sender, EventArgs e)
        {
            if (d_stadium_n.Text == "")
            {
                error_lbl.Text = "enter a valid stadium name";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand stadiumproc = new SqlCommand("checkStadExists", conn);
            stadiumproc.CommandType = System.Data.CommandType.StoredProcedure;
            stadiumproc.Parameters.AddWithValue("@stadname", d_stadium_n.Text);

            SqlParameter success_stadiumproc = stadiumproc.Parameters.Add("@success", SqlDbType.Int);

            success_stadiumproc.Direction = ParameterDirection.Output;

            conn.Open();
            stadiumproc.ExecuteNonQuery();

            if (success_stadiumproc.Value.ToString() == "0") // stadium does not exist
            {
                error_lbl.Text = "stadium with supplied name doesn't exist";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("deleteStadium", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@Name", d_stadium_n.Text);

            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }
    }
}