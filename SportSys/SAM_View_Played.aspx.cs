﻿using System;

namespace SportSys
{
    public partial class SAM_View_Played : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Played_Sys_User_name.Text += Session["Username"];
        }
    }
}