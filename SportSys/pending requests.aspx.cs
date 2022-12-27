using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace SportSys
{
	public partial class pending_requests : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

            //hardcoded username =Ahmed

            string username = Session["username"].ToString();

            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that fetches the table 
            SqlCommand getpendingreq = new SqlCommand("ALLREQPEND", conn);
            getpendingreq.CommandType = System.Data.CommandType.StoredProcedure;
            getpendingreq.Parameters.AddWithValue("@STADUSERNAME", username);

            //Get table from db
            conn.Open();
            SqlDataReader rd = getpendingreq.ExecuteReader();


            //create the GridView
            DataTable dt = new DataTable();

            //Add columns 
            dt.Columns.Add(new DataColumn("Club representative", typeof(string)));
            dt.Columns.Add(new DataColumn("Stadium manager", typeof(string)));
            dt.Columns.Add(new DataColumn("Host club", typeof(string)));
            dt.Columns.Add(new DataColumn("kickoff time", typeof(string)));
            dt.Columns.Add(new DataColumn("End time", typeof(string)));
            dt.Columns.Add(new DataColumn("Host id", typeof(string)));


            //Add rows with data
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr["Club representative"] = rd[0];
                    dr["Stadium manager"] = rd[1];
                    dr["Host club"] = rd[2];  
                    dr["kickoff time"] = rd[3];
                    dr["End time"] = rd[4];
                    dr["Host id"] = rd[5];




                    dt.Rows.Add(dr);
                }
            }

            Pendingreq2.DataSource = dt;
            Pendingreq2.DataBind();
        }
        protected void Pendingreq2_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "reject") return;

            
            
            string Hostid = e.CommandArgument.ToString();





            //get connection string
            string connStr = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            //initialize the command that purchases the ticket 
            SqlCommand Reject2 = new SqlCommand("SIMPREJECT", conn);
            Reject2.CommandType = System.Data.CommandType.StoredProcedure;
            Reject2.Parameters.AddWithValue("@ID", Hostid);


            //open a connection and execute the procedure
            conn.Open();
            Reject2.ExecuteNonQuery();

         
            Response.Redirect("Hostrequests.aspx");

            conn.Close();
            

        }



    }
}