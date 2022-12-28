﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class ClubRep_send_request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null || Session["type"] != "clubrep")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Sys_User_name.Text ="Seding requests as " + Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

        }

        protected void send_request(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string Club_name_var = Club_name.Text;
            string Stadium = Stadium_name.Text;
            string date = date_time.Text;

            SqlCommand Club_name_command = new SqlCommand("Fetch_Club_Rep_Club_Info", conn);
            Club_name_command.CommandType = System.Data.CommandType.StoredProcedure;
            Club_name_command.Parameters.AddWithValue("@Club_Rep_User", Session["username"].ToString());


            SqlParameter Club_name_value = Club_name_command.Parameters.Add("@Club_name", SqlDbType.VarChar, 20);
            SqlParameter Club_location_value = Club_name_command.Parameters.Add("@Club_location", SqlDbType.VarChar, 20);
            SqlParameter Club_id_value = Club_name_command.Parameters.Add("@Club_id", SqlDbType.Int);

            Club_name_value.Direction = ParameterDirection.Output;
            Club_location_value.Direction = ParameterDirection.Output;
            Club_id_value.Direction = ParameterDirection.Output;

            SqlCommand SendRequest = new SqlCommand("addHostRequest", conn);
            SendRequest.CommandType = System.Data.CommandType.StoredProcedure;


            conn.Open();
            Club_name_command.ExecuteNonQuery();

            if (Club_name_var != Club_name_value.ToString())
            {
                status.Text = "Club name was not matching representative's club";
                status.Visible = true;
                conn.Close();
            }

            else { 
            SendRequest.Parameters.AddWithValue("@clubname", Club_name_var);
            SendRequest.Parameters.AddWithValue("@stadname", Stadium);
            SendRequest.Parameters.AddWithValue("@date", date);

            SendRequest.ExecuteNonQuery();

            status.Text = "Request sent successfully";
            status.Visible = true;

            conn.Close();

            }


        }
    }
}