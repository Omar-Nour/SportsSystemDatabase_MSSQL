using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
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

            if (RadioList.SelectedItem == null) // no usertype selected
            {
                error_lbl.Text = "user type should be selected";
                error_lbl.Visible = true;
                return;
            }
            else if (usern.Length > 20 || usern == "")
            {
                error_lbl.Text = "username should be less than 21 characters and not empty";
                error_lbl.Visible = true;
                return;
            }
            else if (passwd == "" || passwd.Length > 20)
            {
                error_lbl.Text = "password should be less than 21 characters and not empty";
                error_lbl.Visible = true;
                return;
            }
            else if (name_i == "" || passwd.Length > 20)
            {
                error_lbl.Text = "name should be less than 21 characters and not empty";
                error_lbl.Visible = true;
                return;
            }

            // check if username taken using loginproc
            SqlCommand loginproc = new SqlCommand("checkUsername", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@username", usern);

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();

            if (success.Value.ToString() == "1") // username found
            {
                error_lbl.Text = "username already taken";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }


            // continue validation for the rest of the types
            // 0  stadman, 1 fan, 2 sam, 3 club rep
            switch (RadioList.SelectedIndex)
            {
                case 0: // stad man
                    // need stad existance proc
                    SqlCommand stadproc = new SqlCommand("checkStadExists", conn);
                    stadproc.CommandType = System.Data.CommandType.StoredProcedure;
                    stadproc.Parameters.AddWithValue("@stadname", stadium.Text);

                    SqlParameter success_stad = stadproc.Parameters.Add("@success", SqlDbType.Int);

                    success_stad.Direction = ParameterDirection.Output;

                    stadproc.ExecuteNonQuery();

                    if (success_stad.Value.ToString() == "1") // stadium exists
                    {
                        // exec insert
                        SqlCommand add_stad_man_proc = new SqlCommand("addStadiumManager", conn);
                        add_stad_man_proc.CommandType = System.Data.CommandType.StoredProcedure;
                        add_stad_man_proc.Parameters.AddWithValue("@name", name_i);
                        add_stad_man_proc.Parameters.AddWithValue("@stadiumname", stadium.Text);
                        add_stad_man_proc.Parameters.AddWithValue("@Username", usern);
                        add_stad_man_proc.Parameters.AddWithValue("@Password", passwd);

                        add_stad_man_proc.ExecuteNonQuery();
                        conn.Close();

                        // session redirect
                        Session["username"] = usern;
                        Response.Redirect("stad_man.aspx"); // TODO: to be modified correspondingly
                    }
                    else
                    {
                        error_lbl.Text = "stadium does not exist or typed incorrectly";
                        error_lbl.Visible = true;
                        conn.Close();
                    }
                    break;
                case 1: // fan
                    if (nid.Text.Length != 14)
                    {
                        error_lbl.Text = "national id should be 14 digits";
                        error_lbl.Visible = true;
                    }
                    else if (phone.Text.Length != 11)
                    {
                        error_lbl.Text = "phone number should be 11 digits";
                        error_lbl.Visible = true;
                    }
                    else if (address.Text == "")
                    {
                        error_lbl.Text = "address should not be empty";
                        error_lbl.Visible = true;
                    }
                    else if (birth_d.Text == "" || Int16.Parse(birth_d.Text.Split('-')[0]) > DateTime.Now.Year ||
                        (Int16.Parse(birth_d.Text.Split('-')[0]) == DateTime.Now.Year && Int16.Parse(birth_d.Text.Split('-')[1]) > DateTime.Now.Month))
                    {
                        error_lbl.Text = "date of birth should be a valid non empty date";
                        error_lbl.Visible = true;
                    }
                    else
                    {
                        //check for duplicate national id
                        SqlCommand nidproc = new SqlCommand("checkNidExists", conn);
                        nidproc.CommandType = System.Data.CommandType.StoredProcedure;
                        nidproc.Parameters.AddWithValue("@nid", nid.Text);

                        SqlParameter success_nidproc = nidproc.Parameters.Add("@success", SqlDbType.Int);

                        success_nidproc.Direction = ParameterDirection.Output;

                        nidproc.ExecuteNonQuery();

                        if (success_nidproc.Value.ToString() == "1") // duplicate nid
                        {
                            error_lbl.Text = "duplicate national id";
                            error_lbl.Visible = true;
                            conn.Close();
                        }
                        else
                        { 
                            // exec insert
                            //CREATE PROCEDURE addFan
                            //@name varchar(20),
                            //@username varchar(20),
                            //@password varchar(20),
                            //@nid varchar(20),
                            //@bd datetime,
                            //@address varchar(20),
                            //@phone_num int

                            SqlCommand add_fan_proc = new SqlCommand("addFan", conn);
                            add_fan_proc.CommandType = System.Data.CommandType.StoredProcedure;
                            add_fan_proc.Parameters.AddWithValue("@name", name_i);
                            add_fan_proc.Parameters.AddWithValue("@username", usern);
                            add_fan_proc.Parameters.AddWithValue("@password", passwd);
                            add_fan_proc.Parameters.AddWithValue("@nid", nid.Text);
                            add_fan_proc.Parameters.AddWithValue("@bd", birth_d.Text);
                            add_fan_proc.Parameters.AddWithValue("@address", address.Text);
                            add_fan_proc.Parameters.AddWithValue("@phone_num", Int64.Parse(phone.Text));

                            add_fan_proc.ExecuteNonQuery();
                            conn.Close();

                            // session redirect
                            Session["username"] = usern;
                            Response.Redirect("Fan.aspx"); // TODO: to be modified correspondingly
                        }
                    }
        
                    break;
                case 2: // sam
                    // no extra validation
                    // exec insert
                    // session redirect
                    break;
                case 3: // club rep
                    // needs club existance proc
                    // exec insert
                    // session redirect
                    break;
            }

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