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
            } else if (passwd == "" || passwd.Length > 20)
            {
                error_lbl.Text = "password should be less than 21 characters and not empty";
                error_lbl.Visible = true;
            }

            
        }

        protected void redirect_registraion(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }
    }
}