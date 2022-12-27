using System;

namespace SportSys
{
    public partial class SAM_View_Upcoming : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            Upcoming_Sys_User_name.Text += Session["username"];
        }
    }
}