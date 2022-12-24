using System;

namespace SportSys
{
    public partial class SAM_Add_Match : System.Web.UI.Page
    {
        protected void Remove_Page_Load(object sender, EventArgs e)
        {
            User_name.Text += Session["Username"];
        }
    }
}