using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string usern = username.Text;
            string passwd = password.Text;

            if (usern.Length > 20 || usern == "")
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


            // get user type to redirect accordingly
            SqlCommand loginproc = new SqlCommand("login ", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.AddWithValue("@username", usern);
            loginproc.Parameters.AddWithValue("@password", passwd);

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@user_type", SqlDbType.VarChar, 20);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();

            if (success.Value.ToString() == "0") // username NOT found
            {
                error_lbl.Text = "username not found or incorrect password";
                error_lbl.Visible = true;
                conn.Close();
                return;
            }
            else // username found
            {
                Session["username"] = usern;
                switch (type.Value.ToString())
                {
                    case "fan":
                        Response.Redirect("Fan.aspx");
                        break;
                    case "stadman":
                        Response.Redirect("SAM view.aspx");
                        break;
                    case "clubrep":
                        Response.Redirect("ClubRep.aspx"); // to be modified
                        break;
                    case "sam":
                        Response.Redirect("Fan.aspx");
                        break;
                    case "admin":
                        Response.Redirect("admin.aspx");
                        break;
                }
            }

        }

        protected void redirect_registraion(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }

    }
}