using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace SportSys
{
    public partial class SAM_Add_Match : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            User_name.Text += Session["Username"];
            string ConStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection con = new SqlConnection(ConStr);
            SqlCommand AddMatch = new SqlCommand("addNewMatch");

        }
    }
}