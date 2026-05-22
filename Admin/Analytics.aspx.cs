using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_Analytics : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAnalytics();
        }
    }

    private void LoadAnalytics()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // ================= KPI COUNTS =================

            lblTotalIssues.Text = ExecuteScalar(con, "SELECT COUNT(*) FROM UserIssue");

            lblPending.Text = ExecuteScalar(con,
                "SELECT COUNT(*) FROM UserIssue WHERE Status='Pending'");

            lblInProgress.Text = ExecuteScalar(con,
                "SELECT COUNT(*) FROM UserIssue WHERE Status='In Progress'");

            lblCompleted.Text = ExecuteScalar(con,
                "SELECT COUNT(*) FROM UserIssue WHERE Status='Completed'");

            lblUsers.Text = ExecuteScalar(con,
                "SELECT COUNT(*) FROM Registration");

            lblDepartments.Text = ExecuteScalar(con,
                "SELECT COUNT(*) FROM Department");

            string avg = ExecuteScalar(con,
                "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0) FROM Feedback");

            lblAvgRating.Text = Math.Round(Convert.ToDouble(avg), 1).ToString();

            // ================= STORE STATUS DATA FOR PIE CHART =================

            hfPending.Value = lblPending.Text;
            hfInProgress.Value = lblInProgress.Text;
            hfCompleted.Value = lblCompleted.Text;

            // ================= ISSUES PER DEPARTMENT =================

            SqlCommand cmdDept = new SqlCommand(@"
                SELECT D.DepartmentType,
                       COUNT(UI.IssueID) AS TotalIssues
                FROM Department D
                LEFT JOIN UserIssue UI
                    ON D.DepartmentID = UI.DepartmentID
                GROUP BY D.DepartmentType", con);

            SqlDataReader dr = cmdDept.ExecuteReader();

            string labels = "";
            string counts = "";

            DataTable dt = new DataTable();
            dt.Load(dr);

            gvDeptIssues.DataSource = dt;
            gvDeptIssues.DataBind();

            foreach (DataRow row in dt.Rows)
            {
                labels += "'" + row["DepartmentType"].ToString() + "',";
                counts += row["TotalIssues"].ToString() + ",";
            }

            hfDeptLabels.Value = labels.TrimEnd(',');
            hfDeptCounts.Value = counts.TrimEnd(',');
        }
    }

    private string ExecuteScalar(SqlConnection con, string query)
    {
        SqlCommand cmd = new SqlCommand(query, con);
        object result = cmd.ExecuteScalar();
        return result != null ? result.ToString() : "0";
    }
}