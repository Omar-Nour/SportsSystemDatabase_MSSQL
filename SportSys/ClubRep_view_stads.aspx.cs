﻿using System;
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



        }

        protected void userInFunc(object sender, EventArgs e)
        {

            Int64 total = 0;

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand View_stads = new SqlCommand("SELECT S.name , S.location , S.capacity\r\n\tFROM Stadium S , Match M\r\n\tWHERE S.status= 1 AND S.id  != M.StadiumID AND M.StartTime >" + DateTimeBox.Text.ToString(), conn);
            // View_stads.CommandType = CommandType.StoredProcedure;
            //View_stads.Parameters.AddWithValue("@starttime", DateTimeBox.Text);


            conn.Open();
            if (DateTimeBox.Text != "")
            {
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

            else
            {
                status.Text = "No date input";
                status.Visible = true;
            }
        }

        protected void currTimeFunc(object sender, EventArgs e)
        {

            Int64 total = 0;

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand View_stads = new SqlCommand("SELECT S.name , S.location , S.capacity\r\n\tFROM Stadium S , Match M\r\n\tWHERE S.status= 1 AND S.id  != M.StadiumID OR  S.id=M.StadiumID AND M.StartTime >" + DateTime.Now.ToString(), conn);
            //View_stads.CommandType = CommandType.StoredProcedure;
            //View_stads.Parameters.AddWithValue("@starttime", DateTime.Now);


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