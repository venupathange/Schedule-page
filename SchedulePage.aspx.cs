using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Theorem.EOrg.Core.BAL;
using Theorem.EOrg.Core.DEO;
using Theorem.EOrg.StudentCore.BAL;
using Theorem.EOrg.StudentCore.DEO;
using Theorem.EOrg.Framework.Utilities;
using DbLinq.Factory;
using System.Data;
using CrystalDecisions.Web;
using CrystalDecisions.Shared;
using CrystalDecisions.Enterprise;
using CrystalDecisions.CrystalReports;
using CrystalDecisions.CrystalReports.Engine;
using BarCode;
using System.IO;
using System.Web.Services;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Services;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using OfficeOpenXml.Utils;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.ConditionalFormatting;
using OfficeOpenXml.VBA;
using OfficeOpenXml.Table;
using System.Drawing;
using System.Web.Security;

public partial class Admin_SchedulePage : System.Web.UI.Page
{
    UserManager objUserManager = null;
    AdminManager objAdminManager = null;


    Student objUsers = null;
    User objUser = null;
    Class objClass = null;
    StudentManager _studentMgr = null;
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindAcademicYear();
        }
    }

    private void BindAcademicYear()
    {
        CreateUserManagerInstance();
        CreateStudentManagerInstance();
        // Assuming GetAcademicYear() returns a DataSet.
        DataSet dsAdmissionYear = _studentMgr.GetAcademicYear();

        if (dsAdmissionYear != null && dsAdmissionYear.Tables.Count > 0 && dsAdmissionYear.Tables[0].Rows.Count > 0)
        {
            // Bind the DropDownList with proper Text and Value fields.
            ddlAcademicYear.DataSource = dsAdmissionYear.Tables[0];
            ddlAcademicYear.DataTextField = "Year";   // Field to display in the dropdown.
            ddlAcademicYear.DataValueField = "Id";    // Field used as the value for each item.
            ddlAcademicYear.DataBind();
        }
        else
        {
            // Handle scenario when no data is available.
            ddlAcademicYear.Items.Insert(0, new ListItem("No Academic Years Available", "0"));
        }
    }


    protected void btnSchedule_Click(object sender, EventArgs e)
    {
        CreateStudentManagerInstance();
        int Module = Convert.ToInt32(this.ddlmodule.SelectedValue);
        int Academicyear = Convert.ToInt32(this.ddlAcademicYear.SelectedValue);
        string startdate = this.startdate.Text == "" ? "-1" : this.startdate.Text;
        string withoutfinedate = this.withoutfinedate.Text == "" ? "-1" : this.withoutfinedate.Text;
        string Finedate = this.Finedate.Text == "" ? "-1" : this.Finedate.Text;

        // Call your method to get the schedule data
        DataSet dsSchedule = _studentMgr.GetSchedulePage(Academicyear, Module, startdate, withoutfinedate, Finedate);
        lblDatasetContent.Visible = true;
        lblDatasetContent.Text = "";

        foreach (DataTable table in dsSchedule.Tables)
        {
           // lblDatasetContent.Text += "Table: " + table.TableName + "<br/>";
            foreach (DataColumn column in table.Columns)
            {
                lblDatasetContent.Text += column.ColumnName + " | ";
            }
            lblDatasetContent.Text += "<br/>";

            foreach (DataRow row in table.Rows)
            {
                foreach (object item in row.ItemArray)
                {
                    lblDatasetContent.Text += item.ToString() + " | ";
                }
                lblDatasetContent.Text += "<br/>";
            }
            lblDatasetContent.Text += "<br/>";
        }
    }

    protected void ddlAcademicYear_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        
    }


    private void CreateUserInstance()
    {
        if (objUser == null)
            objUser = new User();
    }

    private void CreateUserManagerInstance()
    {
        if (objUserManager == null)
            objUserManager = new UserManager();
    }

    private void CreateAdminManagerInstance()
    {
        if (objAdminManager == null)
            objAdminManager = new AdminManager();
    }

    private void CreateStudentManagerInstance()
    {
        if (_studentMgr == null)
            _studentMgr = new StudentManager();
    }

}
