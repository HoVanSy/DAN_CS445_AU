using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU.Admin
{
    public partial class QuanLyDanhMuc : System.Web.UI.Page
    {
        string connectionString = GetConnectionString();
        private int pageSize = 10;
        private int currentPage = 1;
        private string sortOrder = "name_asc";
        private string searchKeyword = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // XÓA HOẶC COMMENT PHẦN NÀY
            /*
            if (Session["RoleID"] == null || Session["RoleID"].ToString() != "1")
            {
                Response.Redirect("~/khach_hang/DangNhap.aspx");
                return;
            }
            */

            if (!IsPostBack)
            {
                ViewState["CurrentPage"] = 1;
                ViewState["SortOrder"] = "name_asc";
                ViewState["SearchKeyword"] = "";

                LoadCategories();
                LoadParentCategories();
            }
        }

        private static string GetConnectionString()
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["NongSanSachDB"];
                if (connString != null && !string.IsNullOrEmpty(connString.ConnectionString))
                {
                    return connString.ConnectionString;
                }
            }
            catch { }
            return null;
        }

        #region Load Data

        private void LoadCategories()
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                ShowMessage("Chưa cấu hình kết nối database", false);
                return;
            }

            try
            {
                currentPage = ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1;
                sortOrder = ViewState["SortOrder"] != null ? ViewState["SortOrder"].ToString() : "name_asc";
                searchKeyword = ViewState["SearchKeyword"] != null ? ViewState["SearchKeyword"].ToString() : "";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        WITH CategoryWithParent AS (
                            SELECT 
                                dm.dm_id,
                                dm.TieuDe,
                                dm.MoTa,
                                dm.SoLuong,
                                dm.parent_id,
                                parent.TieuDe as ParentName,
                                ROW_NUMBER() OVER (ORDER BY ";

                    // Thêm điều kiện sắp xếp
                    switch (sortOrder)
                    {
                        case "name_desc":
                            query += "dm.TieuDe DESC";
                            break;
                        case "quantity_asc":
                            query += "dm.SoLuong ASC";
                            break;
                        case "quantity_desc":
                            query += "dm.SoLuong DESC";
                            break;
                        default: // name_asc
                            query += "dm.TieuDe ASC";
                            break;
                    }

                    query += @") AS RowNum
                            FROM DanhMucSp dm
                            LEFT JOIN DanhMucSp parent ON dm.parent_id = parent.dm_id
                            WHERE 1=1";

                    // Thêm điều kiện tìm kiếm
                    if (!string.IsNullOrEmpty(searchKeyword))
                    {
                        query += " AND (dm.TieuDe LIKE @SearchKeyword OR dm.MoTa LIKE @SearchKeyword)";
                    }

                    query += @"
                        )
                        SELECT * FROM CategoryWithParent
                        WHERE RowNum BETWEEN @StartRow AND @EndRow";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    int startRow = (currentPage - 1) * pageSize + 1;
                    int endRow = currentPage * pageSize;

                    cmd.Parameters.AddWithValue("@StartRow", startRow);
                    cmd.Parameters.AddWithValue("@EndRow", endRow);

                    if (!string.IsNullOrEmpty(searchKeyword))
                    {
                        cmd.Parameters.AddWithValue("@SearchKeyword", "%" + searchKeyword + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvDanhMuc.DataSource = dt;
                    gvDanhMuc.DataBind();

                    // Load pagination info
                    LoadPaginationInfo();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi tải dữ liệu: " + ex.Message, false);
            }
        }

        private void LoadParentCategories()
        {
            if (string.IsNullOrEmpty(connectionString)) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT dm_id, TieuDe FROM DanhMucSp ORDER BY TieuDe";
                    SqlCommand cmd = new SqlCommand(query, conn);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlParentCategory.Items.Clear();
                    ddlParentCategory.Items.Add(new ListItem("-- Danh mục gốc --", ""));

                    while (reader.Read())
                    {
                        ddlParentCategory.Items.Add(new ListItem(
                            reader["TieuDe"].ToString(),
                            reader["dm_id"].ToString()
                        ));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi tải danh mục cha: " + ex.Message, false);
            }
        }

        private int GetTotalRecords()
        {
            if (string.IsNullOrEmpty(connectionString)) return 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM DanhMucSp WHERE 1=1";

                    if (!string.IsNullOrEmpty(searchKeyword))
                    {
                        query += " AND (TieuDe LIKE @SearchKeyword OR MoTa LIKE @SearchKeyword)";
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);

                    if (!string.IsNullOrEmpty(searchKeyword))
                    {
                        cmd.Parameters.AddWithValue("@SearchKeyword", "%" + searchKeyword + "%");
                    }

                    conn.Open();
                    return (int)cmd.ExecuteScalar();
                }
            }
            catch
            {
                return 0;
            }
        }

        private void LoadPaginationInfo()
        {
            int totalRecords = GetTotalRecords();
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            int startRecord = (currentPage - 1) * pageSize + 1;
            int endRecord = Math.Min(currentPage * pageSize, totalRecords);

            litPageInfo.Text = $"{startRecord}-{endRecord} của {totalRecords}";

            // Generate pagination links
            string paginationHtml = "";
            for (int i = 1; i <= totalPages; i++)
            {
                if (i == currentPage)
                {
                    paginationHtml += $@"
                        <span class='z-10 px-3 py-2 leading-tight text-[#111811] border border-primary bg-primary/20 dark:border-gray-700 dark:bg-primary/30 dark:text-white'>
                            {i}
                        </span>";
                }
                else
                {
                    paginationHtml += $@"
                        <a href='javascript:void(0)' onclick='__doPostBack(""PageLink"", ""{i}"")'
                           class='px-3 py-2 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-[#102210] dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white'>
                            {i}
                        </a>";
                }
            }
            litPagination.Text = paginationHtml;

            // Enable/Disable navigation buttons
            lnkPrevious.Enabled = currentPage > 1;
            lnkNext.Enabled = currentPage < totalPages;
        }

        #endregion

        #region Search & Sort

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            ViewState["SearchKeyword"] = txtSearch.Text.Trim();
            ViewState["CurrentPage"] = 1;
            LoadCategories();
        }

        protected void lnkFilterAll_Click(object sender, EventArgs e)
        {
            ViewState["SearchKeyword"] = "";
            txtSearch.Text = "";
            ViewState["CurrentPage"] = 1;
            LoadCategories();
        }

        protected void lnkSortName_Click(object sender, EventArgs e)
        {
            string currentSort = ViewState["SortOrder"].ToString();
            ViewState["SortOrder"] = currentSort == "name_asc" ? "name_desc" : "name_asc";
            ViewState["CurrentPage"] = 1;
            LoadCategories();
        }

        protected void lnkSortQuantity_Click(object sender, EventArgs e)
        {
            string currentSort = ViewState["SortOrder"].ToString();
            ViewState["SortOrder"] = currentSort == "quantity_asc" ? "quantity_desc" : "quantity_asc";
            ViewState["CurrentPage"] = 1;
            LoadCategories();
        }

        #endregion

        #region Pagination

        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            currentPage = (int)ViewState["CurrentPage"];
            if (currentPage > 1)
            {
                ViewState["CurrentPage"] = currentPage - 1;
                LoadCategories();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            currentPage = (int)ViewState["CurrentPage"];
            int totalPages = (int)Math.Ceiling((double)GetTotalRecords() / pageSize);

            if (currentPage < totalPages)
            {
                ViewState["CurrentPage"] = currentPage + 1;
                LoadCategories();
            }
        }

        // Handle page number click from JavaScript
        protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
        {
            if (eventArgument.StartsWith("PageLink"))
            {
                string[] args = eventArgument.Split(',');
                if (args.Length > 1)
                {
                    int pageNum;
                    if (int.TryParse(args[1], out pageNum))
                    {
                        ViewState["CurrentPage"] = pageNum;
                        LoadCategories();
                        return;
                    }
                }
            }
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }

        #endregion

        #region CRUD Operations

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ClearForm();
            litModalTitle.Text = "Thêm danh mục mới";
            hdnCategoryId.Value = "";
            pnlModal.Visible = true;
            LoadParentCategories();
        }

        protected void gvDanhMuc_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int categoryId = Convert.ToInt32(gvDanhMuc.DataKeys[e.NewEditIndex].Value);
            LoadCategoryForEdit(categoryId);
            pnlModal.Visible = true;
        }

        protected void gvDanhMuc_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get category ID from CommandArgument instead
            // This will be handled in RowCommand
        }

        protected void gvDanhMuc_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                LoadCategoryForEdit(categoryId);
                pnlModal.Visible = true;
            }
            else if (e.CommandName == "Delete")
            {
                DeleteCategory(categoryId);
            }
        }

        private void LoadCategoryForEdit(int categoryId)
        {
            if (string.IsNullOrEmpty(connectionString)) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM DanhMucSp WHERE dm_id = @CategoryId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hdnCategoryId.Value = categoryId.ToString();
                        txtTieuDe.Text = reader["TieuDe"].ToString();
                        txtMoTa.Text = reader["MoTa"].ToString();
                        txtSoLuong.Text = reader["SoLuong"].ToString();

                        LoadParentCategories();

                        if (reader["parent_id"] != DBNull.Value)
                        {
                            ddlParentCategory.SelectedValue = reader["parent_id"].ToString();
                        }

                        litModalTitle.Text = "Chỉnh sửa danh mục";
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi tải thông tin danh mục: " + ex.Message, false);
            }
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (string.IsNullOrEmpty(connectionString))
            {
                ShowMessage("Chưa cấu hình kết nối database", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query;
                    SqlCommand cmd;

                    if (string.IsNullOrEmpty(hdnCategoryId.Value))
                    {
                        // Insert new
                        query = @"INSERT INTO DanhMucSp (TieuDe, MoTa, SoLuong, parent_id) 
                                 VALUES (@TieuDe, @MoTa, @SoLuong, @ParentId)";
                        cmd = new SqlCommand(query, conn);
                    }
                    else
                    {
                        // Update existing
                        query = @"UPDATE DanhMucSp SET 
                                 TieuDe = @TieuDe,
                                 MoTa = @MoTa,
                                 SoLuong = @SoLuong,
                                 parent_id = @ParentId
                                 WHERE dm_id = @CategoryId";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@CategoryId", hdnCategoryId.Value);
                    }

                    cmd.Parameters.AddWithValue("@TieuDe", txtTieuDe.Text.Trim());
                    cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text.Trim());
                    cmd.Parameters.AddWithValue("@SoLuong", string.IsNullOrEmpty(txtSoLuong.Text) ? 0 : Convert.ToInt32(txtSoLuong.Text));

                    if (string.IsNullOrEmpty(ddlParentCategory.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@ParentId", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@ParentId", ddlParentCategory.SelectedValue);
                    }

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ShowMessage(string.IsNullOrEmpty(hdnCategoryId.Value) ?
                            "Thêm danh mục thành công!" :
                            "Cập nhật danh mục thành công!", true);

                        pnlModal.Visible = false;
                        ClearForm();
                        LoadCategories();
                    }
                    else
                    {
                        ShowMessage("Không thể lưu danh mục", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi: " + ex.Message, false);
            }
        }

        private void DeleteCategory(int categoryId)
        {
            if (string.IsNullOrEmpty(connectionString)) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Kiểm tra xem có danh mục con không
                    string checkQuery = "SELECT COUNT(*) FROM DanhMucSp WHERE parent_id = @CategoryId";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@CategoryId", categoryId);

                    conn.Open();
                    int childCount = (int)checkCmd.ExecuteScalar();

                    if (childCount > 0)
                    {
                        ShowMessage("Không thể xóa danh mục có danh mục con. Vui lòng xóa danh mục con trước!", false);
                        return;
                    }

                    // Kiểm tra xem có sản phẩm không
                    checkQuery = "SELECT COUNT(*) FROM SanPham WHERE dm_id = @CategoryId";
                    checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@CategoryId", categoryId);

                    int productCount = (int)checkCmd.ExecuteScalar();

                    if (productCount > 0)
                    {
                        ShowMessage($"Không thể xóa danh mục có {productCount} sản phẩm. Vui lòng xóa hoặc chuyển sản phẩm trước!", false);
                        return;
                    }

                    // Xóa danh mục
                    string deleteQuery = "DELETE FROM DanhMucSp WHERE dm_id = @CategoryId";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@CategoryId", categoryId);

                    int result = deleteCmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ShowMessage("Xóa danh mục thành công!", true);
                        LoadCategories();
                    }
                    else
                    {
                        ShowMessage("Không thể xóa danh mục", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi xóa danh mục: " + ex.Message, false);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
            ClearForm();
        }

        #endregion

        #region Helper Methods

        private void ClearForm()
        {
            hdnCategoryId.Value = "";
            txtTieuDe.Text = "";
            txtMoTa.Text = "";
            txtSoLuong.Text = "0";
            ddlParentCategory.SelectedIndex = 0;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isSuccess ?
                "mb-4 p-4 rounded-lg bg-green-100 text-green-700 border border-green-200" :
                "mb-4 p-4 rounded-lg bg-red-100 text-red-700 border border-red-200";

            pnlMessage.Controls.Clear();
            pnlMessage.Controls.Add(new LiteralControl(message));
        }

        #endregion
    }
}