using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportSys
{
    public partial class Stadium_manager : System.Web.UI.Page
    {
        protected void Page_Load2(object sender, EventArgs e)
        {

        }

        protected void Viewpend(object sender, EventArgs e)
        {
            Response.Redirect("pending requests.aspx");
        }
    }
}