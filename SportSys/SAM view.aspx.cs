using System;

namespace SportSys
{
    public partial class SAM_view : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
#pragma warning disable CS0252 // Possible unintended reference comparison; left hand side needs cast
            if (Session["username"] == null || Session["type"] != "sam")
            {
                Response.Redirect("Login.aspx");
                return;
            }
#pragma warning restore CS0252 // Possible unintended reference comparison; left hand side needs cast
            Sys_User_name.Text = Session["Username"].ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}