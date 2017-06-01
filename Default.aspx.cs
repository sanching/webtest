using Seller.Utility;
using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridViewFiles.Visible = false;
        LabelTxt.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        GridViewFiles.DataSource = GetData();
        GridViewFiles.DataBind();
        GridViewFiles.Visible = true;
    }

    protected void ImageButtonExportExcelTop_Click(object sender, EventArgs e)
    {
        // 取得轉出資料表頭				
        string[] headers = {"磁碟槽", "檔案名稱", "檔案路徑", "容量(Byte)", "目錄路徑"};
        DataTable dt = new DataTable();
        DataColumn dc = new DataColumn("FilePatch", typeof (string));
        dt.Columns.Add(dc);
        dc = new DataColumn("Name", typeof (string));
        dt.Columns.Add(dc);
        dc = new DataColumn("FullPath", typeof (string));
        dt.Columns.Add(dc);
        dc = new DataColumn("Size", typeof (int));
        dt.Columns.Add(dc);
        dc = new DataColumn("DirectoryName", typeof(string));
        dt.Columns.Add(dc);

        DataRow dr = dt.NewRow();

        if (GetData() == null)
        {
            return;
        }

        foreach (var item in GetData())
        {
            dt.Rows.Add(item.FileDisk, item.Name, item.FullPath, item.Size, item.DirectoryName);
        }

        //刪除欄位
        headers[4] = string.Empty;
        dt.Columns.Remove("DirectoryName");

        // 轉出資料
        var export = Factory.CreateExportToExcel();
        var excel = export.ExportExcel("files", headers, dt);

        Response.Clear();
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        Response.AddHeader("Content-Disposition", "attachment; filename=files.xlsx");
        Response.Buffer = true;
        Response.BinaryWrite(excel);
        Response.Flush();
        Response.End();
    }

    public List<fileEmtity> GetData()
    {
        List<fileEmtity> total = new List<fileEmtity>();

        try
        {
            DirectoryInfo dirPath = new DirectoryInfo(RadioButtonDisk.SelectedValue.ToString() + ":\\" + TextBoxFilePath.Text + "\\");

            foreach (var dir in dirPath.EnumerateDirectories())
            {
                foreach (var file in dir.EnumerateFiles(".", SearchOption.AllDirectories))
                {
                    total.Add(
                        new fileEmtity()
                        {
                            FileDisk = file.FullName.Substring(0, 1),
                            Name = file.Name,
                            FullPath = file.FullName,
                            Size = (int) file.Length,
                            DirectoryName = file.DirectoryName
                        }
                    );
                }

				LabelTxt.Visible = false;
			}

            return total;
        }
        catch (Exception)
        {
            LabelTxt.Visible = true;
            LabelTxt.Text = "目錄不存在或是輸入格式不正確";
            return null;
        }
    }
}
