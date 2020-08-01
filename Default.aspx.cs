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
    public partial class _Default : Page
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        DataTable dTable = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL1();
                BindDDL3("select * from goods union all select * from services order by title asc", "goods_id","All Goods/Services");
                BindGrid();
            }

          
        }
        protected void gv1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv1.DataSource = ViewState["dTable"];
            gv1.PageIndex = e.NewPageIndex;
            gv1.DataBind();
        }
        private void BindDDL1()
        {
            ddl1.Enabled = false;
            ddl1.Items.Clear();
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
            ddl1.Items.Insert(0, new ListItem("All Department", "0"));
            ddl1.Enabled = true;
            cmd.Dispose();
            con.Close();
        }
        private void BindDDL3(string cmd,String arg,String arg1)
        {
            ddl3.Enabled = false;
            ddl3.Items.Clear();
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand all = new MySqlCommand(cmd, con);
            MySqlDataAdapter da1 = new MySqlDataAdapter();
            da1.SelectCommand = all;
            dTable.Clear();
            da1.Fill(dTable);
            ddl3.DataSource = dTable;
            ddl3.DataTextField = "title";
            ddl3.DataValueField = arg;
            ddl3.DataBind();
            ddl3.Items.Insert(0, new ListItem(arg1, "0"));
            ddl3.Enabled = true;
            all.Dispose();
            con.Close();
        }
        private void BindGrid()
        {
            gv1.EnableViewState = true;
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand grid = new MySqlCommand("select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where cancelled = 0 order by start_dt_tender_doc desc", con);
            MySqlDataAdapter dt = new MySqlDataAdapter();
            dt.SelectCommand = grid;
            dTable.Clear();
            dt.Fill(dTable);
            gv1.DataSource = dTable;
            gv1.DataBind();
            ViewState["dTable"] = dTable;
            grid.Dispose();
            con.Close();
        }
        private void BindGrid(String cmd)
        {
            gv1.EnableViewState = true;
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand grid = new MySqlCommand(cmd, con);
            MySqlDataAdapter dt = new MySqlDataAdapter();
            dt.SelectCommand = grid;
            dTable.Clear();
            dt.Fill(dTable);
            gv1.DataSource = dTable;
            gv1.DataBind();
            ViewState["dTable"] = dTable;
            grid.Dispose();
            con.Close();
        }
        private void BindGrid(String cmd,String arg)
        {
            gv1.EnableViewState = true;
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand grid = new MySqlCommand(cmd, con);
            grid.Parameters.AddWithValue("@arg", arg);
            MySqlDataAdapter dt = new MySqlDataAdapter();
            dt.SelectCommand = grid;
            dTable.Clear();
            dt.Fill(dTable);
            gv1.DataSource = dTable;
            gv1.DataBind();
            ViewState["dTable"] = dTable;
            grid.Dispose();
            con.Close();
        }
        private void BindGrid(String cmd, String arg1,String arg2)
        {
            gv1.EnableViewState = true;
            MySqlConnection con = new MySqlConnection(constr);
            con.Open();
            MySqlCommand grid = new MySqlCommand(cmd, con);
            grid.Parameters.AddWithValue("@arg1", arg1);
            grid.Parameters.AddWithValue("@arg2", arg2);
            MySqlDataAdapter dt = new MySqlDataAdapter();
            dt.SelectCommand = grid;
            dTable.Clear();
            dt.Fill(dTable);
            gv1.DataSource = dTable;
            gv1.DataBind();
            ViewState["dTable"] = dTable;
            grid.Dispose();
            con.Close();
        }
        protected void ddl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl2.SelectedValue == "0" && ddl3.SelectedValue == "0")
            {
                if (ddl1.SelectedValue == "0")
                {
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where cancelled = 0 order by start_dt_tender_doc desc";
                    BindGrid(cmd);
                }
                else if(ddl1.SelectedValue != "0")
                {
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where dpt_id = @arg && cancelled = 0 order by start_dt_tender_doc desc";
                    BindGrid(cmd, ddl1.SelectedValue.ToString());
                }
                
            }
            if (ddl2.SelectedValue != "0" && ddl3.SelectedValue == "0")
            {
                if (ddl1.SelectedValue == "0")
                {
                    
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                    
                }
                else if (ddl1.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.dpt_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl1.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.dpt_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl1.SelectedValue.ToString());
                    }
                }
            }
            if (ddl2.SelectedValue == "0" && ddl3.SelectedValue != "0")
            {
                if (ddl1.SelectedValue == "0")
                {
                   String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where c.goods_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                    BindGrid(cmd, ddl1.SelectedValue.ToString());
                }
                else if (ddl1.SelectedValue != "0")
                {
                   String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where c.goods_id = @arg1 && t.dpt_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                   BindGrid(cmd, ddl3.SelectedValue.ToString(), ddl1.SelectedValue.ToString());
                }
            }
            if(ddl2.SelectedValue != "0" && ddl3.SelectedValue != "0")
            {
                if (ddl1.SelectedValue == "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where c.goods_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl3.SelectedValue.ToString());

                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                       String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where c.service_id = @arg t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl3.SelectedValue.ToString());
                    }
                }
                else if (ddl1.SelectedValue != "0")
                {
                   String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where c.goods_id = @arg1 && t.dpt_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                   BindGrid(cmd, ddl3.SelectedValue.ToString(),ddl1.SelectedValue.ToString());
                }
            }
           up1.Update();
        }

        protected void ddl2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl1.SelectedValue == "0" && ddl3.SelectedValue == "0")
            {
                if (ddl2.SelectedValue == "0")
                {
                    BindDDL3("select * from goods union all select * from services order by title asc", "goods_id", "All Goods/Services");
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where cancelled = 0 order by start_dt_tender_doc desc";
                    BindGrid(cmd);
                }
                else if (ddl2.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        BindDDL1();
                        String cmd1 = "select * from goods order by title asc";
                        BindDDL3(cmd1, "goods_id","All Goods");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        BindDDL1();
                        String cmd1 = "select * from services order by title asc";
                        BindDDL3(cmd1, "service_id","All Services");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                }

            }
            if(ddl1.SelectedValue!="0" && ddl3.SelectedValue == "0")
            {
                if (ddl2.SelectedValue == "0")
                {
                    BindDDL3("select * from goods union all select * from services order by title asc", "goods_id", "All Goods/Services");
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where dpt_id = @arg && cancelled = 0 order by start_dt_tender_doc desc";
                    BindGrid(cmd, ddl1.SelectedValue.ToString());
                }
                else if (ddl2.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        BindDDL1();
                        String cmd1 = "select * from goods order by title asc";
                        BindDDL3(cmd1, "goods_id", "All Goods");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 && t.dpt_id=@arg order by t.start_dt_tender_doc desc";
                        BindGrid(cmd,ddl1.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        BindDDL1();
                        String cmd1 = "select * from services order by title asc";
                        BindDDL3(cmd1, "service_id", "All Services");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0  && t.dpt_id=@arg order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl1.SelectedValue.ToString());
                    }
                }
            }
            if (ddl1.SelectedValue == "0" && ddl3.SelectedValue != "0")
            {
                if (ddl2.SelectedValue == "0")
                {
                    BindDDL3("select * from goods union all select * from services order by title asc", "goods_id", "All Goods/Services");
                    String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where c.goods_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                    BindGrid(cmd, ddl3.SelectedValue.ToString());
                }
                else if (ddl2.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        BindDDL1();
                        String cmd1 = "select * from goods order by title asc";
                        BindDDL3(cmd1, "goods_id", "All Goods");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 && c.goods_id=@arg order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl3.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        BindDDL1();
                        String cmd1 = "select * from services order by title asc";
                        BindDDL3(cmd1, "service_id", "All Services");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0  && c.service_id=@arg order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl3.SelectedValue.ToString());
                    }
                }
            }
            if (ddl1.SelectedValue != "0" && ddl3.SelectedValue != "0")
            {
                if (ddl2.SelectedValue == "0")
                {
                    BindDDL3("select * from goods union all select * from services order by title asc", "goods_id", "All Goods/Services");
                    String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where t.dpt_id = @arg1 && c.goods_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                    BindGrid(cmd, ddl1.SelectedValue.ToString(),ddl3.SelectedValue.ToString());
                }
                else if (ddl2.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        BindDDL1();
                        String cmd1 = "select * from goods order by title asc";
                        BindDDL3(cmd1, "goods_id", "All Goods");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 && t.dpt_id = @arg1 && c.goods_id = @arg2 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl1.SelectedValue.ToString(), ddl3.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        BindDDL1();
                        String cmd1 = "select * from services order by title asc";
                        BindDDL3(cmd1, "service_id", "All Services");
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0 && t.dpt_id = @arg1 && c.service_id = @arg2 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd,ddl1.SelectedValue.ToString(), ddl3.SelectedValue.ToString());
                    }
                }
            }
            up1.Update();
        }

        protected void ddl3_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl1.SelectedValue == "0" && ddl2.SelectedValue == "0")
            {
                if (ddl3.SelectedValue == "0")
                {
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where cancelled = 0 order by start_dt_tender_doc desc";
                    BindGrid(cmd);
                }
                else if (ddl3.SelectedValue != "0")
                {
                   String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where c.goods_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                   BindGrid(cmd, ddl3.SelectedValue.ToString());
                }

            }
            if (ddl1.SelectedValue != "0" && ddl2.SelectedValue == "0")
            {
                if (ddl3.SelectedValue == "0")
                {
                    String cmd = "select tender_id,work_name,start_dt_tender_doc,end_dt_tender_doc from tender where cancelled = 0 && dpt_id = @arg order by start_dt_tender_doc desc";
                    BindGrid(cmd,ddl1.SelectedValue.ToString());
                }
                else if (ddl3.SelectedValue != "0")
                {
                    String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join (select * from tender_goods union all select * from tender_services) c on t.tender_id=c.tender_id where t.dpt_id = @arg1 && c.goods_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                    BindGrid(cmd,ddl1.SelectedValue.ToString(), ddl3.SelectedValue.ToString());
                }

            }
            if (ddl1.SelectedValue == "0" && ddl2.SelectedValue != "0")
            {
                if (ddl3.SelectedValue == "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                }
                else if (ddl3.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where c.goods_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd,ddl3.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where c.service_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd,ddl3.SelectedValue.ToString());
                    }
                }

            }
            if (ddl1.SelectedValue != "0" && ddl2.SelectedValue != "0")
            {
                if (ddl3.SelectedValue == "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.dpt_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd,ddl1.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.dpt_id = @arg && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                }
                else if (ddl3.SelectedValue != "0")
                {
                    if (ddl2.SelectedValue == "tender_goods")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_goods c on t.tender_id=c.tender_id where t.dpt_id = @arg1 && c.goods_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd, ddl1.SelectedValue.ToString());
                    }
                    else if (ddl2.SelectedValue == "tender_services")
                    {
                        String cmd = "select t.tender_id,t.work_name,t.start_dt_tender_doc,t.end_dt_tender_doc from tender t inner join tender_services c on t.tender_id=c.tender_id where t.dpt_id = @arg1 && c.service_id = @arg2 && t.cancelled = 0 order by t.start_dt_tender_doc desc";
                        BindGrid(cmd);
                    }
                }

            }
            up1.Update();
        }

        protected void gv1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

    }
}