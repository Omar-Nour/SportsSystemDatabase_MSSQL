using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register_b(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string usern = username.Text;
            string passwd = password.Text;
            string name_i = name.Text;

            if (usern.Length > 20 || usern == "")
            {
                error_lbl.Text = "username should be less than 21 characters and not empty";
                error_lbl.Visible = true;
            }
            else if (passwd == "" || passwd.Length > 20)
            {
                error_lbl.Text = "password should be less than 21 characters and not empty";
                error_lbl.Visible = true;
            }
            else if (name_i == "" || passwd.Length > 20)
            {
                error_lbl.Text = "name should be less than 21 characters and not empty";
                error_lbl.Visible = true;
            }

            // continue validation for the rest of the types
        }

        protected void RadioList_SelectedIndexChanged(object sender, EventArgs e)
        {
            // handle input view
            switch (RadioList.SelectedIndex)
            {
                case 0: // stad man
                    stadium.Visible = true;
                    std_l.Visible = true;
                    club.Visible = false;
                    club_l.Visible = false;
                    nid.Visible = false;
                    nid_l.Visible = false;
                    birth_d.Visible = false;
                    birth_l.Visible = false;
                    phone.Visible = false;
                    phone_l.Visible = false;
                    address.Visible = false;
                    addrs_l.Visible = false;
                    error_lbl.Visible = false;
                    break;
                case 1: // fan
                    stadium.Visible = false;
                    std_l.Visible = false;
                    club.Visible = false;
                    club_l.Visible = false;
                    nid.Visible = true;
                    nid_l.Visible = true;
                    birth_d.Visible = true;
                    birth_l.Visible = true;
                    phone.Visible = true;
                    phone_l.Visible = true;
                    address.Visible = true;
                    addrs_l.Visible = true;
                    error_lbl.Visible = false;
                    break;
                case 2: // sam
                    stadium.Visible = false;
                    std_l.Visible = false;
                    club.Visible = false;
                    club_l.Visible = false;
                    nid.Visible = false;
                    nid_l.Visible = false;
                    birth_d.Visible = false;
                    birth_l.Visible = false;
                    phone.Visible = false;
                    phone_l.Visible = false;
                    address.Visible = false;
                    addrs_l.Visible = false;
                    error_lbl.Visible = false;
                    break;
                case 3: // club rep
                    stadium.Visible = false;
                    std_l.Visible = false;
                    club.Visible = true;
                    club_l.Visible = true;
                    nid.Visible = false;
                    nid_l.Visible = false;
                    birth_d.Visible = false;
                    birth_l.Visible = false;
                    phone.Visible = false;
                    phone_l.Visible = false;
                    address.Visible = false;
                    addrs_l.Visible = false;
                    error_lbl.Visible = false;
                    break;
            }

            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
        }
    }
}