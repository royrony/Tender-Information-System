using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;
using MySql.Data.Types;

namespace Tender
{
    public partial class add_tender : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        private int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {
                fu1.Enabled = false;
                id1.Visible = false;
                id2.Visible = false;
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand cmd = new MySqlCommand("select * from goods");
                cmd.Connection = con;
                MySqlDataReader sdr = cmd.ExecuteReader();
                ddl1.DataSource = sdr;
                ddl1.DataTextField = "title";
                ddl1.DataValueField = "goods_id";
                ddl1.DataBind();
                con.Close();
                MySqlConnection con1 = new MySqlConnection(constr);
                con1.Open();
                MySqlCommand cmd1 = new MySqlCommand("select * from services");
                cmd1.Connection = con1;
                MySqlDataReader sdr1 = cmd1.ExecuteReader();
                ddl2.DataSource = sdr1;
                ddl2.Items.Insert(0, "All Departments");
                ddl2.DataTextField = "title";
                ddl2.DataValueField = "service_id";
                ddl2.DataBind();
                ddl2.Items.Insert(0, "All Departments");
                con1.Close();
            }
            
        }
        
        protected void rb1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rb1.SelectedValue == "0")
            {
                id1.Visible = true;
                id2.Visible = false;
            }
            else if (rb1.SelectedValue == "1")
            {
                id2.Visible = true;
                id1.Visible = false;
            }
            else if (rb1.SelectedValue == "2")
            {
                id1.Visible = true;
                id2.Visible = true;
            }
            up1.Update();
        }

        protected void final_submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand t_id = new MySqlCommand("INSERT INTO tender_seq VALUES (NULL)",con);
                t_id.ExecuteNonQuery();
                t_id.Dispose();
                MySqlCommand get_t_id = new MySqlCommand("SELECT id FROM tender_seq ORDER BY id DESC LIMIT 1",con);
                MySqlDataReader sdr = get_t_id.ExecuteReader();
                if (sdr.Read())
                {
                    id = Convert.ToInt32(sdr["id"]);
                }
                get_t_id.Dispose();
                String tender_id = "TNDR" + id.ToString("D5");
                MySqlCommand cmd = new MySqlCommand("Insert into tender (tender_id,dpt_id,work_name,work_address,tender_ecp,duration,cp_name,cp_address,cp_tel,cp_email,doc_price,start_dt_tender_doc,end_dt_tender_doc,start_dt_bid,end_dt_bid,doc_downloadable,file_url,other_details,spcl_condition) values(@tender_id,@dpt_id,@work_name,@work_address,@tender_ecp,@duration,@cp_name,@cp_address,@cp_tel,@cp_email,@doc_price,@start_dt_tender_doc,@end_dt_tender_doc,@start_dt_bid,@end_dt_bid,@doc_downloadable,@file_url,@other_details,@spcl_condition)", con);
                String addr = street.Text + ", " + city.Text + ", " + state.Text + ", " + pincode.Text;
                int duration = (Convert.ToInt32(years.Text) * 12) + Convert.ToInt32(months.Text);
                DateTime dt1 = Convert.ToDateTime(start_dt_sale.Text);
                DateTime dt2 = Convert.ToDateTime(end_dt_sale.Text);
                DateTime dt3 = Convert.ToDateTime(start_dt_bid.Text);
                DateTime dt4 = Convert.ToDateTime(end_dt_bid.Text);
                cmd.Parameters.AddWithValue("@tender_id", tender_id);
                cmd.Parameters.AddWithValue("@dpt_id", Session["dpt_id"]);
                cmd.Parameters.AddWithValue("@work_name", name.Text);
                cmd.Parameters.AddWithValue("@work_address", addr);
                cmd.Parameters.AddWithValue("@tender_ecp", ecp.Text);
                cmd.Parameters.AddWithValue("@duration", Convert.ToString(duration));
                cmd.Parameters.AddWithValue("@cp_name", cp_name.Text);
                cmd.Parameters.AddWithValue("@cp_address", cp_address.Text);
                cmd.Parameters.AddWithValue("@cp_tel", cp_phone.Text);
                cmd.Parameters.AddWithValue("@cp_email", cp_email.Text);
                cmd.Parameters.AddWithValue("@doc_price", price_doc.Text);
                cmd.Parameters.AddWithValue("@start_dt_tender_doc", dt1.ToString("yyyy-MM-dd hh:mm:ss"));
                cmd.Parameters.AddWithValue("@end_dt_tender_doc", dt2.ToString("yyyy-MM-dd hh:mm:ss"));
                cmd.Parameters.AddWithValue("@start_dt_bid", dt3.ToString("yyyy-MM-dd hh:mm:ss"));
                cmd.Parameters.AddWithValue("@end_dt_bid", dt4.ToString("yyyy-MM-dd hh:mm:ss"));
                cmd.Parameters.AddWithValue("@doc_downloadable", rb2.SelectedValue);
                if (rb2.SelectedValue == "0")
                {
                    String f_name = tender_id + ".pdf";
                    cmd.Parameters.AddWithValue("@file_url", f_name);
                }
                else if (rb2.SelectedValue == "1")
                {
                    String f_name = null;
                    cmd.Parameters.AddWithValue("@file_url", f_name);
                }
                cmd.Parameters.AddWithValue("@other_details", other_details.Text);
                cmd.Parameters.AddWithValue("@spcl_condition", spcl_cond.Text);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                if ((fu1.PostedFile != null) && (fu1.PostedFile.ContentLength > 0))
                {
                    string fn = System.IO.Path.GetFileName(fu1.PostedFile.FileName);
                    string SaveLocation = Server.MapPath("tender_pdf") + "\\";
                    try
                    {
                        fu1.PostedFile.SaveAs(SaveLocation + tender_id + ".pdf");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }
                }
                if (rb1.SelectedValue == "0")
                {
                    MySqlCommand goods = new MySqlCommand("INSERT INTO tender_goods(tender_id,goods_id) values(@tender_id,@goods_id)", con);
                    goods.Parameters.AddWithValue("@tender_id", tender_id);
                    goods.Parameters.AddWithValue("@goods_id", ddl1.SelectedValue);
                    goods.ExecuteNonQuery();
                    goods.Dispose();
                }
                else if (rb1.SelectedValue == "1")
                {
                    MySqlCommand services = new MySqlCommand("INSERT INTO tender_services(tender_id,service_id) values(@tender_id,@service_id)", con);
                    services.Parameters.AddWithValue("@tender_id", tender_id);
                    services.Parameters.AddWithValue("@service_id", ddl2.SelectedValue);
                    services.ExecuteNonQuery();
                    services.Dispose();
                }
                else if (rb1.SelectedValue == "2")
                {
                    MySqlCommand goods = new MySqlCommand("INSERT INTO tender_goods(tender_id,goods_id) values(@tender_id,@goods_id)", con);
                    goods.Parameters.AddWithValue("@tender_id", tender_id);
                    goods.Parameters.AddWithValue("@goods_id", ddl1.SelectedValue);
                    goods.ExecuteNonQuery();
                    goods.Dispose();
                    MySqlCommand services = new MySqlCommand("INSERT INTO tender_services(tender_id,services_id) values(@tender_id,@service_id)", con);
                    services.Parameters.AddWithValue("@tender_id", tender_id);
                    services.Parameters.AddWithValue("@service_id", ddl2.SelectedValue);
                    services.ExecuteNonQuery();
                    services.Dispose();
                }
                if((!string.IsNullOrEmpty(goods_emd.Text)) && (!string.IsNullOrWhiteSpace(goods_emd.Text)) && (!string.IsNullOrEmpty(services_emd.Text)) && (!string.IsNullOrWhiteSpace(services_emd.Text)))
                {
                    MySqlCommand emd = new MySqlCommand("INSERT INTO emd(tender_id,emd_goods,emd_service) values(@tender_id,@emd_goods,@emd_service)", con);
                    emd.Parameters.AddWithValue("@tender_id", tender_id);
                    emd.Parameters.AddWithValue("@emd_goods", goods_emd.Text);
                    emd.Parameters.AddWithValue("@emd_service", services_emd.Text);
                    emd.ExecuteNonQuery();
                    emd.Dispose();
                }
                else if((!string.IsNullOrEmpty(goods_emd.Text)) && (!string.IsNullOrWhiteSpace(goods_emd.Text)) && (string.IsNullOrEmpty(services_emd.Text)) && (string.IsNullOrWhiteSpace(services_emd.Text))){
                    MySqlCommand emd = new MySqlCommand("INSERT INTO emd(tender_id,emd_goods) values(@tender_id,@emd_goods)", con);
                    emd.Parameters.AddWithValue("@tender_id", tender_id);
                    emd.Parameters.AddWithValue("@emd_goods", goods_emd.Text);
                    emd.ExecuteNonQuery();
                    emd.Dispose();
                }
                else if ((string.IsNullOrEmpty(goods_emd.Text)) && (string.IsNullOrWhiteSpace(goods_emd.Text)) && (!string.IsNullOrEmpty(services_emd.Text)) && (!string.IsNullOrWhiteSpace(services_emd.Text)))
                {
                    MySqlCommand emd = new MySqlCommand("INSERT INTO emd(tender_id,emd_service) values(@tender_id,@emd_service)", con);
                    emd.Parameters.AddWithValue("@tender_id", tender_id);
                    emd.Parameters.AddWithValue("@emd_service", services_emd.Text);
                    emd.ExecuteNonQuery();
                    emd.Dispose();
                }
                Response.Redirect("default.aspx");
            }
        }

        protected void rb2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(rb2.SelectedValue == "1")
            {
                fu1.Enabled = false;
            }
            else if (rb2.SelectedValue == "0")
            { fu1.Enabled = true; }
        }
    }
}