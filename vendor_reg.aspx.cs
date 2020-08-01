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
    public partial class vendor_reg : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        string v_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand cmd = new MySqlCommand("select * from goods");
                cmd.Connection = con;
                MySqlDataReader sdr = cmd.ExecuteReader();
                goods.DataSource = sdr;
                goods.DataTextField = "title";
                goods.DataValueField = "goods_id";
                goods.DataBind();
                for (int i = 0; i < goods.Items.Count; i++)
                {
                    goods.Items[i].Selected = true;
                    goods.Items[i].Attributes.Add("onclick", "checkedchanged(this)");
                }
                con.Close();
                con.Open();
                MySqlCommand cmd1 = new MySqlCommand("select * from services");
                cmd1.Connection = con;
                MySqlDataReader sdr1 = cmd1.ExecuteReader();
                services.DataSource = sdr1;
                services.DataTextField = "title";
                services.DataValueField = "service_id";
                services.DataBind();
                for (int i = 0; i < services.Items.Count; i++)
                {
                    services.Items[i].Selected = true;
                    services.Items[i].Attributes.Add("onclick", "checkedchanged(this)");
                }
            }
           
        }
        
        protected void vendor_email_TextChanged(object sender, EventArgs e)
        {
            Page.Validate("vg2");
        }

        protected void cv3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand cmd = new MySqlCommand("select vendor_id from vendor where vendor_email=@email;");
            cmd.Parameters.AddWithValue("@email", vendor_email.Text);
            cmd.Connection = con;
            MySqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.HasRows)
            {
                cv3.ErrorMessage = "Email already exists in our database.Please check or try to login";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
            con.Close();
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand cmd = new MySqlCommand("Insert into vendor (vendor_email,vendor_pass,vendor_name,vendor_addr,vendor_phone,vendor_ecp) values(@email, Aes_Encrypt(@pass,@email), @name, @addr, @phone, @ecp)", con);
                String addr = street.Text + ", " + city.Text + ", " + state.Text + ", " + pincode.Text;
                cmd.Parameters.AddWithValue("@email", vendor_email.Text);
                cmd.Parameters.AddWithValue("@pass", vendor_pass.Text);
                cmd.Parameters.AddWithValue("@name", name.Text);
                cmd.Parameters.AddWithValue("@addr", addr);
                cmd.Parameters.AddWithValue("@phone", vendor_mobile.Text);
                cmd.Parameters.AddWithValue("@ecp", ecp.SelectedValue);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                MySqlCommand cmd1 = new MySqlCommand("select vendor_id from vendor where vendor_email=@email;");
                cmd1.Parameters.AddWithValue("@email", vendor_email.Text);
                cmd1.Connection = con;
                MySqlDataReader sdr1 = cmd1.ExecuteReader();
                if (sdr1.Read())
                {
                    v_id = sdr1[0].ToString();
                }

                cmd1.Dispose();
                MySqlCommand cmd2 = new MySqlCommand("insert into vendor_goods (vendor_id,goods_id) values(@v_id, @g_id)", con);
                MySqlCommand cmd3 = new MySqlCommand("insert into vendor_services (vendor_id,service_id) values(@v_id, @s_id)", con);
                for (int i = 0; i < goods.Items.Count; i++)
                {
                    if (goods.Items[i].Selected == true)
                    {
                        cmd2.Parameters.Clear();
                        cmd2.Parameters.AddWithValue("@v_id", v_id);
                        cmd2.Parameters.AddWithValue("@g_id", goods.Items[i].Value);
                        cmd2.ExecuteNonQuery();
                    }
                }
                for (int i = 0; i < services.Items.Count; i++)
                {
                    if (services.Items[i].Selected == true)
                    {
                        cmd3.Parameters.Clear();
                        cmd3.Parameters.AddWithValue("@v_id", v_id);
                        cmd3.Parameters.AddWithValue("@s_id", services.Items[i].Value);
                        cmd3.ExecuteNonQuery();
                    }
                }
                con.Close();
                Response.Redirect("vendor_login.aspx");
            }
           
        }
    }
}