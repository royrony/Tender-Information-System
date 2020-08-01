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
    public partial class vendor_login : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        DataTable dTable = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MySqlConnection con = new MySqlConnection(constr);
                con.Open();
                MySqlCommand cmd = new MySqlCommand("select * from department");
                cmd.Connection = con;
                MySqlDataAdapter da = new MySqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(dTable);
                ddl1.DataSource = dTable;
                ddl1.DataTextField = "dpt_name";
                ddl1.DataValueField = "dpt_id";
                ddl1.DataBind();
                ddl1.Enabled = true;
                cmd.Dispose();
                MySqlCommand all = new MySqlCommand("select * from goods union all select * from services order by title asc", con);
                MySqlDataAdapter da1 = new MySqlDataAdapter();
                da1.SelectCommand = all;
                dTable.Clear();
                da1.Fill(dTable);
                ddl3.DataSource = dTable;
                ddl3.DataTextField = "title";
                ddl3.DataValueField = "goods_id";
                ddl3.DataBind();
                ddl3.Enabled = true;
                all.Dispose();
                con.Close();
            }
           
        }
        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }
        protected void ddl2_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            ddl3.Enabled = false;
            ddl3.Items.Clear();
            ddl3.Items.Insert(0, new ListItem("Select State", "0"));
            ddl1.Enabled = false;
            ddl1.Items.Clear();
            ddl1.Items.Insert(0, new ListItem("Select State", "0"));
            MySqlConnection conn = new MySqlConnection(constr);
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("select * from department",conn);
            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = cmd;
            dTable.Clear();
            da.Fill(dTable);
            ddl1.DataSource = dTable;
            ddl1.DataTextField = "dpt_name";
            ddl1.DataValueField = "dpt_id";
            ddl1.DataBind();
            ddl1.Enabled = true;
            cmd.Dispose();
            MySqlCommand all = new MySqlCommand("select * from goods order by title asc", conn);
            MySqlDataAdapter da1 = new MySqlDataAdapter();
            da1.SelectCommand = all;
            dTable.Clear();
            da1.Fill(dTable);
            ddl3.DataSource = dTable;
            ddl3.DataTextField = "title";
            ddl3.DataValueField = "goods_id";
            ddl3.DataBind();
            ddl3.Enabled = true;
            all.Dispose();
            conn.Close();

        }
    }
}