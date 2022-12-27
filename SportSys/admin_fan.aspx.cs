using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }
    }
}