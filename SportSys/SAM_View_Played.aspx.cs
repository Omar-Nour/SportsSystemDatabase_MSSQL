using System;

namespace SportSys
{
    public partial class SAM_View_Played : System.Web.UI.Page
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
            Played_Sys_User_name.Text = Session["username"].ToString();
        }


    }
}