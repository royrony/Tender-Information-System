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
    public partial class login : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void button1_Click(object sender, EventArgs e)
        {
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand cmd = new MySqlCommand("select * from dpt_users where username=@username and pswd=Aes_Encrypt(@password,@username)");
            cmd.Parameters.AddWithValue("@username", textbox1.Text);
            cmd.Parameters.AddWithValue("@password", textbox2.Text);
            cmd.Connection = con;
            MySqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                Session["username"] = sdr["username"].ToString();
                Session["dpt_id"] = sdr["dpt_id"].ToString();
                Response.Redirect("Default.aspx");
            }
            else
            {
                label1.Text = "Username or Password Incorrect...!";
            }
        }
    }
} 