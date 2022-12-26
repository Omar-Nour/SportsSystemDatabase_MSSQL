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
    public partial class Stadium_manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "stadman")
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

       

        

        protected void Viewstad(object sender, EventArgs e)
        {
            
            Response.Redirect("Stadium info.aspx");
        }

        protected void Viewhost(object sender, EventArgs e)
        {
            Response.Redirect("Hostrequests.aspx");
        }
    }
}