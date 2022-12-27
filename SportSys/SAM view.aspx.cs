using System;

namespace SportSys
{
    public partial class SAM_view : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            Sys_User_name.Text += Session["Username"];
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}