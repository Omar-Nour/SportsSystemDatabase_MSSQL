using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Net;
using System.Xml.Linq;

namespace SportSys
{
    public partial class admin_fan : System.Web.UI.Page
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

            SqlCommand getFans = new SqlCommand("SELECT * FROM Fan", conn);
            conn.Open();

            SqlDataReader rd = getFans.ExecuteReader();


            //create the DataTable that will be bound to GridView
            DataTable dt = new DataTable();

            //username VARCHAR(20) UNIQUE,
		    //NationalID VARCHAR(20),
		    //PhoneNo VARCHAR(20),
		    //Address VARCHAR(20),
		    //name VARCHAR(20),
		    //status bit,
            //BirthDate date,

            //Add columns 
            dt.Columns.Add(new DataColumn("Username", typeof(string)));
            dt.Columns.Add(new DataColumn("NationalID", typeof(string)));
            dt.Columns.Add(new DataColumn("PhoneNo", typeof(string)));
            dt.Columns.Add(new DataColumn("Address", typeof(string)));
            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Status", typeof(string)));
            dt.Columns.Add(new DataColumn("BirthDate", typeof(string)));


            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    //create a row/tuple then fill it with data from reader
                    DataRow dr = dt.NewRow();
                    dr["Username"] = rd[0];
                    dr["NationalID"] = rd[1];
                    dr["PhoneNo"] = rd[2];
                    dr["Address"] = rd[3];
                    dr["Name"] = rd[4];
                    dr["Status"] = (rd[5].ToString() == "False") ? "blocked" : "unblocked";
                    dr["BirthDate"] = rd[6];
                    dt.Rows.Add(dr);
                }
            }

            //Bind GridView to table
            FansGridView.DataSource = dt;
            FansGridView.DataBind();

            //Make the GridView visible
            FansGridView.Visible = true;
            conn.Close();


        }

        protected void blockFan(object sender, EventArgs e)
        {
            if (block_f_n.Text == "")
            {
                error_lbl.Text = "national id number invalid, must be 14 digits";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clubproc = new SqlCommand("checkNidExists", conn);
            clubproc.CommandType = System.Data.CommandType.StoredProcedure;
            clubproc.Parameters.AddWithValue("@nid", block_f_n.Text);

            SqlParameter success_clubproc = clubproc.Parameters.Add("@success", SqlDbType.Int);

            success_clubproc.Direction = ParameterDirection.Output;

            conn.Open();
            clubproc.ExecuteNonQuery();

            if (success_clubproc.Value.ToString() == "0") // nid does not exist
            {
                error_lbl.Text = "fan with supplied national id doesn't exist";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("blockFan", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@NatId", block_f_n.Text);

            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }

        protected void unblockFan(object sender, EventArgs e)
        {
            if (unblock_f_n.Text == "")
            {
                error_lbl.Text = "national id number invalid, must be 14 digits";
                error_lbl.Visible = true;
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clubproc = new SqlCommand("checkNidExists", conn);
            clubproc.CommandType = System.Data.CommandType.StoredProcedure;
            clubproc.Parameters.AddWithValue("@nid", unblock_f_n.Text);

            SqlParameter success_clubproc = clubproc.Parameters.Add("@success", SqlDbType.Int);

            success_clubproc.Direction = ParameterDirection.Output;

            conn.Open();
            clubproc.ExecuteNonQuery();

            if (success_clubproc.Value.ToString() == "0") // nid does not exist
            {
                error_lbl.Text = "fan with supplied national id doesn't exist";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }

            SqlCommand loginproc = new SqlCommand("unblockFan", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@NatId", block_f_n.Text);

            loginproc.ExecuteNonQuery();
            conn.Close();
            LoadTable();
        }
    }
}