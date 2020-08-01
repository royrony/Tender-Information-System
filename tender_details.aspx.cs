using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

namespace Tender
{
    public partial class tender_details : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["tenderno"] != null)
            {
                string dpt_id = null;
                string tender_no = Request.QueryString["tenderno"];
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand cmd = new MySqlCommand("select * from tender where tender_id = @arg");
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@arg", tender_no);
                MySqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    dpt_id = dr["dpt_id"].ToString();
                    id.Text = dr["tender_id"].ToString();
                    TextBox1.Text = dr["work_name"].ToString();
                    
                }
                con.Close();
                con.Open();
                MySqlCommand cmd1 = new MySqlCommand("select dpt_name from department where dpt_id = @arg");
                cmd1.Connection = con;
                cmd1.Parameters.AddWithValue("@arg", dpt_id);
                MySqlDataReader dr1;
                dr1 = cmd1.ExecuteReader();
                while (dr1.Read())
                {
                    TextBox2.Text = dr1["dpt_name"].ToString();
                }
                con.Close();
                
            }
        }
    }
}