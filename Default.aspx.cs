using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ClassCheck cs = new ClassCheck();
        cs.lis(Server.MapPath("MasterPage.master"), Server.MapPath("MasterPage.master.cs"), Server.MapPath("web.config"));


    }
}