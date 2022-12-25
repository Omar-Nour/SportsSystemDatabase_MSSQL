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