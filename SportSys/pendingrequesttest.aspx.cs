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
    public partial class pendingrequesttest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null || Session["type"] != "stadman")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {

                loadTable();

            }
            
        }

        protected void loadTable()
        {
            //hardcoded username =Ahmed
            //string username = "Ahmed";
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

            MatchesGridView.DataSource = dt;
            MatchesGridView.DataBind();


            conn.Close();

        }


        protected void MatchesGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if (e.CommandName == "Accept")
            {
                string stadiumusername1 = e.CommandArgument.ToString().Split(';')[0];
                string hostid1 = e.CommandArgument.ToString().Split(';')[1];




                //get connection string
                string connStrb = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
                SqlConnection connb = new SqlConnection(connStrb);

                



                SqlCommand Accept = new SqlCommand("SIMPACCEPT", connb);
                Accept.CommandType = System.Data.CommandType.StoredProcedure;
                Accept.Parameters.AddWithValue("@STADUDERNAME", stadiumusername1);
                Accept.Parameters.AddWithValue("@ID", hostid1);


                //open a connection and execute the procedure
                connb.Open();
               
                Accept.ExecuteNonQuery();


                //make label visible and tell the user that the ticket has been purchased
                //then close the connection

                connb.Close();

                //update purchase history
            }
            else if (e.CommandName == "Reject")
            {
               
                string hostid1 = e.CommandArgument.ToString();




                //get connection string
                string connStrb = WebConfigurationManager.ConnectionStrings["SportSys"].ToString();
                SqlConnection connb = new SqlConnection(connStrb);

                //initialize the command that purchases the ticket 
                SqlCommand Reject = new SqlCommand("SIMPREJECT", connb);
                Reject.CommandType = System.Data.CommandType.StoredProcedure;
                Reject.Parameters.AddWithValue("@ID", hostid1);



              


                //open a connection and execute the procedure
                connb.Open();
                Reject.ExecuteNonQuery();
                


                //make label visible and tell the user that the ticket has been purchased
                //then close the connection

                connb.Close();


                //update purchase history
            }
            loadTable();

            //keep GridView Visible


            //partition the data

           
            //update purchase history
            
        }

    }
}