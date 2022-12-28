using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#pragma warning disable CS0252 // Possible unintended reference comparison; left hand side needs cast
            if (Session["username"] == null || Session["type"] != "admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            admin_l.Text = Session["username"].ToString();
        }

    }
}