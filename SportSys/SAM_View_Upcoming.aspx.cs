using System;

namespace SportSys
{
    public partial class SAM_Add_Match : System.Web.UI.Page
    {
        protected void Upcoming_Page_Load(object sender, EventArgs e)
        {
            Upcoming_Sys_User_name.Text += Session["Username"];
        }
    }
}